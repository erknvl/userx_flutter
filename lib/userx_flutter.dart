import 'dart:async';

import 'package:flutter/services.dart';

import 'package:userx_flutter/attributes/attribute.dart';

class UserX {
  static const MethodChannel _channel = const MethodChannel('userx_flutter');

  static Future<String?> get platformVersion async {
    final String? version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static void start(String key) async {
    await _channel.invokeMethod('start', {'key': key});
  }

  static void startWithMarkSessionToUpload(String key) async {
    await _channel.invokeMethod('startWithMarkSessionToUpload', {'key': key});
  }

  static void markSessionToUpload() async {
    await _channel.invokeMethod('markSessionToUpload');
  }

  static void configure(String key) async {
    await _channel.invokeMethod('configure', {'key': key});
  }

  static void startSession() async {
    await _channel.invokeMethod('startSession');
  }

  static void stopSession() async {
    await _channel.invokeMethod('stopSession');
  }

  static void setUserId(String userId) async {
    await _channel.invokeMethod('setUserId', {"userId": userId});
  }

  static void addEvent(String name, Map<String, String> attributes) async {
    await _channel
        .invokeMethod('addEvent', {"name": name, 'attributes': attributes});
  }

  static Future<void> stopScreenRecording() async {
    await _channel.invokeMethod('stopScreenRecording');
  }

  static Future<void> startScreenRecording() async {
    await _channel.invokeMethod('startScreenRecording');
  }

  static Future<String?> get sessionUrl async {
    final String? sessionUrl = await _channel.invokeMethod('sessionUrl');
    return sessionUrl;
  }

  static Future<String?> get allSessionsUrl async {
    final String? allSessionsUrl =
        await _channel.invokeMethod('allSessionsUrl');
    return allSessionsUrl;
  }

  static Future<void> setRenderingInBackground(
      bool renderingInBackground) async {
    await _channel.invokeMethod('setRenderingInBackground',
        {"renderingInBackground": renderingInBackground});
  }

  static void addScreenName(String title) async {
    await _channel.invokeMethod('addScreenName', {'title': title});
  }

  static Future<void> applyUserAttributes(List<Attribute> attributes) async {
    var attrsInfo = attributes.map((attribute) => attribute.toMap()).toList();
    return await _channel
        .invokeMethod('applyUserAttributes', {'attributes': attrsInfo});
  }

  static void setCatchExceptions(bool enabled) async {
    await _channel.invokeMethod('setCatchExceptions', {"enabled": enabled});
  }
}
