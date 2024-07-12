# Media and Cultural Council App

## Overview

The Media and Cultural Council App is designed to assist the Media and Cultural Council at IIT Kanpur in managing its events, workshops, and overall activities efficiently. Built with Flutter and Firebase, the app provides various functionalities to streamline operations and enhance communication within the council and with students.

<img src="https://github.com/user-attachments/assets/68fcb53d-94e7-47de-b0ee-152d5ab73ce4" width="18%" height="18%">
<img src="https://github.com/user-attachments/assets/b83c0141-7b69-43cf-a366-4166a846a04b" width="18%" height="18%">
<img src="https://github.com/user-attachments/assets/a356d06d-6f75-408f-8683-a70948a5d9df" width="18%" height="18%">
<img src="https://github.com/user-attachments/assets/a115f62f-e62c-4c41-99d5-addb8bc47759" width="18%" height="18%">
<img src="https://github.com/user-attachments/assets/eee83e78-eaf3-4df7-a4e5-69fed399f8d5" width="18%" height="18%">
<img src="https://github.com/user-attachments/assets/46ab5146-000b-4225-aef3-c70dca0af2bf" width="18%" height="18%">
<img src="https://github.com/user-attachments/assets/1e394c7a-15e0-4846-a30e-a2ca457c90fe" width="18%" height="18%">
<img src="https://github.com/user-attachments/assets/d245e871-ee35-497d-9951-3363201e24fb" width="18%" height="18%">

## Features

- **Event Notifications**: Send notifications about upcoming events to users.
- **Team Structure**: View the organizational structure of the council.
- **Media Management**: Access and manage videos and photos uploaded by the council.
- **Activity Tracking**: Monitor activities of various clubs and societies.
- **User Roles**:
  - **Council Coordinators**: Full control over council activities, including sending event notifications, adding events, and managing team structure.
  - **Club Coordinators**: Manage data specific to their own clubs without affecting other clubs' data.
  - **Students/Viewers**: View council activities and data without needing to log in.

## Technical Details

- **Platform**: Flutter
- **Backend**: Firebase
  - **Firebase Messaging**: For sending notifications.
  - **Firebase Firestore**: For real-time database management.
  - **Firebase Storage**: For storing and managing media files.

## Installation

1. **Clone the repository**:
   ```bash
   git clone https://github.com/pm020202pm/MnC_App.git
2. **Navigate to the Project Directory**
   ```bash
   cd media-cultural-council-app
4. **Install Dependencies**
   ```bash
   flutter pub get
6. **Set Up Firebase**
   - Create a Firebase Project.
   - Add an Android/iOS App to Your Firebase Project.
   - Add Firebase SDKs to the App.
   - Configure Firebase Services.

6. **Run the app**
   ```bash
   flutter run
   
