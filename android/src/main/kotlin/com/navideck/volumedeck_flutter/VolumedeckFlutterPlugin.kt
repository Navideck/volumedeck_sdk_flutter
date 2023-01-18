package com.navideck.volumedeck_flutter

import android.app.Activity
import android.util.Log
import androidx.annotation.NonNull
import com.navideck.volumedeck.VolumeDeck
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry


/** VolumedeckFlutterPlugin */
class VolumedeckFlutterPlugin : FlutterPlugin, MethodCallHandler, ActivityAware,
    PluginRegistry.RequestPermissionsResultListener {

    private lateinit var channel: MethodChannel
    private var activity: Activity? = null
    private var volumeDeck: VolumeDeck? = null

    private fun initializeVolumedeck() {
        volumeDeck = VolumeDeck(
            runInBackground = true,
            onLocationStatusChange = { isOn: Boolean ->
                Log.e("VolumedeckFlutterPlugin", "OnLocationChange :$isOn")
            },
            onLocationUpdate = { speed: Float, volume: Float ->
                Log.e("VolumedeckFlutterPlugin", "onLocationUpdate :$speed / $volume")
            },
            onStart = {
                Log.e("VolumedeckFlutterPlugin", "start")
            },
            onStop = {
                Log.e("VolumedeckFlutterPlugin", "stop")
            }
        )
    }

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        initializeVolumedeck()
        activity = binding.activity
        binding.addRequestPermissionsResultListener(this)
    }


    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel =
            MethodChannel(flutterPluginBinding.binaryMessenger, "@com.navideck.volumedeck_flutter")
        channel.setMethodCallHandler(this)
    }

    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
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
