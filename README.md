# Arduino Controller Flutter Project

## Overview

This Flutter project is designed to control an Arduino chip via a mobile application.
The app provides a user-friendly interface for sending commands and receiving data from an Arduino microcontroller.
It is built using Flutter, allowing for cross-platform compatibility across 
Android, iOS.

## Features

- **Arduino Communication** :  Seamlessly connect to an Arduino chip over Bluetooth or WiFi, depending on the hardware setup.
- **Real-Time Control**  : Send commands to the Arduino in real-time, allowing for instant control of connected devices.
- **Data Monitoring**   : Receive and display sensor data from the Arduino chip on your device.
- **Cross-Platform**   : Built with Flutter, the app runs on multiple platforms, including Android, iOS

## Project Structure

The project is organized into several directories and files, each serving a specific purpose:

 - **`lib/`**: Contains the main application code, including the user interface and business logic.
 - **`main.dart`**: The entry point of the application.
 - **`my_app.dart`**: Main app widget configuration.
 - **`control_screen.dart`**: Screen for controlling the Arduino and displaying data.
 - **`api_service.dart`**: Handles communication with the Arduino chip.
 - **`models/`**: Contains data models used throughout the app for data handling and manipulation.
 - **`assets/`**: Stores static resources such as images, icons, and fonts used in the app.
 - **`screen/`**: Contains additional UI screens and widgets used in the application.
 - **`android/`**, **`ios/`**, **`web/`**, **`linux/`**, **`macos/`**, **`windows/`**: Platform-specific files and configurations for running the app on different environments.

## Getting Started

### Prerequisites

Before begin make sure you have the following installed:

- Flutter 3.-.- (Above 3)

### Installation

1. Clone the repository

   ```
   git clone https://github.com/jibinkj-07/Arduino-Controller.git
   
   ```
2. Install Flutter: Ensure Flutter is installed on your machine. You can find installation instructions here.

3. Dependencies: Navigate to the project directory and run flutter pub get to install the necessary dependencies.

4. Run the App: Use flutter run to launch the app on your desired platform (mobile, web, or desktop).

## Contact
   For any questions or suggestions, please contact jibinkunnumpurath@gmail.com.
