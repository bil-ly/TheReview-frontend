# MVVM Architecture Documentation

This Flutter application follows the **MVVM (Model-View-ViewModel)** architectural pattern for clean separation of concerns and maintainability.

## Architecture Overview

```
┌─────────────────────────────────────────────────────────┐
│                         View                             │
│  (UI Layer - Screens & Widgets)                         │
│  - Observes ViewModel state changes                     │
│  - Displays data and handles user input                 │
└──────────────────┬──────────────────────────────────────┘
                   │ uses
                   ▼
┌─────────────────────────────────────────────────────────┐
│                     ViewModel                            │
│  (Presentation Logic & State Management)                │
│  - Extends ChangeNotifier (Provider)                    │
│  - Manages UI state                                     │
│  - Coordinates data flow                                │
└──────────────────┬──────────────────────────────────────┘
                   │ uses
                   ▼
┌─────────────────────────────────────────────────────────┐
│                      Services                            │
│  (Business Logic & API Layer)                           │
│  - API calls                                            │
│  - Data transformation                                  │
└──────────────────┬──────────────────────────────────────┘
                   │ returns
                   ▼
┌─────────────────────────────────────────────────────────┐
│                       Model                              │
│  (Data Layer)                                           │
│  - Data classes/entities                                │
│  - JSON serialization                                   │
└─────────────────────────────────────────────────────────┘
```

## Directory Structure

```
lib/
├── main.dart                    # App entry point with Provider setup
├── models/                      # Data models (M in MVVM)
│   ├── user.dart
│   ├── review.dart
│   ├── topic.dart
│   └── saved_item.dart
├── viewmodels/                  # ViewModels (VM in MVVM)
│   ├── auth_viewmodel.dart
│   ├── dashboard_viewmodel.dart
│   ├── topic_viewmodel.dart
│   └── profile_viewmodel.dart
├── views/                       # UI Layer (V in MVVM)
│   ├── screens/
│   │   ├── welcome_screen.dart
│   │   ├── login_screen.dart
│   │   ├── register_screen.dart
│   │   ├── dashboard_screen.dart
│   │   ├── topic_screen.dart
│   │   ├── profile_screen.dart
│   │   └── settings_screen.dart
│   └── widgets/                 # Reusable UI components
├── services/                    # API & Business Logic
│   ├── api_service.dart         # Base HTTP client
│   ├── auth_service.dart        # Authentication logic
│   ├── review_service.dart      # Review-related API calls
│   └── user_service.dart        # User-related API calls
├── core/                        # Core utilities
│   ├── theme.dart               # App theming
│   ├── constants.dart           # App constants
│   └── router.dart              # Navigation routing
└── utils/                       # Helper utilities
```

## Layer Responsibilities

### 1. Models (Data Layer)
**Location:** `lib/models/`

**Purpose:** Plain Dart classes representing app data structures

**Responsibilities:**
- Define data structures
- JSON serialization/deserialization
- Data validation
- Type safety

**Example:**
```dart
@JsonSerializable()
class User {
  final String id;
  final String fullName;
  final String email;

  User({required this.id, required this.fullName, required this.email});

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
```

### 2. ViewModels (Presentation Logic)
**Location:** `lib/viewmodels/`

**Purpose:** Bridge between Views and Services, manages UI state

**Responsibilities:**
- Manage UI state
- Handle user interactions
- Call service methods
- Transform data for UI consumption
- Notify views of state changes via ChangeNotifier

**Key Features:**
- Extends `ChangeNotifier` for reactive state management
- Uses `notifyListeners()` to update UI
- Accessed via `Provider` in views

**Example:**
```dart
class AuthViewModel extends ChangeNotifier {
  final AuthService _authService;

  AuthState _state = AuthState.initial;
  User? _currentUser;

  AuthState get state => _state;
  User? get currentUser => _currentUser;

  Future<bool> login(String email, String password) async {
    _state = AuthState.loading;
    notifyListeners();

    try {
      _currentUser = await _authService.login(email, password);
      _state = AuthState.authenticated;
      notifyListeners();
      return true;
    } catch (e) {
      _state = AuthState.error;
      notifyListeners();
      return false;
    }
  }
}
```

### 3. Views (UI Layer)
**Location:** `lib/views/`

**Purpose:** Display UI and handle user interactions

**Responsibilities:**
- Render UI based on ViewModel state
- Handle user input
- Navigate between screens
- Display loading/error states

**Key Features:**
- Uses `Consumer` or `Provider.of()` to access ViewModels
- Stateless when possible, Stateful when needed
- Responsive to ViewModel state changes

