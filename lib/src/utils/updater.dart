import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:package_info_plus/package_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:open_filex/open_filex.dart';
import 'package:permission_handler/permission_handler.dart';

class AppUpdater {
  final String githubUsername;
  final String githubRepo;
  
  AppUpdater({
    required this.githubUsername,
    required this.githubRepo,
  });
  
  // Get latest release info from GitHub
  Future<Map<String, dynamic>?> getLatestReleaseInfo() async {
    try {
      final response = await http.get(
        Uri.parse("https://api.github.com/repos/$githubUsername/$githubRepo/releases/latest"),
        headers: {'Accept': 'application/vnd.github.v3+json'},
      ).timeout(const Duration(seconds: 10));
      
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else if (response.statusCode == 403) {
        debugPrint('GitHub API rate limit exceeded');
        return null;
      } else {
        debugPrint('Failed to get latest version. Status code: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      debugPrint('Error fetching latest version: $e');
      return null;
    }
  }
  
  // Compare semantic versions (1.2.0 vs 1.10.0)
  bool isNewerVersion(String current, String latest) {
    // Remove 'v' prefix if present
    current = current.startsWith('v') ? current.substring(1) : current;
    latest = latest.startsWith('v') ? latest.substring(1) : latest;
    
    final currentParts = current.split('.').map(int.parse).toList();
    final latestParts = latest.split('.').map(int.parse).toList();
    
    // Compare major version
    if (latestParts[0] > currentParts[0]) return true;
    if (latestParts[0] < currentParts[0]) return false;
    
    // Compare minor version
    if (latestParts.length > 1 && currentParts.length > 1) {
      if (latestParts[1] > currentParts[1]) return true;
      if (latestParts[1] < currentParts[1]) return false;
    }
    
    // Compare patch version
    if (latestParts.length > 2 && currentParts.length > 2) {
      if (latestParts[2] > currentParts[2]) return true;
    }
    
    return false;
  }
  
  // Check if update is available
  Future<UpdateInfo?> checkForUpdate() async {
    try {
      final releaseInfo = await getLatestReleaseInfo();
      if (releaseInfo == null) return null;
      
      final latestVersion = releaseInfo['tag_name'] as String;
      final packageInfo = await PackageInfo.fromPlatform();
      final currentVersion = packageInfo.version;
      
      if (isNewerVersion(currentVersion, latestVersion)) {
        // Find APK asset
        final assets = releaseInfo['assets'] as List;
        final apkAsset = assets.firstWhere(
          (asset) => asset['name'].toString().endsWith('.apk'),
          orElse: () => null,
        );
        
        if (apkAsset != null) {
          return UpdateInfo(
            currentVersion: currentVersion,
            newVersion: latestVersion,
            releaseNotes: releaseInfo['body'] ?? 'No release notes available',
            downloadUrl: apkAsset['browser_download_url'],
          );
        }
      }
      return null;
    } catch (e) {
      debugPrint('Error checking for updates: $e');
      return null;
    }
  }
  
Future<bool> _requestStoragePermission() async {
  if (Platform.isAndroid) {
    if (await Permission.storage.isGranted) {
      return true;
    }
    
    // Request multiple permissions
    Map<Permission, PermissionStatus> statuses = await [
      Permission.storage,
      Permission.manageExternalStorage,
    ].request();
    
    // Check if storage permission is granted
    return statuses[Permission.storage]?.isGranted == true || 
           statuses[Permission.manageExternalStorage]?.isGranted == true;
  }
  return true; // iOS doesn't need this permission
}

  // Download and install APK
  Future<bool> downloadAndInstallUpdate(String downloadUrl, {
    Function(double)? onProgress,
    Function(String)? onError,
  }) async {
    try {
      // Request permission first
      final hasPermission = await _requestStoragePermission();
      if (!hasPermission) {
        onError?.call('Storage permission denied. Please grant permission in app settings.');
        // Optionally open app settings
        await openAppSettings();
        return false;
      }
      
      // Try this approach instead
      Directory? dir;
      if (Platform.isAndroid) {
        // Use the downloads directory which might have different permissions
        dir = await getExternalStorageDirectory();
        if (dir == null) {
          // Fall back to internal storage
          dir = await getApplicationDocumentsDirectory();
        }
      } else {
        dir = await getApplicationDocumentsDirectory();
      }
      
      final filePath = "${dir.path}/update.apk";
      
      // Download with progress tracking
      await Dio().download(
        downloadUrl, 
        filePath,
        options: Options(
          responseType: ResponseType.bytes,
        ),
        onReceiveProgress: (received, total) {
          if (total != -1) {
            final progress = received / total;
            onProgress?.call(progress);
          }
        },
      );
      
      // Open file for installation
      final result = await OpenFilex.open(filePath);
      return result.type == ResultType.done;
    } catch (e) {
      onError?.call('Failed to download update: $e');
      return false;
    }
  }
  
  // Show update dialog to user
  void showUpdateDialog(BuildContext context, UpdateInfo updateInfo) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text("Update Available"),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Version ${updateInfo.newVersion} is available!"),
              const SizedBox(height: 8),
              Text("You have: ${updateInfo.currentVersion}"),
              const SizedBox(height: 16),
              Text("What's new:"),
              const SizedBox(height: 4),
              Text(updateInfo.releaseNotes, style: const TextStyle(fontSize: 14)),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Later"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              startUpdateProcess(context, updateInfo.downloadUrl);
            },
            child: const Text("Update"),
          ),
        ],
      ),
    );
  }
  
  // Start the update process using a dedicated page (more reliable than dialog)
  void startUpdateProcess(BuildContext context, String downloadUrl) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => UpdatePage(
          appUpdater: this,
          downloadUrl: downloadUrl,
        ),
      ),
    );
  }
}

