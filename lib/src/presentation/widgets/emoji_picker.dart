import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MyEmojiPicker extends StatelessWidget {
  const MyEmojiPicker({super.key, required this.onSelected});
  final Function(String) onSelected;

  @override
  Widget build(BuildContext context) {
    return EmojiPicker(
      onEmojiSelected: (category, emoji) {
        onSelected(emoji.emoji);
        context.pop();
      },
      config: Config(
        bottomActionBarConfig: BottomActionBarConfig(
          backgroundColor: Theme.of(context).colorScheme.primary,
          showBackspaceButton: false,
          customBottomActionBar: (config, state, showSearchView) {
            return Container(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: Icon(Icons.search, color: Colors.white),
                    onPressed: () {
                      showSearchView();
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.close, color: Colors.white),
                    onPressed: () {
                      context.pop();
                    },
                  ),
                ],
              ),
            );
          },
        ),
        emojiViewConfig: EmojiViewConfig(
          backgroundColor: Theme.of(context).colorScheme.surface,
        ),
        height: 400,
        viewOrderConfig: ViewOrderConfig(
          bottom: EmojiPickerItem.categoryBar,
          middle: EmojiPickerItem.emojiView,
          top: EmojiPickerItem.searchBar
        ),
        categoryViewConfig: CategoryViewConfig(
          backgroundColor: Theme.of(context).colorScheme.surface,
          indicatorColor: Theme.of(context).colorScheme.primary,
          initCategory: Category.SMILEYS
        ),
        searchViewConfig: SearchViewConfig(
          backgroundColor: Theme.of(context).colorScheme.surface,
          buttonIconColor: Theme.of(context).colorScheme.onSurface
        ),
      ),
    );
  }
}
