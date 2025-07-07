import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:gemini_app/presentation/providers/chat/is_gemini_writing.dart';
import 'package:gemini_app/presentation/providers/users/user_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

part 'basic_chat.g.dart';

@riverpod
class BasicChat extends _$BasicChat {
  @override
  List<types.Message> build() {
    return [];
  }

  void addMessage({
    required types.PartialText partialText,
    required types.User user,
  }) {
    _addTextMessage(partialText, user);
    _geminiTextResponse(partialText.text);
  }

  void _addTextMessage(types.PartialText partialText, types.User user) {
    final message = types.TextMessage(
      author: user,
      id: Uuid().v4(),
      text: partialText.text,
      createdAt: DateTime.now().millisecondsSinceEpoch,
    );

    state = [message, ...state];
  }

  Future<void> _geminiTextResponse(String prompt) async {
    final geminiUser = ref.read(geminiUserProvider);
    final isWriting = ref.read(isGeminiWritingProvider.notifier);
    isWriting.setIsWriting();
    await Future.delayed(const Duration(seconds: 2));
    isWriting.setIsNotWriting();

    final message = types.TextMessage(
      author: geminiUser,
      id: Uuid().v4(),
      text: 'Hello world from gemini $prompt',
      createdAt: DateTime.now().millisecondsSinceEpoch,
    );

    state = [message, ...state];
  }
}
