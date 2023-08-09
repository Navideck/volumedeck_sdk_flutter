package com.navideck.volumedeck_flutter

import com.navideck.universal_volume.UniversalVolume
import com.navideck.volumedeck_android.Volumedeck
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding

/** VolumedeckFlutterPlugin */
class VolumedeckFlutterPlugin : FlutterPlugin, VolumedeckChannel, ActivityAware {
    private var activityBinding: ActivityPluginBinding? = null
    private var volumedeck: Volumedeck? = null
    private var volumedeckCallback: VolumedeckCallback? = null
    private var universalVolume: UniversalVolume? = null

    companion object {
        var instance: VolumedeckFlutterPlugin? = null
    }

    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        instance = this
        volumedeckCallback = VolumedeckCallback(flutterPluginBinding.binaryMessenger)
        VolumedeckChannel.setUp(flutterPluginBinding.binaryMessenger, this)
    }

    override fun initialize(
        autoStart: Boolean,
        runInBackground: Boolean,
        showStopButtonInAndroidNotification: Boolean,
        showSpeedAndVolumeChangesInAndroidNotification: Boolean,
        activationKey: String?
    ) {
        val activity = activityBinding?.activity ?: throw Exception("Activity is null")
        volumedeck = Volumedeck(
            activity = activity,
            autoStart = autoStart,
            runInBackground = runInBackground,
            showStopButtonInNotification = showStopButtonInAndroidNotification,
            showSpeedAndVolumeChangesInNotification = showSpeedAndVolumeChangesInAndroidNotification,
            activationKey = activationKey,
            locationServicesStatusChange = { isOn: Boolean ->
                volumedeckCallback?.onLocationStatusChange(isOn) {}
            },
            onLocationUpdate = { speed: Float, volume: Float ->
                volumedeckCallback?.onLocationUpdate(speed.toDouble(), volume.toDouble()) {}
            },
            onStart = {
                volumedeckCallback?.onStart {}
            },
            onStop = {
                volumedeckCallback?.onStop {}
            }
        )
        universalVolume?.let { universalVolume ->
            volumedeck?.setUniversalVolumeInstance(universalVolume)
        }
    }

    override fun start() {
        volumedeck?.start()
    }

    override fun stop() {
        volumedeck?.stop()
    }

    /// It allows specifying the `UniversalVolume` instance, which can be used to share the same instance between
    /// multiple plugins. This can be useful to save on resources and also prevent unexpected behavior on devices
    /// that do not handle concurrency properly.
    fun setUniversalVolumeInstance(universalVolume: UniversalVolume) {
        this.universalVolume = universalVolume
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        volumedeck?.stop()
        instance = null
        volumedeckCallback = null
        activityBinding = null
    }

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        activityBinding = binding
    }

    override fun onDetachedFromActivity() {}
    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {}
    override fun onDetachedFromActivityForConfigChanges() {}
}
