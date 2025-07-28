import 'package:json_annotation/json_annotation.dart';

part 'auth_dto.g.dart';

@JsonSerializable()
class AuthRequest {
  @JsonKey(name: "username")
  String username;
  @JsonKey(name: "password")
  String password;

  AuthRequest({
    required this.username,
    required this.password,
  });

  AuthRequest copyWith({
    String? username,
    String? password,
  }) =>
      AuthRequest(
        username: username ?? this.username,
        password: password ?? this.password,
      );

  factory AuthRequest.fromJson(Map<String, dynamic> json) => _$AuthRequestFromJson(json);

  Map<String, dynamic> toJson() => _$AuthRequestToJson(this);
}
