# Volumedeck Flutter

Flutter version of Volumedeck

## Getting Started

Setup [Android](https://github.com/Navideck/Volumedeck-Android#running-in-background) and [IOS](https://github.com/Navideck/Volumedeck-iOS#step-3-configure-your-plist) first

## Usage

Initialize Volumedeck

```dart
Volumedeck.initialize(
    runInBackground: true,
    autoStart: false,
    showStopButtonInAndroidNotification: true,
    showSpeedAndVolumeChangesInAndroidNotification: true,
    locationServicesStatusChange: (bool status) {
      // Get location on/off status updates
    },
    onLocationUpdate: (speed, volume) {
      // Updates of speed and volume changes
    },
    onStart: () {
      // Volumedeck started successfully
    },
    onStop: () {
      // Volumedeck stopped, either from stop method or from android notification
    },
);
```

Start volumedeck

```dart
Volumedeck.start();
```

Stop volumedeck

```dart
Volumedeck.stop();
```