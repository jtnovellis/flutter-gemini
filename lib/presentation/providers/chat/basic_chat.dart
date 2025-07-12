import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:gemini_app/config/gemini/gemini_impl.dart';
import 'package:image_picker/image_picker.dart';
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
    List<XFile> images = const [],
  }) {
    if (images.isNotEmpty) {
      _addTextMessagesWithImages(partialText, user, images);
      return;
    }
    _addTextMessage(partialText, user);
    _geminiStreamResponse(partialText.text);
  }

  void _addTextMessage(types.PartialText partialText, types.User user) {
    _createTextMessage(partialText, user);
  }

  void _addTextMessagesWithImages(
    types.PartialText partialText,
    types.User user,
    List<XFile> images,
  ) async {
    for (final image in images) {
      _createImageMessage(image, user);
    }
    await Future.delayed(const Duration(seconds: 1));
    _createTextMessage(partialText, user);
    _geminiStreamResponse(partialText.text, images: images);
  }

  // Future<void> _geminiTextResponse(String prompt) async {
  //   _setGeminiWritingStatus(true);
  //   final response = await geminiImpl.getResponse(prompt);
  //   _setGeminiWritingStatus(false);
  //   _createTextMessage(types.PartialText(text: response), geminiUser);
  // }

  Future<void> _geminiStreamResponse(
    String prompt, {
    List<XFile> images = const [],
  }) async {
    _setGeminiWritingStatus(true);
    _createTextMessage(
      types.PartialText(text: 'Gemini is thinking...'),
      geminiUser,
    );

    geminiImpl.getStreamResponse(prompt, files: images).listen((data) {
      if (data.isEmpty) return;
      final updatedMessages = [...state];
      final firstMessage = (updatedMessages.first as types.TextMessage)
          .copyWith(text: data);
      updatedMessages[0] = firstMessage;
      state = updatedMessages;
    });
    _setGeminiWritingStatus(false);
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

  void _createImageMessage(XFile image, types.User user) async {
    final message = types.ImageMessage(
      author: user,
      id: Uuid().v4(),
      name: image.name,
      size: await image.length(),
      uri: image.path,
      createdAt: DateTime.now().millisecondsSinceEpoch,
    );

    state = [message, ...state];
  }
}
