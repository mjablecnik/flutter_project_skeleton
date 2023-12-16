import 'package:freezed_annotation/freezed_annotation.dart';

part 'cat.freezed.dart';

part 'cat.g.dart';

@freezed
class Cat with _$Cat {
  const Cat._();

  const factory Cat({
    required String id,
    required Uri url,
    required int width,
    required int height,
  }) = _CatImage;

  factory Cat.fromJson(Map<String, Object?> json) => _$CatFromJson(json);
}

