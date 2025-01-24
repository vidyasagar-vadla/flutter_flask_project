import 'dart:html';
import 'dart:ui_web' as ui;
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'YouTube IFrame Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: PasscodePage(), // Start with the PasscodePage
    );
  }
}

class PasscodePage extends StatefulWidget {
  @override
  _PasscodePageState createState() => _PasscodePageState();
}

class _PasscodePageState extends State<PasscodePage> {
  final TextEditingController _controller = TextEditingController();
  final String _correctPasscode = '1234'; // Set your passcode here

  void _checkPasscode() {
    if (_controller.text == _correctPasscode) {
      // Navigate to the IFrame widget if the passcode is correct
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => IFrameWidget(),
        ),
      );
    } else {
      // Show an error message if the passcode is incorrect
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Incorrect passcode. Please try again.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Enter Passcode'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0), // Increased padding for better layout
          child: Card(
            elevation: 8, // Add shadow for depth
            child: Padding(
              padding: const EdgeInsets.all(24.0), // Padding inside the card
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Please enter the passcode to continue:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20),
                  TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      labelText: 'Enter Passcode',
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.grey[200], // Light background for the text field
                    ),
                    obscureText: true, // Hide the input for security
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _checkPasscode,
                    child: Text('Submit'),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                      textStyle: TextStyle(fontSize: 16),
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

class IFrameWidget extends StatefulWidget {
  IFrameWidget();

  @override
  _IFrameWidgetState createState() => _IFrameWidgetState();
}

class _IFrameWidgetState extends State<IFrameWidget> {
  final IFrameElement _iFrameElement = IFrameElement();

  @override
  void initState() {
    super.initState();
    _iFrameElement.src = 'http://localhost:5000/stream'; // Adjust the URL as needed
    _iFrameElement.style.border = 'none';
    _iFrameElement.style.height = '500px'; // Increased height for better video display
    _iFrameElement.style.width = '100%';

    // Register the iframe element
    ui.platformViewRegistry.registerViewFactory(
      'iframeElement',
          (int viewId) => _iFrameElement,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('YouTube Video'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0), // Padding around the iframe
          child: HtmlElementView(
            viewType: 'iframeElement',
          ),
        ),
      ),
    );
  }
}