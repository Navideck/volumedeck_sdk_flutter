/// Android specific configurations
///
/// [notificationTitle] - The title of the notification. The default value is null.
///
/// [notificationSubtitleFormat] - The subtitle format of the notification. The default value is null.
/// Subtitle format must contain two placeholders `%s`, For example: `Speed: %s, Volume: %s`
/// First placeholder will be replaced with speed and second placeholder will be replaced with volume.
///
/// [showSpeedAndVolumeChangesInNotification] - Whether to show speed and volume changes in notification subtitle or not. The default value is `false`.
///
/// [notificationStopButtonText] - The stop button text of the notification. The default value is null.
///
/// [showStopButtonInNotification] - Whether to show stop button in notification or not. The default value is `false`.
///
/// [notificationIconDrawable] - The icon drawable of the notification. The default value is null.
/// First add icon drawable to `android/app/src/main/res/drawable` folder. and then set the drawable name as the value of this property.
/// for example `notification_icon.png` should be set as `notification_icon` for this property.
///
class AndroidConfig {
  String? notificationTitle;
  String? notificationSubtitleFormat;
  bool? showSpeedAndVolumeChangesInNotification;
  String? notificationStopButtonText;
  bool? showStopButtonInNotification;
  String? notificationIconDrawable;

  AndroidConfig({
    this.notificationTitle,
    this.notificationSubtitleFormat,
    this.showSpeedAndVolumeChangesInNotification,
    this.notificationStopButtonText,
    this.showStopButtonInNotification,
    this.notificationIconDrawable,
  });
}
