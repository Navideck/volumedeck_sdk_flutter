import Flutter
import VolumedeckiOS

public class VolumedeckFlutterPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let handler = VolumedeckChannelHandler(volumedeckCallback: VolumedeckCallback(binaryMessenger: registrar.messenger()))
    VolumedeckChannelSetup.setUp(binaryMessenger: registrar.messenger(), api: handler)
  }
}

private class VolumedeckChannelHandler: NSObject, VolumedeckChannel {
  var volumedeck: Volumedeck?
  var volumedeckCallback: VolumedeckCallback

  init(volumedeckCallback: VolumedeckCallback) {
    self.volumedeckCallback = volumedeckCallback
  }

  func initialize(
    autoStart: Bool,
    runInBackground: Bool,
    nativeAndroidConfig: NativeAndroidConfig?,
    androidActivationKey: String?,
    iOSActivationKey: String?
  ) throws {
    volumedeck = Volumedeck(
      runInBackground: runInBackground,
      onLocationUpdate: { speed, volume in
        self.volumedeckCallback.onLocationUpdate(speed: speed, volume: volume) {}
      },
      onLocationStatusChange: { status in
        self.volumedeckCallback.onLocationStatusChange(status: status) {}
      },
      onStart: {
        self.volumedeckCallback.onStart {}
      },
      onStop: {
        self.volumedeckCallback.onStop {}
      },
      activationKey: iOSActivationKey,
      autoStart: autoStart
    )
  }

  func start() throws {
    volumedeck?.start()
  }

  func stop() throws {
    volumedeck?.stop()
  }

  func setMockSpeed(speed: Int64) throws {
    volumedeck?.mockSpeed(speed: Double(speed))
  }
}
