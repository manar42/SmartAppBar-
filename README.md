https://raw.githubusercontent.com/manar42/SmartAppBar-/c80923d95fb4b44d4e4ec795350bfff5834ad7df/assets/videos/Video.mp4

 
# SmartAppBar - Intelligent Flutter AppBar Widget

A powerful, dynamic, and intelligent SmartAppBar widget for Flutter applications that automatically adapts to routes, supports multiple visual variants, and provides rich accessibility features.

## 🌟 Features

### ✅ Core Functionality
- **Automatic Route Detection**: Automatically detects current route and applies appropriate configuration
- **Multiple Visual Variants**: Standard, Glass, Transparent, Bordered, Elevated, Large
- **Dynamic Data Integration**: Ready for Cubit/Provider integration
- **Theme-Aware**: Automatic light/dark theme adaptation
- **Smooth Animations**: Fade, slide, and scale transitions
- **Full Accessibility**: Screen reader support with semantic labels

### 🎨 Visual Variants
- **Standard**: Classic Material 3 design
- **Glass**: Glass morphism effect with blur and transparency
- **Transparent**: Fully transparent for overlay scenarios
- **Bordered**: Subtle border appearance
- **Elevated**: Prominent shadow and elevation
- **Large**: Big title app bar for hero sections

### 🎯 Smart Features
- **Route-Based Configuration**: Automatically changes title, colors, and actions based on route
- **Smart Actions**: Context-aware action buttons for different screens
- **Loading States**: Built-in loading indicator support
- **Performance Optimized**: Caching and efficient rendering
- **Customizable**: Full parameter override capability

## 📦 Installation

Add `smart_appbar` to your `pubspec.yaml` file:

```yaml
dependencies:
  smart_appbar: ^1.0.0
```

Then run:

```bash
flutter pub get
```

## 🚀 Quick Start

### Basic Usage
```dart
import 'package:smart_appbar/smart_appbar.dart';

// Simple usage - everything is automatic
Scaffold(
  appBar: const SmartAppBar(), // Automatically detects route and config
  body: YourContent(),
);
```

### Route Configuration Examples

The SmartAppBar automatically detects routes and applies appropriate configurations:

```dart
// Route-based automatic configuration
MaterialApp(
  routes: {
    '/home': (context) => const HomeScreen(),           // Transparent variant
    '/petProfile': (context) => const PetProfileScreen(), // Glass variant
    '/settings': (context) => const SettingsScreen(),   // Bordered variant
    '/profile': (context) => const ProfileScreen(),     // Standard variant
    '/dashboard': (context) => const DashboardScreen(), // Glass variant
  },
  home: const HomeScreen(),
);
```

## 🎨 Usage Examples

### 1. Home Screen (Transparent Variant)
```dart
class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SmartAppBar(), 
      // Automatically: 
      // - Title: "Home 🏠"
      // - Variant: Transparent
      // - Actions: Notifications + Profile icons
      body: YourContent(),
    );
  }
}
```

### 2. Pet Profile (Glass Variant)
```dart
class PetProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SmartAppBar(),
      // Automatically:
      // - Title: "Pet Profile 🐾"
      // - Variant: Glass with blur effect
      // - Actions: Edit + Share icons
      body: YourPetContent(),
    );
  }
}
```

### 3. Settings Screen (Bordered Variant)
```dart
class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SmartAppBar(),
      // Automatically:
      // - Title: "Settings ⚙️"
      // - Variant: Bordered
      // - Actions: Search + More icons
      body: YourSettingsContent(),
    );
  }
}
```

### 4. Custom Configuration
```dart
Scaffold(
  appBar: SmartAppBar(
    title: 'Custom Title',
    variant: SmartAppBarVariant.glass,
    centerTitle: true,
    actions: [SmartAppBarAction.settings, SmartAppBarAction.search],
    backgroundColor: Colors.blue,
    enableAnimations: true,
    isLoading: true, // Shows loading indicator
  ),
  body: YourContent(),
);
```

## ⚙️ Configuration

### Route Configuration
The SmartAppBar uses a built-in configuration system:

```dart
const Map<String, _RouteConfig> _routeConfigs = {
  '/home': _RouteConfig(
    title: 'Home 🏠',
    variant: SmartAppBarVariant.transparent,
    actions: [SmartAppBarAction.notifications, SmartAppBarAction.profile],
  ),
  '/petProfile': _RouteConfig(
    title: 'Pet Profile 🐾',
    variant: SmartAppBarVariant.glass,
    actions: [SmartAppBarAction.edit, SmartAppBarAction.share],
    centerTitle: true,
  ),
  // ... more routes
};
```

### Available Actions
```dart
enum SmartAppBarAction {
  notifications(Icons.notifications_outlined),
  profile(Icons.person_outline),
  edit(Icons.edit_outlined),
  share(Icons.share_outlined),
  settings(Icons.settings_outlined),
  search(Icons.search),
  more(Icons.more_vert),
  add(Icons.add),
  favorite(Icons.favorite_border),
  bookmark(Icons.bookmark_outline);
}
```

