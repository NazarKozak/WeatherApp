# WeatherApp

WeatherApp is an iOS application designed to help users search for locations and check weather information. The app integrates with the [WeatherAPI](https://www.weatherapi.com/) to provide real-time weather data for various locations.

## Features
- Search for locations by name.
- View current weather details for a selected location.
- Clean and intuitive user interface.

## Requirements
- Xcode 15 or later
- iOS 17.0 or later
- A valid [WeatherAPI](https://www.weatherapi.com/) key

## Setup Instructions

### Step 1: Clone the Repository
Clone the repository to your local machine:

```
git clone https://github.com/your-repo/WeatherApp.git
cd WeatherApp
```

### Step 2: Install Dependencies

No external dependencies are required for this project as it is built with native Swift and SwiftUI.

### Step 3: Configure API Key

To run the project, you need to replace the placeholder API key with your valid WeatherAPI key. Follow these steps:
1. Obtain a WeatherAPI key from WeatherAPI’s website.
2. Open the Configuration folder in the project directory.
3. Replace REPLACE_WITH_YOUR_KEY in the following files with your actual API key:
•	Dev.xcconfig
•	Prod.xcconfig

You will be prompted with an error message if the key is not replaced.

### Step 4: Open the Project in Xcode
1.	Open WeatherApp.xcodeproj or WeatherApp.xcworkspace in Xcode.
2.	Select the appropriate scheme (Debug or Release) from the toolbar.
3.	Choose your desired simulator or physical device for testing.

### Step 5: Build and Run the App
1.	Build the project by pressing Cmd + B or selecting Product > Build from the menu bar.
2.	Run the app by pressing Cmd + R or selecting Product > Run from the menu bar.

### Step 6: Enjoy the App

Once the app is running, search for any location and view its current weather details!

## Troubleshooting

If you encounter issues:
-	Ensure you’ve replaced the API key in the xcconfig files.
-	Make sure your WeatherAPI key is valid and has sufficient API call limits.
-	Ensure you have an active internet connection while using the app.

## Contributing

If you’d like to contribute to this project, feel free to fork the repository and submit a pull request.

## License

This project is open-source and available under the MIT License.
