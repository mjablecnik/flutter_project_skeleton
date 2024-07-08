## Supported Flutter version
3.22.0

## Installation

  ```
  1) Clone this repository
  2) Setup fvm and Flutter
  3) Run: fvm flutter pub get
  4) Run: fvm dart run build_runner build --delete-conflicting-outputs
  5) Run: fvm flutter pub run slang 
  6) Edit lib/settings.dart for your local setup
  7) Run: fvm flutter run --dart-define="FLAVOR=production"
  ```

## Setup fvm and Flutter
  ```
  1) Run: dart pub global activate fvm
  2) Run: fvm install <flutter version>
  3) Run: fvm use <flutter version>
  ```

## Run builders
  ```
  1) Build runner: fvm dart run build_runner build --delete-conflicting-outputs
  2) Translations: fvm flutter pub run slang watch 
  3) Create icons: fvm flutter pub run flutter_launcher_icons
  4) Rename project: fvm dart run package_rename
  5) Make release: fvm flutter build apk --dart-define="FLAVOR=production"
  ```

## Run tests
For update golden tests run: ` fvm flutter test --update-goldens --tags golden `
For check golden tests run: ` fvm flutter test --tags golden `

## Release new version

  ```
  1) Run tests
  2) Update app version and build number
  3) Make commit: git commit -m 'Bump to version 1.x.x'
  4) Create tag of new version: git tag v1.x.x master
  5) Push tag of new version to server: git push origin v1.x.x
  6) Make release: fvm flutter build apk --dart-define="FLAVOR=production"                
  6) Make release: fvm flutter build appBundle --dart-define="FLAVOR=production"                
  6) Make iOS release: fvm flutter build ipa --dart-define="FLAVOR=production"                
  ```

## Setup push notifications
For create local notifications you can use this code:
```dart
AwesomeNotifications().createNotification(
  content: NotificationContent(
      id: 10,
      channelKey: 'basic_channel',
      actionType: ActionType.Default
      title: 'Hello World!',
      body: 'This is my first notification!',
  )
);
```

For push notifications using FCM (Firebase Cloud Messaging) you must setup [awesome_notifications_fcm](https://pub.dev/packages/awesome_notifications_fcm).
