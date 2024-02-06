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

/// Generated class from Pigeon that represents data sent in messages.
struct NativeAndroidConfig {
  var showStopButtonInNotification: Bool? = nil
  var notificationTitle: String? = nil
  var notificationSubtitle: String? = nil
  var notificationStopButtonText: String? = nil
  var notificationIconDrawable: String? = nil

  static func fromList(_ list: [Any?]) -> NativeAndroidConfig? {
    let showStopButtonInNotification: Bool? = nilOrValue(list[0])
    let notificationTitle: String? = nilOrValue(list[1])
    let notificationSubtitle: String? = nilOrValue(list[2])
    let notificationStopButtonText: String? = nilOrValue(list[3])
    let notificationIconDrawable: String? = nilOrValue(list[4])

    return NativeAndroidConfig(
      showStopButtonInNotification: showStopButtonInNotification,
      notificationTitle: notificationTitle,
      notificationSubtitle: notificationSubtitle,
      notificationStopButtonText: notificationStopButtonText,
      notificationIconDrawable: notificationIconDrawable
    )
  }
  func toList() -> [Any?] {
    return [
      showStopButtonInNotification,
      notificationTitle,
      notificationSubtitle,
      notificationStopButtonText,
      notificationIconDrawable,
    ]
  }
}
private class VolumedeckChannelCodecReader: FlutterStandardReader {
  override func readValue(ofType type: UInt8) -> Any? {
    switch type {
      case 128:
        return NativeAndroidConfig.fromList(self.readValue() as! [Any?])
      default:
        return super.readValue(ofType: type)
    }
  }
}

private class VolumedeckChannelCodecWriter: FlutterStandardWriter {
  override func writeValue(_ value: Any) {
    if let value = value as? NativeAndroidConfig {
      super.writeByte(128)
      super.writeValue(value.toList())
    } else {
      super.writeValue(value)
    }
  }
}

private class VolumedeckChannelCodecReaderWriter: FlutterStandardReaderWriter {
  override func reader(with data: Data) -> FlutterStandardReader {
    return VolumedeckChannelCodecReader(data: data)
  }

  override func writer(with data: NSMutableData) -> FlutterStandardWriter {
    return VolumedeckChannelCodecWriter(data: data)
  }
}

class VolumedeckChannelCodec: FlutterStandardMessageCodec {
  static let shared = VolumedeckChannelCodec(readerWriter: VolumedeckChannelCodecReaderWriter())
}

/// Volumedeck
///
/// Generated protocol from Pigeon that represents a handler of messages from Flutter.
protocol VolumedeckChannel {
  func initialize(autoStart: Bool, runInBackground: Bool, nativeAndroidConfig: NativeAndroidConfig?, androidActivationKey: String?, iOSActivationKey: String?) throws
  func start() throws
  func stop() throws
  func setMockSpeed(speed: Int64) throws
}

/// Generated setup class from Pigeon to handle messages through the `binaryMessenger`.
class VolumedeckChannelSetup {
  /// The codec used by VolumedeckChannel.
  static var codec: FlutterStandardMessageCodec { VolumedeckChannelCodec.shared }
  /// Sets up an instance of `VolumedeckChannel` to handle messages through the `binaryMessenger`.
  static func setUp(binaryMessenger: FlutterBinaryMessenger, api: VolumedeckChannel?) {
    let initializeChannel = FlutterBasicMessageChannel(name: "dev.flutter.pigeon.volumedeck_flutter.VolumedeckChannel.initialize", binaryMessenger: binaryMessenger, codec: codec)
    if let api = api {
      initializeChannel.setMessageHandler { message, reply in
        let args = message as! [Any?]
        let autoStartArg = args[0] as! Bool
        let runInBackgroundArg = args[1] as! Bool
        let nativeAndroidConfigArg: NativeAndroidConfig? = nilOrValue(args[2])
        let androidActivationKeyArg: String? = nilOrValue(args[3])
        let iOSActivationKeyArg: String? = nilOrValue(args[4])
        do {
          try api.initialize(autoStart: autoStartArg, runInBackground: runInBackgroundArg, nativeAndroidConfig: nativeAndroidConfigArg, androidActivationKey: androidActivationKeyArg, iOSActivationKey: iOSActivationKeyArg)
          reply(wrapResult(nil))
        } catch {
          reply(wrapError(error))
        }
      }
    } else {
      initializeChannel.setMessageHandler(nil)
    }
    let startChannel = FlutterBasicMessageChannel(name: "dev.flutter.pigeon.volumedeck_flutter.VolumedeckChannel.start", binaryMessenger: binaryMessenger, codec: codec)
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
    let stopChannel = FlutterBasicMessageChannel(name: "dev.flutter.pigeon.volumedeck_flutter.VolumedeckChannel.stop", binaryMessenger: binaryMessenger, codec: codec)
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
    let setMockSpeedChannel = FlutterBasicMessageChannel(name: "dev.flutter.pigeon.volumedeck_flutter.VolumedeckChannel.setMockSpeed", binaryMessenger: binaryMessenger, codec: codec)
    if let api = api {
      setMockSpeedChannel.setMessageHandler { message, reply in
        let args = message as! [Any?]
        let speedArg = args[0] is Int64 ? args[0] as! Int64 : Int64(args[0] as! Int32)
        do {
          try api.setMockSpeed(speed: speedArg)
          reply(wrapResult(nil))
        } catch {
          reply(wrapError(error))
        }
      }
    } else {
      setMockSpeedChannel.setMessageHandler(nil)
    }
  }
}
/// Generated class from Pigeon that represents Flutter messages that can be called from Swift.
class VolumedeckCallback {
  private let binaryMessenger: FlutterBinaryMessenger
  init(binaryMessenger: FlutterBinaryMessenger){
    self.binaryMessenger = binaryMessenger
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
}
