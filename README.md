# Weather Forecast Application

This project was developed for internship test at Sagara Technology.

This app is a simple weather forecast app that uses the [OpenWeatherMap API](https://openweathermap.org/) to get the weather forecast data. The app has 1 screens and 1 modal bottom sheet, the first screen is the home screen that displays the current weather and the next 5 days weather forecast. The modal bottom sheet is used to display list of city and user can select the city to get the weather forecast of that city.

## Table of Contents

- [Installation and Setup](#installation-and-setup)
- [Packages Used](#packages-used)
- [Main Features](#main-features)
- [Screenshots](#screenshots)

## Installation and Setup
You don't need to have api key to run this app, the api key is already included in the app. To run this app, follow these steps: 

1. Clone Repository :

   ```bash
   git clone https://github.com/letha11/sagara-mobile-msib-test.git
   ```
2. Navigate to the project directory:

   ```bash
   cd sagara-mobile-msib-test
   ```

3. Install dependencies:

   ```bash
   flutter pub get
   ```

4. Run the app:

   ```bash
   flutter run
   ```

## Packages Used

- BLoC
- Dio
- fpdart
- get_it

## Main Features

- Display current weather based on user location or selected city
- Display 5 days weather forecast
- Select city to get weather forecast
- Pull to refresh

## Screenshots

<p align="center">
  <img src="https://github.com/user-attachments/assets/14bbb56c-1ed8-4c29-b560-4cffe28ebeef" width=200 style="padding: 5px">
  <img src="https://github.com/user-attachments/assets/e852cef9-e394-4031-95e3-9ecbf3986d65" width=200 style="padding: 5px">
  <img src="https://github.com/user-attachments/assets/fb88b061-ae61-41fa-a5f8-f952731a67c5" width=200 style="padding: 5px">
</p>