// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sign_up_request_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignUpRequestBody _$SignUpRequestBodyFromJson(Map<String, dynamic> json) =>
    SignUpRequestBody(
      phone: json['phone'] as String,
      confirmPassword: json['confirmPassword'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
      name: json['name'] as String,
    );

Map<String, dynamic> _$SignUpRequestBodyToJson(SignUpRequestBody instance) =>
    <String, dynamic>{
      'email': instance.email,
      'password': instance.password,
      'name': instance.name,
      'phone': instance.phone,
      'confirmPassword': instance.confirmPassword,
    };