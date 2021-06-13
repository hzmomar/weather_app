# Weather App

## Getting Started

This project integrate with [openweathermap.org](https://openweathermap.org/api) to get current and forecast weather. There are 3 environments set up for this app which is `Dev`, `Uat`, and `Prod`. Every environment will use different set of API key.

## Why need API key?

In order to integrate with OpenWeather API, need to pass `appid` which is API key

## To run the app in Android

run this command : 

`Dev`

```
flutter pub get
flutter run --debug --flavor dev -t lib/main_dev.dart --dart-define API_KEY=38e3b0aab7fb25802d05f2860d50cd30
```

`Uat`

```
flutter pub get
flutter run --debug --flavor uat -t lib/main_uat.dart --dart-define API_KEY=7f4054d89458ca1814a1adfe4b91db15
```

`Prod`

```
flutter pub get
flutter run --debug --flavor prod -t lib/main_prod.dart --dart-define API_KEY=0fb4d456f76d07711dd619e0109472d3
```

## To run the app in iOS

run this command : 

`Dev`

```
flutter pub get
flutter run --debug --flavor Debug-Dev -t lib/main_dev.dart --dart-define API_KEY=38e3b0aab7fb25802d05f2860d50cd30
```

`Uat`

```
flutter pub get
flutter run --debug --flavor Debug-Uat -t lib/main_uat.dart --dart-define API_KEY=7f4054d89458ca1814a1adfe4b91db15
```

`Prod`

```
flutter pub get
flutter run --debug --flavor Debug-Prod -t lib/main_prod.dart --dart-define API_KEY=0fb4d456f76d07711dd619e0109472d3
```

