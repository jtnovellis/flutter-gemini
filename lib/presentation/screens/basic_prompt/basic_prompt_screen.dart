import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gemini_app/presentation/providers/user_provider.dart';
import 'package:uuid/uuid.dart';

final user = types.User(
  id: Uuid().v4(),
  firstName: 'Jairo',
  lastName: 'Toro',
  imageUrl: 'https://i.pravatar.cc/300?u=1',
);

class BasicPromptScreen extends ConsumerWidget {
  const BasicPromptScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final geminiUser = ref.watch(geminiUserProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Basic Prompt')),
      body: Chat(
        messages: [],
        onSendPressed: (types.PartialText message) {
          final text = message.text;
          print(text);
        },
        user: user,
        theme: DarkChatTheme(),
        showUserNames: true,
        showUserAvatars: true,
        typingIndicatorOptions: TypingIndicatorOptions(
          typingUsers: [geminiUser],
        ),
      ),
    );
  }
}
