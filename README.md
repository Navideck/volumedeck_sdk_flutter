<p align="center">
  <img src="https://navideck.com/sites/navideck.com/files/2023-10/Volumedeck%20SDK%20icon.png" height=150 />
</p>

# Volumedeck Flutter
[![volumedeck_flutter version](https://img.shields.io/pub/v/volumedeck_flutter?label=volumedeck_flutter)](https://pub.dev/packages/volumedeck_flutter)

## Overview

Volumedeck provides automatic volume adjustment based on GPS speed, improving the media-listening experience for users in vehicles and public transport.

## Key Features

- Speed-Sensitive Volume Adjustment: Automatically adjusts audio volume based on the vehicle's speed for consistent audio levels.
- Enhanced Safety and Focus: Eliminates the need for manual volume adjustments, enhancing driver safety and passenger convenience.
- Efficient and Reliable: Real-time speed-based volume control for smooth and uninterrupted listening experiences.
- Easy Integration: User-friendly API and comprehensive documentation for straightforward implementation.
- Versatile Applications: Enhances navigation, music streaming, and audio content delivery apps for various vehicles and public transport.
- Seamless integration with hardware volume keys for unified volume control in tandem with Volumedeck adjustments.
- Easy integration with UniversalVolume for unified volume control.
- Does not require internet connectivity

## Getting Started

### Setup Volumedeck

First configure your [Android](https://github.com/Navideck/Volumedeck-Android#running-in-background) and [IOS](https://github.com/Navideck/Volumedeck-iOS#step-3-configure-your-plist) project for the necessary permissions.

## Usage

### Initialize Volumedeck

```dart
Volumedeck.initialize(
    runInBackground: true, 
    autoStart: true // Set to false if you don't want to start volumedeck on initialization
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

### Start volumedeck
```dart
await Volumedeck.start();
```

### Stop volumedeck

```dart
Volumedeck.stop();
```

## API reference

You can find the API reference [here](https://pub.dev/documentation/volumedeck_flutter/latest/).

## Free to Use

Volumedeck SDK is freely available for use in both personal and commercial projects, offering full functionality without time limitations. However, when using the free version, a watermark will be displayed during runtime. It is strictly prohibited to hide, remove, or alter the watermark from the free version of Volumedeck SDK.

### Activation Key and Watermark Removal

To remove the watermark from your app, an activation key is available for purchase. The watermark-free version of Volumedeck SDK can be obtained through this activation key.

You need to set a different activation key for each platform.

To inquire about purchasing an activation key or for any other questions related to licensing and usage, please reach out to us at team@navideck.com. We are here to assist you with the process and provide the necessary information.

## Contact

For any inquiries, questions, or support, please don't hesitate to contact our team at team@navideck.com. Thank you for choosing Volumedeck Flutter Plugin!