**Example:**
```dart
class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthViewModel>(
      builder: (context, authViewModel, child) {
        return Scaffold(
          body: authViewModel.state == AuthState.loading
            ? CircularProgressIndicator()
            : LoginForm(),
        );
      },
    );
  }
}
```

### 4. Services (Business Logic)
**Location:** `lib/services/`

**Purpose:** Handle API communication and business logic

**Responsibilities:**
- Make HTTP requests
- Handle API responses
- Transform raw data to Models
- Error handling
- Data persistence (local storage)

**Example:**
```dart
class AuthService {
  final ApiService _apiService;

  AuthService(this._apiService);

  Future<User> login(String email, String password) async {
    final response = await _apiService.post('/auth/login', {
      'email': email,
      'password': password,
    });

    return User.fromJson(response['user']);
  }
}
```

## State Management: Provider

This app uses **Provider** for state management, which is the recommended approach for MVVM in Flutter.

### Why Provider?

1. **Simple & Lightweight**: Easy to understand and implement
2. **Official**: Recommended by Flutter team
3. **Reactive**: Automatic UI updates when state changes
4. **Scoped**: Different scopes for different parts of the app
5. **Testable**: Easy to mock and test

### Provider Setup

In `main.dart`:
```dart
MultiProvider(
  providers: [
    ChangeNotifierProvider<AuthViewModel>(
      create: (_) => AuthViewModel(authService),
    ),
    // ... other ViewModels
  ],
  child: MyApp(),
)
```

### Accessing ViewModels in Views

**Read (one-time access):**
```dart
final authViewModel = context.read<AuthViewModel>();
authViewModel.login(email, password);
```

**Watch (reactive, rebuilds on change):**
```dart
final state = context.watch<AuthViewModel>().state;
```

**Consumer (reactive, partial rebuild):**
```dart
Consumer<AuthViewModel>(
  builder: (context, authViewModel, child) {
    return Text(authViewModel.currentUser?.name ?? 'Guest');
  },
)
```

## Data Flow

### Example: User Login Flow

1. **User Action** → User taps "Login" button in `LoginScreen` (View)
2. **View → ViewModel** → View calls `authViewModel.login(email, password)`
3. **ViewModel → Service** → ViewModel calls `authService.login(email, password)`
4. **Service → API** → Service makes HTTP POST to `/auth/login`
5. **API → Service** → Service receives JSON response
6. **Service → Model** → Service converts JSON to `User` model
7. **Model → ViewModel** → Service returns `User` to ViewModel
8. **ViewModel → View** → ViewModel calls `notifyListeners()`, View rebuilds
9. **View Update** → UI shows logged-in state

## Benefits of MVVM

1. **Separation of Concerns**: Each layer has a single responsibility
2. **Testability**: Easy to unit test ViewModels and Services
3. **Maintainability**: Changes in one layer don't affect others
4. **Reusability**: ViewModels can be reused across multiple views
5. **Scalability**: Easy to add new features without affecting existing code
6. **Team Collaboration**: Different team members can work on different layers

## Best Practices

1. **ViewModels should not import Flutter widgets**
   - Keep ViewModels UI-agnostic
   - Only import `dart:core` and business logic

2. **Views should be dumb**
   - Views should only display data
   - All logic should be in ViewModels

3. **One ViewModel per screen**
   - Each screen should have its own ViewModel
   - Share data via services, not ViewModels

4. **Use dependency injection**
   - Inject services into ViewModels
   - Makes testing easier

5. **Handle errors in ViewModels**
   - Don't let exceptions bubble up to Views
   - Provide error states to UI

6. **Keep Models immutable**
   - Use `final` fields
   - Use `copyWith()` for updates

## Testing Strategy

### Unit Tests
- **Models**: Test JSON serialization/deserialization
- **Services**: Test API calls (use mocks)
- **ViewModels**: Test state transitions and business logic

### Widget Tests
- **Views**: Test UI rendering based on ViewModel states

### Integration Tests
- **Full flow**: Test complete user journeys

## Next Steps

1. Implement remaining screens (Dashboard, Topic, Profile, Settings)
2. Add comprehensive error handling
3. Implement offline support with local caching
4. Add unit tests for ViewModels and Services
5. Add widget tests for Views
6. Implement analytics and logging
7. Add push notifications
8. Implement dark mode toggle

## Resources

- [Provider Documentation](https://pub.dev/packages/provider)
- [Flutter MVVM Best Practices](https://flutter.dev/docs/development/data-and-backend/state-mgmt)
- [Clean Architecture in Flutter](https://resocoder.com/flutter-clean-architecture-tdd/)
