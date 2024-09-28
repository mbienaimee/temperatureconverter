import 'package:flutter/material.dart';

void main() {
  runApp(const TemperatureConverterApp());
}

class TemperatureConverterApp extends StatelessWidget {
  const TemperatureConverterApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
  }
}

class TemperatureConverterPage extends StatefulWidget {
  const TemperatureConverterPage({Key? key}) : super(key: key);

  @override
  _TemperatureConverterPageState createState() => _TemperatureConverterPageState();
}

class _TemperatureConverterPageState extends State<TemperatureConverterPage> {
  bool isFahrenheitToCelsius = true;
  final TextEditingController _temperatureController = TextEditingController();
  String _result = '';
  List<String> _conversionHistory = [];

  void _convertTemperature() {
    if (_temperatureController.text.isEmpty) return;

    double inputTemp = double.parse(_temperatureController.text);
    double convertedTemp;
    String fromUnit, toUnit;

    if (isFahrenheitToCelsius) {
      convertedTemp = (inputTemp - 32) * 5 / 9;
      fromUnit = '°F';
      toUnit = '°C';
    } else {
      convertedTemp = inputTemp * 9 / 5 + 32;
      fromUnit = '°C';
      toUnit = '°F';
    }

    setState(() {
      _result = convertedTemp.toStringAsFixed(2);
      _conversionHistory.insert(0,
          '$fromUnit to $toUnit: ${inputTemp.toStringAsFixed(1)} => $_result');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Temperature Converter'),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        foregroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Theme.of(context).colorScheme.primaryContainer,
              Theme.of(context).colorScheme.background,
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
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
                          const SizedBox(height: 20),
                          TextField(
                            controller: _temperatureController,
                            keyboardType: TextInputType.numberWithOptions(decimal: true),
                            decoration: InputDecoration(
                              labelText: 'Enter temperature in ${isFahrenheitToCelsius ? '°F' : '°C'}',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              filled: true,
                              fillColor: Theme.of(context).colorScheme.surface,
                            ),
                          ),
                          const SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: _convertTemperature,
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            child: const Text('Convert', style: TextStyle(fontSize: 18)),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Text(
                            'Result',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            '$_result ${isFahrenheitToCelsius ? '°C' : '°F'}',
                            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                              color: Theme.of(context).colorScheme.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Conversion History',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          const SizedBox(height: 8),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: _conversionHistory.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(vertical: 4),
                                child: Text(
                                  _conversionHistory[index],
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}