// Class to hold update information
class UpdateInfo {
  final String currentVersion;
  final String newVersion;
  final String releaseNotes;
  final String downloadUrl;
  
  UpdateInfo({
    required this.currentVersion,
    required this.newVersion, 
    required this.releaseNotes,
    required this.downloadUrl,
  });
}

// Update page for handling download and installation
class UpdatePage extends StatefulWidget {
  final AppUpdater appUpdater;
  final String downloadUrl;
  
  const UpdatePage({
    Key? key, 
    required this.appUpdater,
    required this.downloadUrl,
  }) : super(key: key);
  
  @override
  State<UpdatePage> createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {
  double progress = 0.0;
  String error = '';
  bool isComplete = false;
  
  @override
  void initState() {
    super.initState();
    _startDownload();
  }
  
  Future<void> _startDownload() async {
    try {
      final success = await widget.appUpdater.downloadAndInstallUpdate(
        widget.downloadUrl,
        onProgress: (value) {
          setState(() {
            progress = value;
          });
        },
        onError: (message) {
          setState(() {
            error = message;
          });
        },
      );
      
      setState(() {
        isComplete = true;
      });
      
      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Update installation started')),
        );
        
        // Close page after delay
        Future.delayed(const Duration(seconds: 1), () {
          if (mounted) {
            Navigator.of(context).pop();
          }
        });
      }
    } catch (e) {
      setState(() {
        error = e.toString();
      });
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Updating App'),
        automaticallyImplyLeading: error.isNotEmpty || isComplete,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: error.isNotEmpty
              ? Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.error_outline, color: Colors.red, size: 48),
                    const SizedBox(height: 16),
                    Text('Error: $error', 
                      style: const TextStyle(color: Colors.red), 
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('Close'),
                    ),
                  ],
                )
              : Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Downloading Update',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 24),
                    LinearProgressIndicator(value: progress),
                    const SizedBox(height: 16),
                    Text("${(progress * 100).toStringAsFixed(0)}%"),
                  ],
                ),
        ),
      ),
    );
  }
}

// Example usage in your app
void checkForAppUpdates(BuildContext context) async {
  final appUpdater = AppUpdater(
    githubUsername: 'SanthiKumarYadavalli',
    githubRepo: 'wildfire',
  );
  
  final updateInfo = await appUpdater.checkForUpdate();
  if (updateInfo != null) {
    appUpdater.showUpdateDialog(context, updateInfo);
  }
}