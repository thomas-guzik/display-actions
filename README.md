# CopyNotifier

CopyNotifier is a macOS application that provides a visual notification when the user performs a copy action using the Command+C keyboard shortcut.

## Features

- Displays a small popover notification when Command+C is pressed
- Uses a status bar icon for easy access
- Automatically hides the notification after 1 second
- Requests necessary accessibility permissions for keyboard monitoring

## Requirements

- macOS (developed and tested on macOS Sequoia)
- Xcode (for building and running the project)

## Installation

1. Clone this repository or download the source code.
2. Open Terminal and navigate to the project directory.

## Building the Project

1. Make sure you have Xcode command line tools installed. If not, run:
   ```
   xcode-select --install
   ```
2. To build the project, run the following command in the project directory:
   ```
   swiftc -o CopyNotifier main.swift CopyNotifier.swift
   ```
   This will compile the Swift files and create an executable named `CopyNotifier`.

## Running the Application

There are two ways to run the application:

### Method 1: Using the Terminal

1. After building the project, you can run the application directly from the terminal:
   ```
   ./CopyNotifier
   ```

### Method 2: Using Xcode

1. Open the project folder in Xcode.
2. Select the main.swift file as the target.
3. Click the "Run" button (play icon) in the top left corner of Xcode.

## Usage

1. Launch the CopyNotifier application using one of the methods described above.
2. Grant the necessary accessibility permissions when prompted.
3. The application will run in the background with a clipboard icon (📋) in the status bar.
4. Whenever you use Command+C to copy something, a small popover will appear briefly to confirm the action.

## How It Works

CopyNotifier uses the following components:

- `CopyNotifier.swift`: Main class that handles the status item, popover, and global event monitoring.
- `main.swift`: Sets up the application and manages permissions.

The application uses Apple's Accessibility API to monitor global keyboard events, specifically watching for the Command+C combination.

## Permissions

CopyNotifier requires accessibility permissions to function properly. These permissions are necessary for the application to monitor keyboard events system-wide. The app will prompt you to enable these permissions in System Preferences when you first run it.

## Contributing

Contributions to CopyNotifier are welcome! Please feel free to submit a Pull Request.

## License

This project is open source and available under the [MIT License](LICENSE).

## Support

If you encounter any problems or have any questions, please file an issue on the GitHub repository.
