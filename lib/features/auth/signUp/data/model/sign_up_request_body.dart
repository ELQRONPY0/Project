import 'package:json_annotation/json_annotation.dart';

part 'sign_up_request_body.g.dart';

@JsonSerializable()
class SignUpRequestBody {
  @JsonKey(name: 'email')
  final String email;

  @JsonKey(name: 'password')
  final String password;

  @JsonKey(name: 'name')
  final String name;

  @JsonKey(name: 'phone')
  final String phone;

  @JsonKey(name: 'confirmPassword')
  final String confirmPassword;

  SignUpRequestBody({
    required this.phone,
    required this.confirmPassword,
    required this.email,
    required this.password,
    required this.name,
  });

  factory SignUpRequestBody.fromJson(Map<String, dynamic> json) =>
      _$SignUpRequestBodyFromJson(json);

  Map<String, dynamic> toJson() => _$SignUpRequestBodyToJson(this);
}
