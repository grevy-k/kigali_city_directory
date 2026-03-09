##Kigali City Services & Places Directory

This project is a Flutter mobile application that helps users discover important services and places around Kigali City.

The application allows users to browse locations such as hospitals, police stations, libraries, cafés, restaurants, parks, and tourist attractions.

The app also allows authenticated users to create, update, and delete listings, and all data is stored in Firebase Firestore with real-time updates.

##Technologies Used

The project was built using the following technologies:

Flutter – mobile application development

Firebase Authentication – user login and signup

Cloud Firestore – database for storing listings

Provider – state management

OpenStreetMap (flutter_map) – embedded map display

URL Launcher – opening navigation directions in Google Maps

##Main Features

The application includes the following features:

##User Authentication

Users can create an account using email and password.

Features include:

user signup

login

logout

email verification

Each user also has a profile stored in Firestore.

##Directory of Services

The directory displays all available listings stored in Firestore.

Each listing contains:

place name

category

address

phone number

description

geographic location

Users can:

browse services

search listings

filter listings by category

##Create and Manage Listings

Authenticated users can create and manage their own listings.

Users can:

add a new listing

edit their listing

delete their listing

Each listing is linked to the user UID who created it.

##Map Integration

The application includes an embedded map that displays locations using OpenStreetMap.

##Users can:

view the location marker

open navigation directions in Google Maps.

Real-Time Updates

The directory updates automatically whenever a listing is added, edited, or deleted in Firestore.

This allows all users to see updates immediately.

##Application Screens

The application includes the following main screens:

Login Screen

Signup Screen

Email Verification Screen

Directory Screen

My Listings Screen

Map View Screen

Settings Screen

Listing Detail Screen

Add/Edit Listing Screen

Navigation between these screens is handled using a Bottom Navigation Bar.

##Firestore Database Structure

The database contains two main collections.

Users Collection
users
   └── userUID
         email
         displayName
         createdAt
Listings Collection
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

The createdBy field links each listing to the user who created it.

Project Structure

The Flutter project is organized into several folders.

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

This structure separates UI, state management, and backend services.

How to Run the Project

Clone the repository

git clone <your-repository-link>

Open the project in VS Code or Android Studio.

Install dependencies

flutter pub get

Configure Firebase for the project.

Run the application

flutter run

You can run the app on:

a physical Android device

an Android emulator
