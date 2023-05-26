package com.navideck.volumedeck_flutter

import android.os.Handler
import android.os.Looper
import com.navideck.universal_volume.UniversalVolume
import com.navideck.volumedeck_android.Volumedeck
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.*
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import java.math.RoundingMode
import java.text.DecimalFormat


/** VolumedeckFlutterPlugin */
class VolumedeckFlutterPlugin : FlutterPlugin, MethodCallHandler, ActivityAware {

    private lateinit var channel: MethodChannel
    private var activityBinding: ActivityPluginBinding? = null
    private var volumedeck: Volumedeck? = null
    private lateinit var mainThreadHandler: Handler
    private lateinit var messageConnector: BasicMessageChannel<Any>
    private var universalVolume: UniversalVolume? = null

    companion object {
        var instance: VolumedeckFlutterPlugin? = null
    }


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

    fun setUniversalVolume(universalVolume: UniversalVolume) {
        this.universalVolume = universalVolume
    }

    private fun initializeVolumedeck(
        runInBackground: Boolean,
        showStopButtonInNotification: Boolean,
        showSpeedAndVolumeChangesInNotification: Boolean,
        useWakeLock: Boolean,
        activationKey: String?,
    ) {
        activityBinding?.activity?.let {
            volumedeck = Volumedeck(
                activity = it,
                universalVolume = universalVolume,
                runInBackground = runInBackground,
                showStopButtonInNotification = showStopButtonInNotification,
                showSpeedAndVolumeChangesInNotification = showSpeedAndVolumeChangesInNotification,
                useWakeLock = useWakeLock,
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
    }

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        activityBinding = binding
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
        instance = this
    }

    override fun onMethodCall(call: MethodCall, result: Result) {
        val activity = activityBinding?.activity
        when (call.method) {
            "initialize" -> {
                val args = call.arguments as Map<*, *>
                val runInBackground: Boolean = args["runInBackground"] as Boolean? ?: false
                val showStopButtonInNotification: Boolean =
                    args["showStopButtonInNotification"] as Boolean? ?: false
                val showSpeedAndVolumeChangesInNotification: Boolean =
                    args["showSpeedAndVolumeChangesInNotification"] as Boolean? ?: false
                val useWakeLock: Boolean = args["useWakeLock"] as Boolean? ?: false
                val activationKey: String? = args["activationKey"] as String?

                initializeVolumedeck(
                    runInBackground,
                    showStopButtonInNotification,
                    showSpeedAndVolumeChangesInNotification,
                    useWakeLock,
                    activationKey
                )

                result.success(null)
            }

            "start" -> {
                activity?.let { volumedeck?.start(it) }
                result.success(null)
            }

            "stop" -> {
                activity?.let { volumedeck?.stop(it) }
                result.success(null)
            }

            else -> {
                result.notImplemented()
            }
        }
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        activityBinding?.activity?.let { volumedeck?.stop(it) }
        channel.setMethodCallHandler(null)
        instance = null
    }

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
        activityBinding = binding
    }

    override fun onDetachedFromActivityForConfigChanges() {
        activityBinding = null
    }

    override fun onDetachedFromActivity() {
        activityBinding?.activity?.let { volumedeck?.stop(it) }
        activityBinding = null
    }
}
