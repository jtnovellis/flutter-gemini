import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_provider.g.dart';

@riverpod
types.User geminiUser(Ref ref) {
  final geminiUser = types.User(
    id: 'user-2',
    firstName: 'Gemini',
    lastName: 'AI',
    imageUrl: 'https://i.pravatar.cc/300?u=2',
  );

  return geminiUser;
}
