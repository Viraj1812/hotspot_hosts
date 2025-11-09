# Hotspot Hosts - Onboarding Questionnaire

A Flutter application for onboarding hotspot hosts through an interactive questionnaire system. This app allows potential hosts to select their preferred experience types and provide detailed responses through text, audio, or video inputs.

## 📱 Features Implemented

### ✅ Task 1: Experience Type Selection Screen

- **API Integration**: Fetches experiences from the provided API endpoint (`https://staging.chamberofsecrets.8club.co/v1/experiences?active=true`)
- **Multi-Selection**: Users can select and deselect multiple experience cards
- **Visual Feedback**: 
  - Selected cards display full-color images
  - Unselected cards display grayscale versions using color matrix filter
- **Text Input**: Multi-line text field with 250 character limit for additional description
- **State Management**: Selected experience IDs and text are stored in the application state
- **State Logging**: State is maintained in Riverpod state management (can be accessed via `onboardingStateNotifierProvider`)
- **UI/UX**: Clean interface with proper spacing, styling, and responsive layout
- **Navigation**: Progress indicator and smooth page transitions

### ✅ Task 2: Onboarding Question Screen

- **Text Input**: Multi-line text field with 600 character limit
- **Audio Recording**: 
  - Full audio recording functionality with permission handling
  - Real-time animated waveform visualization during recording
  - Recording duration display (MM:SS format)
  - Delete recorded audio
  - Audio playback support (play/pause functionality)
- **Video Recording**:
  - Video recording with camera integration
  - Video duration tracking
  - Delete recorded video
  - Video playback in dedicated player screen
- **Dynamic Layout**: 
  - Audio and video recording buttons automatically hide when corresponding media is recorded
  - Next button adapts to available space
  - Smooth UI transitions based on recording state

## 🎨 Brownie Points (Optional Enhancements)

### ✅ Implemented

1. **State Management**: 
   - Implemented using **Riverpod** for robust state management
   - Clean separation of concerns with StateNotifier pattern
   - Proper state persistence across navigation

2. **API Management**: 
   - Structured API calls using a repository pattern
   - Error handling with Either type (dartz package)
   - Clean separation between data layer and UI layer

3. **Audio/Video Playback**: 
   - Audio playback with play/pause controls using `just_audio`
   - Video playback in dedicated screen using `chewie` and `video_player`
   - Proper resource management and disposal

4. **UI/UX Enhancements**:
   - Custom animated waveform widget for audio recording
   - Progress indicator for onboarding flow
   - Responsive layout handling with keyboard awareness
   - Custom styling with SpaceGrotesk font family
   - Proper error handling with toast notifications

5. **Code Quality**:
   - Clean, modular code structure
   - Separation of concerns (screens, widgets, controllers, services, repositories)
   - Proper resource disposal and memory management
   - Type-safe models with JSON serialization

## 🏗️ Project Structure

```
lib/
├── config/
│   └── assets/          # Generated asset configurations
├── constants/           # App constants (strings, styles, endpoints)
├── features/
│   └── onboarding/
│       ├── controller/  # State management (Riverpod StateNotifier)
│       ├── models/      # Data models
│       ├── repository/  # API repository layer
│       └── view/        # UI screens and widgets
├── helpers/            # Utility functions (API, navigation, toast)
├── routes/              # Auto route configuration
├── services/            # Audio and video service implementations
└── widgets/             # Reusable UI components
```

## 🛠️ Technology Stack

- **Flutter**: ^3.9.0
- **State Management**: `flutter_riverpod` ^3.0.3
- **Routing**: `auto_route` ^10.0.1
- **API**: Custom API helper with `master_utility` package
- **Audio Recording**: `record` ^6.1.2
- **Audio Playback**: `just_audio` ^0.10.5
- **Video Recording**: `image_picker` ^1.2.0
- **Video Playback**: `chewie` ^1.13.0, `video_player` ^2.10.0
- **Error Handling**: `dartz` ^0.10.1
- **UI Components**: Custom widgets with Material Design

## 📦 Dependencies

Key dependencies used in this project:

- `flutter_riverpod`: State management
- `auto_route`: Navigation and routing
- `master_utility`: API service wrapper
- `record`: Audio recording
- `just_audio`: Audio playback
- `image_picker`: Video/image capture
- `chewie`: Video player UI
- `video_player`: Video playback engine
- `dartz`: Functional programming (Either type)
- `toastification`: Toast notifications
- `path_provider`: File system access
- `permission_handler`: Runtime permissions

## 🚀 Getting Started

### Prerequisites

- Flutter SDK (3.9.0 or higher)
- Dart SDK
- Android Studio / VS Code with Flutter extensions
- iOS Simulator / Android Emulator or physical device

### Installation

1. Clone the repository:
```bash
git clone <repository-url>
cd hotspot_hosts
```

2. Install dependencies:
```bash
flutter pub get
```

3. Generate route files (if needed):
```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

4. Run the app:
```bash
flutter run
```

## 📱 Screens

1. **Onboarding Screen**: Main questionnaire flow with two pages
   - Page 1: Experience selection with text input
   - Page 2: Question with text, audio, and video input options

2. **Thank You Screen**: Confirmation screen displaying:
   - Selected experiences
   - User responses
   - Submission confirmation

3. **Video Player Screen**: Dedicated screen for video playback

## 🔧 Key Features Breakdown

### Experience Selection
- Horizontal scrollable list of experience cards
- Tap to select/deselect
- Visual feedback with color/grayscale states
- Text input for additional description (250 chars max)

### Question Screen
- Text input (600 chars max)
- Audio recording with waveform visualization
- Video recording with camera integration
- Dynamic UI that adapts to recording state
- Playback controls for recorded media

### State Management
- Centralized state using Riverpod
- State includes:
  - Experience list
  - Selected experiences
  - Text descriptions for both screens
  - Loading states

## 📝 API Integration

**Endpoint**: `GET https://staging.chamberofsecrets.8club.co/v1/experiences?active=true`

**Response Structure**:
```json
{
  "message": "string",
  "data": {
    "experiences": [
      {
        "id": 0,
        "name": "string",
        "tagline": "string",
        "description": "string",
        "image_url": "string",
        "icon_url": "string"
      }
    ]
  }
}
```
