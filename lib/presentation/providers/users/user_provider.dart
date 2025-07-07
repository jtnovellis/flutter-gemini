import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

part 'user_provider.g.dart';

@riverpod
types.User geminiUser(Ref ref) {
  final geminiUser = types.User(
    id: Uuid().v4(),
    firstName: 'Gemini',
    lastName: 'AI',
    imageUrl: 'https://i.pravatar.cc/300?u=2',
  );

  return geminiUser;
}

@riverpod
types.User user(Ref ref) {
  final user = types.User(
    id: Uuid().v4(),
    firstName: 'Jairo',
    lastName: "Toro",
    imageUrl: 'https://i.pravatar.cc/300?u=1',
  );

  return user;
}
