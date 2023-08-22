// Autogenerated from Pigeon (v10.1.6), do not edit directly.
// See also: https://pub.dev/packages/pigeon

package com.navideck.volumedeck_flutter

import android.util.Log
import io.flutter.plugin.common.BasicMessageChannel
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MessageCodec
import io.flutter.plugin.common.StandardMessageCodec
import java.io.ByteArrayOutputStream
import java.nio.ByteBuffer

private fun wrapResult(result: Any?): List<Any?> {
  return listOf(result)
}

private fun wrapError(exception: Throwable): List<Any?> {
  if (exception is FlutterError) {
    return listOf(
      exception.code,
      exception.message,
      exception.details
    )
  } else {
    return listOf(
      exception.javaClass.simpleName,
      exception.toString(),
      "Cause: " + exception.cause + ", Stacktrace: " + Log.getStackTraceString(exception)
    )
  }
}

/**
 * Error class for passing custom error details to Flutter via a thrown PlatformException.
 * @property code The error code.
 * @property message The error message.
 * @property details The error details. Must be a datatype supported by the api codec.
 */
class FlutterError (
  val code: String,
  override val message: String? = null,
  val details: Any? = null
) : Throwable()
/**
 * Volumedeck
 *
 * Generated interface from Pigeon that represents a handler of messages from Flutter.
 */
interface VolumedeckChannel {
  fun initialize(autoStart: Boolean, runInBackground: Boolean, showStopButtonInAndroidNotification: Boolean, showSpeedAndVolumeChangesInAndroidNotification: Boolean, androidActivationKey: String?, iosActivationKey: String?)
  fun start()
  fun stop()

  companion object {
    /** The codec used by VolumedeckChannel. */
    val codec: MessageCodec<Any?> by lazy {
      StandardMessageCodec()
    }
    /** Sets up an instance of `VolumedeckChannel` to handle messages through the `binaryMessenger`. */
    @Suppress("UNCHECKED_CAST")
    fun setUp(binaryMessenger: BinaryMessenger, api: VolumedeckChannel?) {
      run {
        val channel = BasicMessageChannel<Any?>(binaryMessenger, "dev.flutter.pigeon.volumedeck_flutter.VolumedeckChannel.initialize", codec)
        if (api != null) {
          channel.setMessageHandler { message, reply ->
            val args = message as List<Any?>
            val autoStartArg = args[0] as Boolean
            val runInBackgroundArg = args[1] as Boolean
            val showStopButtonInAndroidNotificationArg = args[2] as Boolean
            val showSpeedAndVolumeChangesInAndroidNotificationArg = args[3] as Boolean
            val androidActivationKeyArg = args[4] as String?
            val iosActivationKeyArg = args[5] as String?
            var wrapped: List<Any?>
            try {
              api.initialize(autoStartArg, runInBackgroundArg, showStopButtonInAndroidNotificationArg, showSpeedAndVolumeChangesInAndroidNotificationArg, androidActivationKeyArg, iosActivationKeyArg)
              wrapped = listOf<Any?>(null)
            } catch (exception: Throwable) {
              wrapped = wrapError(exception)
            }
            reply.reply(wrapped)
          }
        } else {
          channel.setMessageHandler(null)
        }
      }
      run {
        val channel = BasicMessageChannel<Any?>(binaryMessenger, "dev.flutter.pigeon.volumedeck_flutter.VolumedeckChannel.start", codec)
        if (api != null) {
          channel.setMessageHandler { _, reply ->
            var wrapped: List<Any?>
            try {
              api.start()
              wrapped = listOf<Any?>(null)
            } catch (exception: Throwable) {
              wrapped = wrapError(exception)
            }
            reply.reply(wrapped)
          }
        } else {
          channel.setMessageHandler(null)
        }
      }
      run {
        val channel = BasicMessageChannel<Any?>(binaryMessenger, "dev.flutter.pigeon.volumedeck_flutter.VolumedeckChannel.stop", codec)
        if (api != null) {
          channel.setMessageHandler { _, reply ->
            var wrapped: List<Any?>
            try {
              api.stop()
              wrapped = listOf<Any?>(null)
            } catch (exception: Throwable) {
              wrapped = wrapError(exception)
            }
            reply.reply(wrapped)
          }
        } else {
          channel.setMessageHandler(null)
        }
      }
    }
  }
}
/** Generated class from Pigeon that represents Flutter messages that can be called from Kotlin. */
@Suppress("UNCHECKED_CAST")
class VolumedeckCallback(private val binaryMessenger: BinaryMessenger) {
  companion object {
    /** The codec used by VolumedeckCallback. */
    val codec: MessageCodec<Any?> by lazy {
      StandardMessageCodec()
    }
  }
  fun onLocationStatusChange(statusArg: Boolean, callback: () -> Unit) {
    val channel = BasicMessageChannel<Any?>(binaryMessenger, "dev.flutter.pigeon.volumedeck_flutter.VolumedeckCallback.onLocationStatusChange", codec)
    channel.send(listOf(statusArg)) {
      callback()
    }
  }
  fun onLocationUpdate(speedArg: Double, volumeArg: Double, callback: () -> Unit) {
    val channel = BasicMessageChannel<Any?>(binaryMessenger, "dev.flutter.pigeon.volumedeck_flutter.VolumedeckCallback.onLocationUpdate", codec)
    channel.send(listOf(speedArg, volumeArg)) {
      callback()
    }
  }
  fun onStart(callback: () -> Unit) {
    val channel = BasicMessageChannel<Any?>(binaryMessenger, "dev.flutter.pigeon.volumedeck_flutter.VolumedeckCallback.onStart", codec)
    channel.send(null) {
      callback()
    }
  }
  fun onStop(callback: () -> Unit) {
    val channel = BasicMessageChannel<Any?>(binaryMessenger, "dev.flutter.pigeon.volumedeck_flutter.VolumedeckCallback.onStop", codec)
    channel.send(null) {
      callback()
    }
  }
}
