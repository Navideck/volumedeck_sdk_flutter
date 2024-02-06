/// Android specific configurations
///
/// [notificationTitle] - The title of the notification. The default value is null.
///
/// [notificationSubtitle] - The subtitle of the notification.
/// You can display the speed and volume by including the placeholders `%s` for speed and `%v` for volume, for example: `Speed: %s m/s | Volume: %v`.
/// If null then no subtitle is displayed.
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
  String? notificationSubtitle;
  String? notificationStopButtonText;
  bool? showStopButtonInNotification;
  String? notificationIconDrawable;

  AndroidConfig({
    this.notificationTitle,
    this.notificationSubtitle,
    this.notificationStopButtonText,
    this.showStopButtonInNotification,
    this.notificationIconDrawable,
  });
}
