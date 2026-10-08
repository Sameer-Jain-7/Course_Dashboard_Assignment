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

## Screenshots
<img width="302" height="656" alt="image" src="https://github.com/user-attachments/assets/3616b4a9-d611-4631-a965-9554fb526154" />
<img width="302" height="656" alt="image" src="https://github.com/user-attachments/assets/80de925f-adee-42a5-afa9-5ef6447db5dc" />
<img width="302" height="656" alt="image" src="https://github.com/user-attachments/assets/daeb1901-3442-4fcf-8f3e-28659a096ef2" />


