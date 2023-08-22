// Autogenerated from Pigeon (v10.1.6), do not edit directly.
// See also: https://pub.dev/packages/pigeon
// ignore_for_file: public_member_api_docs, non_constant_identifier_names, avoid_as, unused_import, unnecessary_parenthesis, prefer_null_aware_operators, omit_local_variable_types, unused_shown_name, unnecessary_import

import 'dart:async';
import 'dart:typed_data' show Float64List, Int32List, Int64List, Uint8List;

import 'package:flutter/foundation.dart' show ReadBuffer, WriteBuffer;
import 'package:flutter/services.dart';

/// Volumedeck
class VolumedeckChannel {
  /// Constructor for [VolumedeckChannel].  The [binaryMessenger] named argument is
  /// available for dependency injection.  If it is left null, the default
  /// BinaryMessenger will be used which routes to the host platform.
  VolumedeckChannel({BinaryMessenger? binaryMessenger})
      : _binaryMessenger = binaryMessenger;
  final BinaryMessenger? _binaryMessenger;

  static const MessageCodec<Object?> codec = StandardMessageCodec();

  Future<void> initialize(bool arg_autoStart, bool arg_runInBackground, bool arg_showStopButtonInAndroidNotification, bool arg_showSpeedAndVolumeChangesInAndroidNotification, String? arg_androidActivationKey, String? arg_iosActivationKey) async {
    final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
        'dev.flutter.pigeon.volumedeck_flutter.VolumedeckChannel.initialize', codec,
        binaryMessenger: _binaryMessenger);
    final List<Object?>? replyList =
        await channel.send(<Object?>[arg_autoStart, arg_runInBackground, arg_showStopButtonInAndroidNotification, arg_showSpeedAndVolumeChangesInAndroidNotification, arg_androidActivationKey, arg_iosActivationKey]) as List<Object?>?;
    if (replyList == null) {
      throw PlatformException(
        code: 'channel-error',
        message: 'Unable to establish connection on channel.',
      );
    } else if (replyList.length > 1) {
      throw PlatformException(
        code: replyList[0]! as String,
        message: replyList[1] as String?,
        details: replyList[2],
      );
    } else {
      return;
    }
  }

  Future<void> start() async {
    final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
        'dev.flutter.pigeon.volumedeck_flutter.VolumedeckChannel.start', codec,
        binaryMessenger: _binaryMessenger);
    final List<Object?>? replyList =
        await channel.send(null) as List<Object?>?;
    if (replyList == null) {
      throw PlatformException(
        code: 'channel-error',
        message: 'Unable to establish connection on channel.',
      );
    } else if (replyList.length > 1) {
      throw PlatformException(
        code: replyList[0]! as String,
        message: replyList[1] as String?,
        details: replyList[2],
      );
    } else {
      return;
    }
  }

  Future<void> stop() async {
    final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
        'dev.flutter.pigeon.volumedeck_flutter.VolumedeckChannel.stop', codec,
        binaryMessenger: _binaryMessenger);
    final List<Object?>? replyList =
        await channel.send(null) as List<Object?>?;
    if (replyList == null) {
      throw PlatformException(
        code: 'channel-error',
        message: 'Unable to establish connection on channel.',
      );
    } else if (replyList.length > 1) {
      throw PlatformException(
        code: replyList[0]! as String,
        message: replyList[1] as String?,
        details: replyList[2],
      );
    } else {
      return;
    }
  }
}

abstract class VolumedeckCallback {
  static const MessageCodec<Object?> codec = StandardMessageCodec();

  void onLocationStatusChange(bool status);

  void onLocationUpdate(double speed, double volume);

  void onStart();

  void onStop();

  static void setup(VolumedeckCallback? api, {BinaryMessenger? binaryMessenger}) {
    {
      final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
          'dev.flutter.pigeon.volumedeck_flutter.VolumedeckCallback.onLocationStatusChange', codec,
          binaryMessenger: binaryMessenger);
      if (api == null) {
        channel.setMessageHandler(null);
      } else {
        channel.setMessageHandler((Object? message) async {
          assert(message != null,
          'Argument for dev.flutter.pigeon.volumedeck_flutter.VolumedeckCallback.onLocationStatusChange was null.');
          final List<Object?> args = (message as List<Object?>?)!;
          final bool? arg_status = (args[0] as bool?);
          assert(arg_status != null,
              'Argument for dev.flutter.pigeon.volumedeck_flutter.VolumedeckCallback.onLocationStatusChange was null, expected non-null bool.');
          api.onLocationStatusChange(arg_status!);
          return;
        });
      }
    }
    {
      final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
          'dev.flutter.pigeon.volumedeck_flutter.VolumedeckCallback.onLocationUpdate', codec,
          binaryMessenger: binaryMessenger);
      if (api == null) {
        channel.setMessageHandler(null);
      } else {
        channel.setMessageHandler((Object? message) async {
          assert(message != null,
          'Argument for dev.flutter.pigeon.volumedeck_flutter.VolumedeckCallback.onLocationUpdate was null.');
          final List<Object?> args = (message as List<Object?>?)!;
          final double? arg_speed = (args[0] as double?);
          assert(arg_speed != null,
              'Argument for dev.flutter.pigeon.volumedeck_flutter.VolumedeckCallback.onLocationUpdate was null, expected non-null double.');
          final double? arg_volume = (args[1] as double?);
          assert(arg_volume != null,
              'Argument for dev.flutter.pigeon.volumedeck_flutter.VolumedeckCallback.onLocationUpdate was null, expected non-null double.');
          api.onLocationUpdate(arg_speed!, arg_volume!);
          return;
        });
      }
    }
    {
      final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
          'dev.flutter.pigeon.volumedeck_flutter.VolumedeckCallback.onStart', codec,
          binaryMessenger: binaryMessenger);
      if (api == null) {
        channel.setMessageHandler(null);
      } else {
        channel.setMessageHandler((Object? message) async {
          // ignore message
          api.onStart();
          return;
        });
      }
    }
    {
      final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
          'dev.flutter.pigeon.volumedeck_flutter.VolumedeckCallback.onStop', codec,
          binaryMessenger: binaryMessenger);
      if (api == null) {
        channel.setMessageHandler(null);
      } else {
        channel.setMessageHandler((Object? message) async {
          // ignore message
          api.onStop();
          return;
        });
      }
    }
  }
}
