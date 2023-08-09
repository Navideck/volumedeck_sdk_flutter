// Autogenerated from Pigeon (v10.1.6), do not edit directly.
// See also: https://pub.dev/packages/pigeon

import Foundation
#if os(iOS)
import Flutter
#elseif os(macOS)
import FlutterMacOS
#else
#error("Unsupported platform.")
#endif

private func wrapResult(_ result: Any?) -> [Any?] {
  return [result]
}

private func wrapError(_ error: Any) -> [Any?] {
  if let flutterError = error as? FlutterError {
    return [
      flutterError.code,
      flutterError.message,
      flutterError.details
    ]
  }
  return [
    "\(error)",
    "\(type(of: error))",
    "Stacktrace: \(Thread.callStackSymbols)"
  ]
}

private func nilOrValue<T>(_ value: Any?) -> T? {
  if value is NSNull { return nil }
  return value as! T?
}
/// Volumedeck
///
/// Generated protocol from Pigeon that represents a handler of messages from Flutter.
protocol VolumedeckChannel {
  func initialize(autoStart: Bool, runInBackground: Bool, showStopButtonInAndroidNotification: Bool, showSpeedAndVolumeChangesInAndroidNotification: Bool, activationKey: String?) throws
  func start() throws
  func stop() throws
}

/// Generated setup class from Pigeon to handle messages through the `binaryMessenger`.
class VolumedeckChannelSetup {
  /// The codec used by VolumedeckChannel.
  /// Sets up an instance of `VolumedeckChannel` to handle messages through the `binaryMessenger`.
  static func setUp(binaryMessenger: FlutterBinaryMessenger, api: VolumedeckChannel?) {
    let initializeChannel = FlutterBasicMessageChannel(name: "dev.flutter.pigeon.volumedeck_flutter.VolumedeckChannel.initialize", binaryMessenger: binaryMessenger)
    if let api = api {
      initializeChannel.setMessageHandler { message, reply in
        let args = message as! [Any?]
        let autoStartArg = args[0] as! Bool
        let runInBackgroundArg = args[1] as! Bool
        let showStopButtonInAndroidNotificationArg = args[2] as! Bool
        let showSpeedAndVolumeChangesInAndroidNotificationArg = args[3] as! Bool
        let activationKeyArg: String? = nilOrValue(args[4])
        do {
          try api.initialize(autoStart: autoStartArg, runInBackground: runInBackgroundArg, showStopButtonInAndroidNotification: showStopButtonInAndroidNotificationArg, showSpeedAndVolumeChangesInAndroidNotification: showSpeedAndVolumeChangesInAndroidNotificationArg, activationKey: activationKeyArg)
          reply(wrapResult(nil))
        } catch {
          reply(wrapError(error))
        }
      }
    } else {
      initializeChannel.setMessageHandler(nil)
    }
    let startChannel = FlutterBasicMessageChannel(name: "dev.flutter.pigeon.volumedeck_flutter.VolumedeckChannel.start", binaryMessenger: binaryMessenger)
    if let api = api {
      startChannel.setMessageHandler { _, reply in
        do {
          try api.start()
          reply(wrapResult(nil))
        } catch {
          reply(wrapError(error))
        }
      }
    } else {
      startChannel.setMessageHandler(nil)
    }
    let stopChannel = FlutterBasicMessageChannel(name: "dev.flutter.pigeon.volumedeck_flutter.VolumedeckChannel.stop", binaryMessenger: binaryMessenger)
    if let api = api {
      stopChannel.setMessageHandler { _, reply in
        do {
          try api.stop()
          reply(wrapResult(nil))
        } catch {
          reply(wrapError(error))
        }
      }
    } else {
      stopChannel.setMessageHandler(nil)
    }
  }
}
/// Generated class from Pigeon that represents Flutter messages that can be called from Swift.
class VolumedeckCallback {
  private let binaryMessenger: FlutterBinaryMessenger
  init(binaryMessenger: FlutterBinaryMessenger){
    self.binaryMessenger = binaryMessenger
  }
  func onStart(completion: @escaping () -> Void) {
    let channel = FlutterBasicMessageChannel(name: "dev.flutter.pigeon.volumedeck_flutter.VolumedeckCallback.onStart", binaryMessenger: binaryMessenger)
    channel.sendMessage(nil) { _ in
      completion()
    }
  }
  func onStop(completion: @escaping () -> Void) {
    let channel = FlutterBasicMessageChannel(name: "dev.flutter.pigeon.volumedeck_flutter.VolumedeckCallback.onStop", binaryMessenger: binaryMessenger)
    channel.sendMessage(nil) { _ in
      completion()
    }
  }
  func onLocationStatusChange(status statusArg: Bool, completion: @escaping () -> Void) {
    let channel = FlutterBasicMessageChannel(name: "dev.flutter.pigeon.volumedeck_flutter.VolumedeckCallback.onLocationStatusChange", binaryMessenger: binaryMessenger)
    channel.sendMessage([statusArg] as [Any?]) { _ in
      completion()
    }
  }
  func onLocationUpdate(speed speedArg: Double, volume volumeArg: Double, completion: @escaping () -> Void) {
    let channel = FlutterBasicMessageChannel(name: "dev.flutter.pigeon.volumedeck_flutter.VolumedeckCallback.onLocationUpdate", binaryMessenger: binaryMessenger)
    channel.sendMessage([speedArg, volumeArg] as [Any?]) { _ in
      completion()
    }
  }
}