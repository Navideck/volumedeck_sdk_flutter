package com.navideck.volumedeck_flutter

import android.app.Activity
import android.os.Handler
import android.os.Looper
import android.provider.ContactsContract.RawContacts.Data
import androidx.annotation.NonNull
import com.navideck.volumedeck.VolumeDeck
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.*
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import java.math.RoundingMode
import java.text.DecimalFormat


/** VolumedeckFlutterPlugin */
class VolumedeckFlutterPlugin : FlutterPlugin, MethodCallHandler, ActivityAware,
    PluginRegistry.RequestPermissionsResultListener {

    private lateinit var channel: MethodChannel
    private var activity: Activity? = null
    private var volumeDeck: VolumeDeck? = null
    private lateinit var mainThreadHandler: Handler
    private lateinit var messageConnector: BasicMessageChannel<Any>

    private fun sendMessage(type: String, data: Any? = null) {
        mainThreadHandler.post {
            messageConnector.send(
                mapOf(
                    "type" to type,
                    "data" to data,
                )
            )
        }
    }

    private fun initializeVolumedeck(runInBackground: Boolean, activationKey: String?) {
        volumeDeck = VolumeDeck(
            runInBackground = runInBackground,
            activationKey = activationKey,
            onLocationStatusChange = { isOn: Boolean ->
                sendMessage("onLocationStatusChange", isOn)
            },
            onLocationUpdate = { speed: Float, volume: Float ->
                val df = DecimalFormat("#.##")
                df.roundingMode = RoundingMode.CEILING
                sendMessage(
                    "onLocationUpdate", mapOf(
                        "speed" to df.format(speed).toDouble(),
                        "volume" to df.format(volume).toDouble(),
                    )
                )
            },
            onStart = {
                sendMessage("onStart")
            },
            onStop = {
                sendMessage("onStop")
            }
        )
    }

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        activity = binding.activity
        binding.addRequestPermissionsResultListener(this)
    }
    
    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel =
            MethodChannel(flutterPluginBinding.binaryMessenger, "@com.navideck.volumedeck_flutter")
        channel.setMethodCallHandler(this)
        mainThreadHandler = Handler(Looper.getMainLooper())
        messageConnector = BasicMessageChannel(
            flutterPluginBinding.binaryMessenger,
            "@com.navideck.volumedeck_flutter/message_connector",
            StandardMessageCodec.INSTANCE
        )
    }

    override fun onMethodCall(call: MethodCall, result: Result) {
        when (call.method) {
            "initialize" -> {
                val data = call.arguments as Map<*, *>
                val runInBackground: Boolean = data["runInBackground"] as Boolean? ?: false
                val activationKey: String? = data["activationKey"] as String?
                initializeVolumedeck(runInBackground, activationKey)
            }
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
