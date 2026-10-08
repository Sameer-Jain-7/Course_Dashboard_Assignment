# Course Dashboard

## 1. Architecture

I chose SwiftUI with MVVM and a repository layer. Views render state, view models handle screen actions, and repositories keep API and persistence details out of the UI. This keeps the app straightforward to change and test. SwiftData provides local persistence.

## 2. Offline Support

Course and lesson records, including completion state, are stored in SwiftData. The repository fetches courses remotely and saves them locally; if the request fails, it loads the saved courses. Lesson completion is saved locally. This prototype does not yet synchronize offline changes with a server.

## 3. Security

In production, I would store authentication and refresh tokens in the iOS Keychain, use short-lived access tokens, and send requests only over HTTPS. This sample uses mock authentication and does not issue tokens.

## 4. Scale

For one million users and hundreds of courses, I would:

- Add server-side pagination and search so clients fetch only the courses they need.
- Use authenticated, versioned APIs with rate limiting and resilient retries.
- Add a background sync queue for offline lesson updates, with conflict handling.
- Add observability, performance monitoring, and broader automated tests.

## 5. Second Platform: Android

I would build the Android app in Kotlin with Jetpack Compose and the same MVVM and repository boundaries. Retrofit or Ktor would handle API calls, Room would cache courses and lesson progress, and Android Keystore would protect authentication tokens. A repository would choose remote or cached data and synchronize queued offline changes when connectivity returns.
