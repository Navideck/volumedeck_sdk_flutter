import Flutter
import UIKit
import Volumedeck

public class SwiftVolumedeckFlutterPlugin: NSObject, FlutterPlugin { //, FlutterStreamHandler {
    var volumedeck: Volumedeck?
    // private var volumedeckEventsSink: FlutterEventSink?
    
    private func initVolumedeck(){
        // volumedeck = Volumedeck(runInBackground: true)
    }
    
    private func disposeVolumedeck(){
        volumedeck = nil
    }
    
    // public func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
    //     guard let args = arguments as? Dictionary<String, Any>, let name = args["name"] as? String else {
    //           return nil
    //     }
    //     if name == "volumedeckEvent" {
    //         volumedeckEventsSink = events
    //         initVolumedeck()
    //     }
    //     return nil
    // }
    
    // public func onCancel(withArguments arguments: Any?) -> FlutterError? {
    //     guard let args = arguments as? Dictionary<String, Any>, let name = args["name"] as? String else {
    //           return nil
    //     }
    //     if name == "volumedeckEvent" {
    //         volumedeckEventsSink = nil
    //         disposeVolumedeck()
    //     }
    //     return nil
    // }
    
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        
        let channel = FlutterMethodChannel(name: "volumedeck", binaryMessenger: registrar.messenger())
        let instance = SwiftVolumedeckFlutterPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
                
        let eventChannel = FlutterEventChannel(name: "com.navideck.volumedeck", binaryMessenger: registrar.messenger())
//        eventChannel.setStreamHandler(instance)
        
        instance.volumedeck = Volumedeck(runInBackground: true)
        instance.volumedeck?.isOn = true
    }
}