### Available Variants
```dart
enum SmartAppBarVariant {
  standard,    // Classic Material 3 design
  glass,       // Glass morphism with blur and transparency
  transparent, // Fully transparent for overlay scenarios
  bordered,    // Subtle border appearance
  elevated,    // Prominent shadow and elevation
  large,       // Big title app bar for hero sections
}
```

## 🔧 Advanced Usage

### Custom Theming
```dart
SmartAppBar(
  title: 'Custom Themed',
  backgroundColor: Colors.purple,
  foregroundColor: Colors.white,
  variant: SmartAppBarVariant.elevated,
  elevation: 4.0,
  enableGradient: true,
  blurIntensity: 0.3,
)
```

### Integration with State Management
```dart
// Example with Provider or Cubit
class UserProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SmartAppBar(
        // Widget can be extended to work with state management
        title: 'Profile: ${user?.name}', // Dynamic from state
        isLoading: userCubit.state is UserLoading,
      ),
      body: YourContent(),
    );
  }
}
```

## 📱 Complete Demo App

The widget includes a comprehensive example app that showcases:

- **All Route Variants**: Home, PetProfile, Settings, Profile, Dashboard screens
- **Visual Effects**: Different variants in action
- **Interactive Elements**: Tap actions and navigation
- **Theme Adaptation**: Light/dark mode support

## 🧪 Testing

Run the test suite:
```bash
flutter test test/
```

Test coverage includes:
- Route-based configuration
- Custom title override
- Loading state handling
- Action button functionality
- Variant rendering
- Accessibility features
- Edge cases

## ♿ Accessibility

- **Screen Reader Support**: Semantic labels for all interactive elements
- **Keyboard Navigation**: Full keyboard support
- **High Contrast**: Automatic contrast adjustment
- **Touch Targets**: 44x44 minimum touch targets
- **Haptic Feedback**: Tactile feedback for actions

## 🎭 Animations

Built-in animations include:
- **Fade In**: Smooth opacity transition
- **Slide Up**: Vertical slide animation
- **Scale**: Elastic scale effect
- **Duration**: Customizable animation timing

```dart
SmartAppBar(
  enableAnimations: true,
  animationDuration: const Duration(milliseconds: 300),
)
```

## 🌙 Dark Mode

Automatic theme adaptation:
- Text colors adjust for readability
- Background colors adapt to theme
- Glass effects work in both modes
- Contrast automatically optimized

## 🚀 Performance

- **Caching**: Expensive calculations cached
- **Efficient Rendering**: Minimal rebuilds
- **Hardware Accelerated**: Uses Flutter's GPU rendering
- **Memory Optimized**: Proper disposal of animations

## 📚 API Reference

### SmartAppBar Class

#### Constructor Parameters
- `title` (String?): Custom title override
- `variant` (SmartAppBarVariant?): Visual variant override
- `actions` (List<SmartAppBarAction>?): Custom action buttons
- `centerTitle` (bool): Center title alignment
- `backgroundColor` (Color?): Custom background color
- `foregroundColor` (Color?): Custom text/icon color
- `enableAnimations` (bool): Enable animations
- `isLoading` (bool): Show loading indicator
- `showBackButton` (bool): Show navigation back button
- `onBackPressed` (VoidCallback?): Custom back button handler

### SmartAppBarVariant
- `standard`: Standard Material 3 design
- `glass`: Glass morphism effect
- `transparent`: Fully transparent
- `bordered`: Bordered appearance
- `elevated`: Elevated with shadow
- `large`: Large title bar

### SmartAppBarAction
- `notifications`: Notification icon
- `profile`: User profile icon
- `edit`: Edit/pencil icon
- `share`: Share icon
- `settings`: Settings gear icon
- `search`: Search magnifying glass
- `more`: More options (3 dots)
- `add`: Plus/add icon
- `favorite`: Heart/favorite icon
- `bookmark`: Bookmark icon

## 🤝 Contributing

1. Fork the repository
2. Create feature branch (`git checkout -b feature/amazing-feature`)
3. Commit changes (`git commit -m 'Add amazing feature'`)
4. Push to branch (`git push origin feature/amazing-feature`)
5. Open Pull Request

## 📄 License

This project is licensed under the MIT License.

## 🎯 Example Project Structure

```
lib/
├── smart_appbar.dart          # Main library file
├── src/
│   └── smart_appbar_core.dart # Core implementation
example/
├── main.dart                  # Example app
test/
├── smart_appbar_test.dart     # Comprehensive tests
```

## 🔮 Future Enhancements

- [ ] Built-in search functionality
- [ ] More animation presets
- [ ] Additional glass effects
- [ ] Context menu support
- [ ] Gesture-based interactions
- [ ] Voice command support
- [ ] AI-powered auto-configuration

---
## 📞 Support

If you find this package helpful, please ⭐ star the repository!

For issues and questions:
- [GitHub Issues](https://github.com/manar42/custom_snackbar_plus/issues)
- [Pub.dev Package](https://pub.dev/packages/custom_snackbar_plus) 


**Made with ❤️ for the Flutter community**
