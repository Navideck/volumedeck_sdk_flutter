import Flutter
import UIKit
import Volumedeck

public class SwiftVolumedeckFlutterPlugin: NSObject, FlutterPlugin {
    var volumedeck: Volumedeck?
    private var messageConnector: FlutterBasicMessageChannel?
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "@com.navideck.volumedeck_flutter", binaryMessenger: registrar.messenger())
        let instance = SwiftVolumedeckFlutterPlugin()
        instance.messageConnector = FlutterBasicMessageChannel(name: "@com.navideck.volumedeck_flutter/message_connector", binaryMessenger: registrar.messenger())
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "initialize":
            let args = call.arguments as? Dictionary<String, Any>
            let runInBackground: Bool = args?["runInBackground"] as? Bool ?? false
            let activationKey: String? = args?["activationKey"] as? String
            initializeVolumedeck(runInBackground: runInBackground,activationKey: activationKey)
            result(nil)
        case "start":
            volumedeck?.isOn = true
            result(nil)
        case "stop":
            volumedeck?.isOn = false
            sendMessage(type: "onStop")
            result(nil)
        default:
            result(FlutterMethodNotImplemented)
        }
    }
    
    
    public func initializeVolumedeck(runInBackground: Bool,activationKey: String?){
        volumedeck = Volumedeck(
            runInBackground: runInBackground,
            onLocationUpdate: { speed, volume in
                self.sendMessage(
                    type: "onLocationUpdate",
                    data: [
                        "speed": speed,
                        "volume": volume,
                    ]
                )
            },
            onLocationStatusChange: { status in
                self.sendMessage(type: "onLocationStatusChange", data: status)
            },
            onStart: {
                self.sendMessage(type: "onStart")
            },
            activationKey: activationKey
        )
    }
    
    public func sendMessage(type: String, data: Any? = nil) {
        messageConnector?.sendMessage([
            "type": type,
            "data": data,
        ])
    }
}
