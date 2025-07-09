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
  late final types.User geminiUser;

  @override
  List<types.Message> build() {
    geminiUser = ref.read(geminiUserProvider);
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
    _createTextMessage(partialText, user);
  }

  Future<void> _geminiTextResponse(String prompt) async {
    _setGeminiWritingStatus(true);
    final response = await geminiImpl.getResponse(prompt);
    _setGeminiWritingStatus(false);
    _createTextMessage(types.PartialText(text: response), geminiUser);
  }

  void _setGeminiWritingStatus(bool isWriting) {
    final isGeminiWriting = ref.read(isGeminiWritingProvider.notifier);
    isWriting
        ? isGeminiWriting.setIsWriting()
        : isGeminiWriting.setIsNotWriting();
  }

  void _createTextMessage(types.PartialText partialText, types.User user) {
    final message = types.TextMessage(
      author: user,
      id: Uuid().v4(),
      text: partialText.text,
      createdAt: DateTime.now().millisecondsSinceEpoch,
    );

    state = [message, ...state];
  }
}
