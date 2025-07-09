import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:gemini_app/config/gemini/gemini_impl.dart';
import 'package:uuid/uuid.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:gemini_app/presentation/providers/chat/is_gemini_writing.dart';
import 'package:gemini_app/presentation/providers/users/user_provider.dart';

part 'basic_chat.g.dart';

@riverpod
class BasicChat extends _$BasicChat {
  final GeminiImpl geminiImpl = GeminiImpl();

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
    final response = await geminiImpl.getResponse(prompt);
    isWriting.setIsNotWriting();

    final message = types.TextMessage(
      author: geminiUser,
      id: Uuid().v4(),
      text: response,
      createdAt: DateTime.now().millisecondsSinceEpoch,
    );

    state = [message, ...state];
  }
}
