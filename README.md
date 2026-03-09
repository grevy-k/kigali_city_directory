# Kigali City Services & Places Directory

A Flutter mobile application that helps users discover important services and places around Kigali City.

Users can browse locations such as hospitals, police stations, libraries, cafés, restaurants, parks, and tourist attractions.

Authenticated users can create, update, and delete listings. All data is stored in **Firebase Cloud Firestore** with **real-time updates**.

---

## Technologies Used

- **Flutter** — mobile application development
- **Firebase Authentication** — user login and signup
- **Cloud Firestore** — database for storing listings
- **Provider** — state management
- **OpenStreetMap (flutter_map)** — embedded map display
- **URL Launcher** — opening navigation directions in Google Maps

---

## Main Features

### 1) User Authentication

Users can create an account using email and password. Features include:

- User signup
- Login
- Logout
- Email verification

Each user also has a profile stored in Firestore.

### 2) Directory of Services

The directory displays all listings stored in Firestore. Each listing contains:

- Place name
- Category
- Address
- Phone number
- Description
- Geographic location

Users can:

- Browse services
- Search listings
- Filter listings by category

### 3) Create and Manage Listings

Authenticated users can create and manage their own listings. Users can:

- Add a new listing
- Edit their listing
- Delete their listing

Each listing is linked to the user UID who created it.

### 4) Map Integration

The application includes an embedded map that displays locations using OpenStreetMap.

Users can:

- View the location marker
- Open navigation directions in Google Maps

### 5) Real-Time Updates

The directory updates automatically whenever a listing is added, edited, or deleted in Firestore.

This allows all users to see updates immediately.

---

## Application Screens

The application includes the following main screens:

- Login Screen
- Signup Screen
- Email Verification Screen
- Directory Screen
- My Listings Screen
- Map View Screen
- Settings Screen
- Listing Detail Screen
- Add/Edit Listing Screen

Navigation between these screens is handled using a **Bottom Navigation Bar**.

---

## Firestore Database Structure

The database contains two main collections.

### Users Collection

```
users
   └── userUID
         email
         displayName
         createdAt
```

### Listings Collection

```
listings
   └── listingID
         name
         category
         address
         phone
         description
         location (GeoPoint)
         createdBy
         createdAt
         updatedAt
```

The `createdBy` field links each listing to the user who created it.

---

## Project Structure

The Flutter project is organized into several folders:

```
lib
 ├── models
 │    listing.dart
 │
 ├── providers
 │    auth_provider.dart
 │    listing_provider.dart
 │    settings_provider.dart
 │
 ├── services
 │    auth_service.dart
 │    listing_service.dart
 │
 ├── screens
 │    auth
 │    directory
 │    map
 │    my_listings
 │    settings
 │
 ├── widgets
 │    listing_tile.dart
 │
 └── main.dart
```

This structure separates the user interface, state management, and backend services.

---

## How to Run the Project

### 1) Clone the Repository

```bash
git clone <your-repository-link>
```

### 2) Open the Project

Open the project using either:

- Visual Studio Code
- Android Studio

### 3) Install Dependencies

```bash
flutter pub get
```

### 4) Configure Firebase

Add your Firebase configuration files:

- `google-services.json` for Android
- `GoogleService-Info.plist` for iOS

Enable the following services in Firebase:

- Firebase Authentication
- Cloud Firestore

### 5) Run the Application

```bash
flutter run
```

You can run the app on:

- A physical Android device
- An Android emulator

---

## Future Improvements

Possible future enhancements include:

- User ratings and reviews
- Image uploads for listings
- Nearby places feature
- Push notifications
- AI-based place recommendations

---

## Author

**Grevy Karuretwa**  
Flutter Developer | Software Engineering Student