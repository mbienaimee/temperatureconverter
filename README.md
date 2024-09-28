temperatureconverter

🌡️ Temperature Converter App
Overview
This is a Flutter application that allows users to easily convert temperatures between Fahrenheit (°F) and Celsius (°C). The app includes a sleek and intuitive interface with options to switch between conversion modes and view a history of past conversions.

Features
Convert between Fahrenheit and Celsius.
Clean and Material 3 design using a teal color scheme.
View detailed conversion history.
Interactive UI with segmented buttons for unit selection.
Handles edge cases such as empty input and invalid numbers.

How It Works
The user inputs a temperature value in either Fahrenheit or Celsius.
Based on the selected conversion mode (Fahrenheit to Celsius or Celsius to Fahrenheit), the app converts the input temperature and displays the result.
Each conversion is logged in a history list showing the input value and the converted result.
The user can toggle between Fahrenheit and Celsius conversion modes using a segmented button.
Widgets & Code Breakdown
MaterialApp
The entire app is wrapped in a MaterialApp widget that sets the primary theme of the app, using Material 3 and a teal color scheme. This enhances the UI's visual appeal and maintains a cohesive design.

dart

MaterialApp(
title: 'Temperature Converter',
theme: ThemeData(
colorScheme: ColorScheme.fromSeed(
seedColor: Colors.teal,
brightness: Brightness.light,
),
useMaterial3: true,
fontFamily: 'Roboto',
),
home: const TemperatureConverterPage(),
);
Conversion Logic
The conversion logic is handled within the \_convertTemperature() method. This function checks if the input is valid and converts it based on the selected mode.

void \_convertTemperature() {
if (\_temperatureController.text.isEmpty) return;

double inputTemp = double.parse(\_temperatureController.text);
double convertedTemp;
String fromUnit, toUnit;

if (isFahrenheitToCelsius) {
convertedTemp = (inputTemp - 32) _ 5 / 9;
fromUnit = '°F';
toUnit = '°C';
} else {
convertedTemp = inputTemp _ 9 / 5 + 32;
fromUnit = '°C';
toUnit = '°F';
}

setState(() {
\_result = convertedTemp.toStringAsFixed(2);
\_conversionHistory.insert(0, '$fromUnit to $toUnit: ${inputTemp.toStringAsFixed(1)} => $\_result');
});
}
Segmented Button
The app provides a segmented button to switch between conversion modes.

SegmentedButton<bool>(
segments: const [
ButtonSegment<bool>(value: true, label: Text('°F to °C')),
ButtonSegment<bool>(value: false, label: Text('°C to °F')),
],
selected: {isFahrenheitToCelsius},
onSelectionChanged: (Set<bool> newSelection) {
setState(() {
isFahrenheitToCelsius = newSelection.first;
});
},
),
Conversion History
The conversion history is dynamically displayed below the result, allowing users to see all recent conversions.

ListView.builder(
shrinkWrap: true,
physics: NeverScrollableScrollPhysics(),
itemCount: \_conversionHistory.length,
itemBuilder: (context, index) {
return Padding(
padding: const EdgeInsets.symmetric(vertical: 4),
child: Text(\_conversionHistory[index]),
);
},
);
How to Run the App
Prerequisites:
Flutter SDK
A text editor (VSCode, Android Studio, etc.)
An Android/iOS simulator or physical device
Steps:
Clone the repository:
bash

git clone https://github.com/mbienaimee/temperatureconverter
Navigate to the project directory:
bash

cd temperature-converter-app
Get the required Flutter packages:
bash

flutter pub get
Run the app on your emulator or connected device:
bash

flutter run
Contribution
Feel free to open issues or submit pull requests to improve the app!

License
This project is licensed under the MIT License - see the LICENSE file for details.
