import 'package:flutter/material.dart';

import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gemini_app/presentation/providers/chat/basic_chat.dart';
import 'package:gemini_app/presentation/providers/chat/is_gemini_writing.dart';

import 'package:gemini_app/presentation/providers/users/user_provider.dart';
import 'package:gemini_app/presentation/widgets/chat/custom_bottom_input.dart';
import 'package:image_picker/image_picker.dart';

class BasicPromptScreen extends ConsumerWidget {
  const BasicPromptScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final geminiUser = ref.watch(geminiUserProvider);
    final user = ref.watch(userProvider);
    final isGeminiWriting = ref.watch(isGeminiWritingProvider);
    final basicChat = ref.watch(basicChatProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Basic Prompt')),
      body: Chat(
        messages: basicChat,
        onSendPressed: (types.PartialText message) {
          // final text = message.text;
          // ref
          //     .read(basicChatProvider.notifier)
          //     .addMessage(
          //       partialText: types.PartialText(text: text),
          //       user: user,
          //     );
        },
        user: user,
        theme: DarkChatTheme(),
        showUserNames: true,
        showUserAvatars: true,
        customBottomWidget: CustomBottomInput(
          onSend:
              (
                types.PartialText partialText, {
                List<XFile> images = const [],
              }) async {
                ref
                    .read(basicChatProvider.notifier)
                    .addMessage(
                      partialText: types.PartialText(text: partialText.text),
                      user: user,
                      images: images,
                    );
                // ImagePicker picker = ImagePicker();
                // final List<XFile> images = await picker.pickMultiImage(
                //   limit: 4,
                // );
                // if (images.isEmpty) return;

                // print(images);
              },
          onAttachmentPressed: () {},
        ),
        typingIndicatorOptions: TypingIndicatorOptions(
          typingUsers: isGeminiWriting ? [geminiUser] : [],
        ),
      ),
    );
  }
}
