package com.navideck.volumedeck_flutter

import android.app.Activity
import androidx.annotation.NonNull
import com.navideck.volumedeck.VolumeDeck
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry


/** VolumedeckFlutterPlugin */
class VolumedeckFlutterPlugin : FlutterPlugin, MethodCallHandler, ActivityAware,
    PluginRegistry.RequestPermissionsResultListener, EventChannel.StreamHandler {

    private var volumedeckEventSink: EventChannel.EventSink? = null
    private lateinit var volumedeckEventResult: EventChannel
    private lateinit var channel: MethodChannel
    private var activity: Activity? = null
    private var volumeDeck: VolumeDeck? = null

    private fun sendEvent(data: Map<String, String>) {
        volumedeckEventSink?.success(data)
    }

    private fun initializeVolumedeck() {
        volumeDeck = VolumeDeck(
            runInBackground = true,
            onLocationStatusChange = { isOn: Boolean ->
                val data = mapOf("onLocationStatusChange" to isOn.toString())
                sendEvent(data)
            },
            onLocationUpdate = { speed: Float, volume: Float ->
                val data = mapOf(
                    "speed" to speed.toString(),
                    "volume" to volume.toString()
                )
                sendEvent(data)
            },
            onStart = {
                val data = mapOf("onStart" to "")
                sendEvent(data)
            },
            onStop = {
                val data = mapOf("onStop" to "")
                sendEvent(data)
            }
        )
    }

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        initializeVolumedeck()
        activity = binding.activity
        binding.addRequestPermissionsResultListener(this)
    }


    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel =
            MethodChannel(flutterPluginBinding.binaryMessenger, "@com.navideck.volumedeck_flutter")
        channel.setMethodCallHandler(this)
        volumedeckEventResult =
            EventChannel(flutterPluginBinding.binaryMessenger, "@com.navideck.volumedeck_event")
        volumedeckEventResult.setStreamHandler(this)
    }

    override fun onMethodCall(call: MethodCall, result: Result) {
        when (call.method) {
            "start" -> {
                activity?.let { volumeDeck?.start(it) }
                result.success(null)
            }
            "stop" -> {
                activity?.let { volumeDeck?.stop(it) }
                result.success(null)
            }
            else -> {
                result.notImplemented()
            }
        }
    }

    override fun onListen(args: Any?, eventSink: EventChannel.EventSink?) {
        val map = args as? Map<*, *> ?: return
        when (map["name"]) {
            "volumeDeckEvent" -> {
                volumedeckEventSink = eventSink
            }
        }
    }

    override fun onCancel(args: Any?) {
        val map = args as? Map<*, *> ?: return
        when (map["name"]) {
            "volumeDeckEvent" -> {
                volumedeckEventSink = null
            }
        }
    }

    override fun onRequestPermissionsResult(
        requestCode: Int,
        permissions: Array<out String>,
        grantResults: IntArray
    ): Boolean {
        activity?.let {
            volumeDeck?.onRequestPermissionsResult(requestCode, grantResults, it)
        }
        return false
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
        volumedeckEventResult.setStreamHandler(null)
    }

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
        activity = binding.activity
        binding.addRequestPermissionsResultListener(this)
    }

    override fun onDetachedFromActivityForConfigChanges() {
        activity = null
    }

    override fun onDetachedFromActivity() {
        activity = null
    }
}
