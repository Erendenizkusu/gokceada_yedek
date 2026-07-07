# Gökçeada Guide — island travel app

A travel guide for **Gökçeada (Imbros)**, Turkey's largest island: discover where to stay,
eat and explore, with interactive maps, directions, and community reviews. Built with Flutter
and Firebase, and **published on Google Play and the App Store**.

## Features

- 🏨 Browse guesthouses, restaurants and points of interest across the island
- 🗺️ Google Maps with the user's live location and route directions (polylines)
- ⭐ Community **reviews and star ratings** — read others' and add your own
- 📷 Photo uploads via Firebase Storage
- 🔐 Sign in with **email or Google**
- 🌍 **6 languages:** Turkish, English (US/UK), Greek, Romanian, Bulgarian
- 📱 Live on **Google Play** and the **App Store**

## Tech stack

- **Flutter** (Android + iOS)
- **Firebase:** Authentication (email + Google Sign-In), Cloud Firestore, Realtime Database, Storage
- **Google Maps:** `google_maps_flutter`, polyline routing, `geolocator` / `location`
- State & i18n: `provider`, `easy_localization`, `shared_preferences`
- Monetization: `google_mobile_ads` (AdMob)

## Project structure

```
lib/
├── core/      colors, constants, shared widgets (rating bar, search bar, fonts)
├── pages/     home, login / register, users console
├── product/   listing cards, comments, rating & review UI
├── helper/    maps helpers, in-app webview
└── main.dart
```

## Getting started

**Prerequisites:** Flutter SDK, a Firebase project, a Google Maps API key.

```bash
flutter pub get
flutterfire configure          # regenerate firebase_options.dart for your project
# add your Google Maps API key to the Android/iOS config
flutter run
```

> Client-side Firebase and Google Maps keys ship in the app by design; secure them with
> Firebase Security Rules and API-key restrictions in the Google Cloud console.

## Download

- **Google Play:** _link coming soon_
- **App Store:** _link coming soon_

## Screenshots

_Coming soon._
