import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:wildfire/src/data/models/user_model.dart';
import 'package:wildfire/src/providers/user_provider.dart';

class NameEdit extends ConsumerWidget {
  const NameEdit({super.key, required this.user});
  final User user;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nameController = TextEditingController();
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return ListTile(
      title: Text(
        'Name',
        style: textTheme.labelLarge?.copyWith(color: colorScheme.onSurfaceVariant),
      ),
      subtitle: Text(
        user.name,
        style: textTheme.bodyLarge?.copyWith(color: colorScheme.onSurfaceVariant)
      ),
      leading: Icon(Icons.person, color: colorScheme.secondary),
      trailing: Icon(Icons.edit, color: colorScheme.secondary),
      onTap: () {
        nameController.text = user.name;
        nameController.selection = TextSelection(baseOffset: 0, extentOffset: user.name.length);
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.zero)
          ),
          builder: (context) {
            return Padding(
              padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Container(
                padding: const EdgeInsets.all(40),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextField(
                      decoration: const InputDecoration(
                        labelText: 'Name',
                      ),
                      controller: nameController,
                      autofocus: true,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () {
                            context.pop();
                          },
                          child: const Text('Cancel'),
                        ),
                        const SizedBox(width: 10),
                        TextButton(
                          onPressed: () {
                            ref.read(currUserProvider.notifier)
                               .updateName(nameController.text);
                            context.pop();
                          },
                          child: const Text('Save'),
                        )
                      ],
                    )
                  ],
                ),
              ),
            );
          }
        );
      },
    );
  }
}
