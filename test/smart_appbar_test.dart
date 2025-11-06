import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
// import 'package:google_fonts/google_fonts.dart'; // Not used in tests

import 'package:smart_appbar/smart_appbar.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  // GoogleFonts.config.disableInstanceLoading = true; // Removed - causes compilation issues

  group('SmartAppBar Tests', () {
    testWidgets('SmartAppBar should render with route-based title',
        (WidgetTester tester) async {
      // Build a test app with routes
      await tester.pumpWidget(
        MaterialApp(
          routes: {
            '/': (context) => const HomeScreen(),
            '/petProfile': (context) => const PetProfileScreen(),
            '/settings': (context) => const SettingsScreen(),
          },
          home: const HomeScreen(),
        ),
      );

      // Find the app bar and verify it renders
      expect(find.byType(SmartAppBar), findsOneWidget);
    });

    testWidgets('SmartAppBar should handle custom title override',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            appBar: SmartAppBar(
              title: 'Custom Title',
              variant: SmartAppBarVariant.standard,
            ),
            body: Text('Test Body'),
          ),
        ),
      );

      expect(find.text('Custom Title'), findsOneWidget);
      expect(find.byType(SmartAppBar), findsOneWidget);
    });

    testWidgets('SmartAppBar should handle loading state',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            appBar: SmartAppBar(
              title: 'Loading Test',
              isLoading: true,
            ),
            body: Text('Test Body'),
          ),
        ),
      );

      // Should show loading indicator
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(find.text('Loading Test'), findsOneWidget);
    });

    testWidgets('SmartAppBar should handle custom actions',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            appBar: SmartAppBar(
              title: 'Actions Test',
              actions: [
                SmartAppBarAction.notifications,
                SmartAppBarAction.search
              ],
            ),
            body: Text('Test Body'),
          ),
        ),
      );

      // Should show custom actions
      expect(find.byIcon(Icons.notifications_outlined), findsOneWidget);
      expect(find.byIcon(Icons.search), findsOneWidget);
    });

    testWidgets('SmartAppBar should support different variants',
        (WidgetTester tester) async {
      const variants = SmartAppBarVariant.values;

      for (final variant in variants) {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              appBar: SmartAppBar(
                title: 'Variant Test: $variant',
                variant: variant,
                enableAnimations:
                    false, // Disable animations for faster testing
              ),
              body: Text('Testing variant: $variant'),
            ),
          ),
        );

        expect(find.byType(SmartAppBar), findsOneWidget);
        expect(find.text('Variant Test: $variant'), findsOneWidget);
      }
    });

    testWidgets('SmartAppBar should have proper accessibility labels',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            appBar: SmartAppBar(
              title: 'Accessibility Test',
              actions: [SmartAppBarAction.settings],
            ),
            body: Text('Test Body'),
          ),
        ),
      );

      // Check that semantic labels are present
      expect(
          find.bySemanticsLabel('App Bar: Accessibility Test'), findsOneWidget);
      expect(find.bySemanticsLabel('Settings'), findsOneWidget);
    });

    testWidgets('SmartAppBar should handle edge cases gracefully',
        (WidgetTester tester) async {
      // Test with null route
      await tester.pumpWidget(
        const MaterialApp(
          home: NullRouteTestScreen(),
        ),
      );

      expect(find.byType(SmartAppBar), findsOneWidget);
      expect(find.text('SmartApp'), findsOneWidget); // Default title
    });
  });
}

// Test screen widgets
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: SmartAppBar(), // Will auto-detect transparent variant
      body: Text('Home Screen'),
    );
  }
}

class PetProfileScreen extends StatelessWidget {
  const PetProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: SmartAppBar(), // Will auto-detect glass variant
      body: Text('Pet Profile Screen'),
    );
  }
}

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: SmartAppBar(), // Will auto-detect bordered variant
      body: Text('Settings Screen'),
    );
  }
}

class TestScreen extends StatelessWidget {
  const TestScreen({super.key, required this.routeName});
  final String routeName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SmartAppBar(
          // No title provided - will use route configuration
          ),
      body: Text('Test Screen: $routeName'),
    );
  }
}

class FirstScreen extends StatelessWidget {
  const FirstScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SmartAppBar(title: 'First Screen'),
      body: Center(
        child: ElevatedButton(
          onPressed: () => Navigator.of(context).pushNamed('/second'),
          child: const Text('Go to second screen'),
        ),
      ),
    );
  }
}

class SecondScreen extends StatelessWidget {
  const SecondScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: SmartAppBar(title: 'Second Screen'),
      body: Center(
        child: Text('Second Screen'),
      ),
    );
  }
}

class ThemeTestScreen extends StatelessWidget {
  const ThemeTestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: SmartAppBar(title: 'Theme Test'),
      body: Text('Theme Test Screen'),
    );
  }
}

class NullRouteTestScreen extends StatelessWidget {
  const NullRouteTestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: SmartAppBar(), // No route, should use default
      body: Text('Null Route Test'),
    );
  }
}
