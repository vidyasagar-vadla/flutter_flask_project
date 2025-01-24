This project is a Flutter web application that allows users to enter a passcode to access a YouTube video streamed through an iframe. The application consists of two main components:

-Passcode Entry Page: A simple interface for users to enter a passcode.
-IFrame Widget: Displays the YouTube video once the correct passcode is entered.

1. main.dart
This file contains the main application logic and UI components. It includes:
-MyApp Class: The root widget of the application that sets up the MaterialApp and starts with the PasscodePage.
-PasscodePage Class:
	Contains a TextField for users to input a passcode.
	Validates the entered passcode against a predefined value (1234).
	If the passcode is correct, it navigates to the IFrameWidget.
	If the passcode is incorrect, it displays an error message using a Snackbar.
-IFrameWidget Class:
	Displays a YouTube video in an iframe.
	The iframe source is set to a local Flask backend URL (http://localhost:5000/stream), which is expected to stream the video.

2. flasksd.py
	This file is a Flask server script that handles video streaming. It includes:
-Flask Setup: Initializes a Flask application with CORS enabled to allow cross-origin requests.
-Stream Video Route:
	Defines a /stream endpoint that uses yt-dlp to fetch the video stream URL from YouTube.
	Streams the video content back to the client as an HTTP response.
	Handles exceptions and returns a 404 error if something goes wrong.


Implementation: 
Prerequisites
-Flutter SDK installed on your machine.
-Python and Flask installed for the backend.
-yt-dlp library installed for video extraction.

Running the Application:
-Set Up the Flask Server:
	Navigate to the directory containing flasksd.py.
	Run the Flask server using the command: "python flasksd.py"
	Ensure the server is running on http://localhost:5000.

-Run the Flutter Web Application:
	Navigate to the directory containing main.dart.
	Use the following command to run the Flutter web application: "flutter run -d chrome"
	This will open the application in your default web browser.

-Using the Application:
	Enter the passcode 1234 in the input field and click "Submit".
	If the passcode is correct, you will be redirected to the page displaying the YouTube video. if not it will show password is 	incorrect

Conclusion:
This project demonstrates a simple implementation of a passcode-protected video streaming application using Flutter for the frontend and Flask for the backend. It showcases the integration of web technologies and provides a foundation for further enhancements, such as user authentication and improved UI/UX design.

