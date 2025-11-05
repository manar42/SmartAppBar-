import 'package:flutter/material.dart';
import 'package:smart_appbar/smart_appbar.dart';

void main() {
  runApp(const SmartAppBarShowcase());
}

class SmartAppBarShowcase extends StatefulWidget {
  const SmartAppBarShowcase({super.key});

  @override
  State<SmartAppBarShowcase> createState() => _SmartAppBarShowcaseState();
}

class _SmartAppBarShowcaseState extends State<SmartAppBarShowcase> {
  final ThemeMode _themeMode = ThemeMode.system;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SmartAppBar Feature Showcase',
      debugShowCheckedModeBanner: false,
      themeMode: _themeMode,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
      routes: _buildRoutes(),
    );
  }

  Map<String, WidgetBuilder> _buildRoutes() {
    return {
      '/home': (context) => const HomeScreen(),
      '/variants': (context) => const VariantsScreen(),
      '/actions': (context) => const ActionsScreen(),
      '/custom': (context) => const CustomScreen(),
      '/animation': (context) => const AnimationScreen(),
      '/loading': (context) => const LoadingScreen(),
      '/advanced': (context) => const AdvancedScreen(),
      '/glass': (context) => const GlassEffectScreen(),
      '/transparent': (context) => const TransparentScreen(),
      '/bordered': (context) => const BorderedScreen(),
      '/elevated': (context) => const ElevatedScreen(),
      '/large': (context) => const LargeAppBarScreen(),
    };
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SmartAppBar(
        title: 'SmartAppBar Showcase 🎨',
        variant: SmartAppBarVariant.glass,
        actions: [SmartAppBarAction.settings, SmartAppBarAction.favorite],
        enableGradient: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Theme.of(context).colorScheme.primary.withValues(alpha: 0.1),
              Theme.of(context).colorScheme.secondary.withValues(alpha: 0.1),
              Theme.of(context).colorScheme.surface,
            ],
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeaderCard(context),
              const SizedBox(height: 20),
              _buildFeaturesGrid(context),
              const SizedBox(height: 20),
              _buildQuickActions(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderCard(BuildContext context) {
    return Card(
      elevation: 8,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.extension,
                  size: 32,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'SmartAppBar Feature Showcase',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              'Explore all the powerful features of the SmartAppBar widget including 6 visual variants, 10+ action types, animations, loading states, and advanced customization options.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeaturesGrid(BuildContext context) {
    final features = [
      _FeatureItem(
        icon: Icons.palette,
        title: 'Visual Variants',
        subtitle: '6 different styles',
        color: Colors.purple,
        route: '/variants',
      ),
      _FeatureItem(
        icon: Icons.touch_app,
        title: 'Smart Actions',
        subtitle: '10+ action types',
        color: Colors.blue,
        route: '/actions',
      ),
      _FeatureItem(
        icon: Icons.color_lens,
        title: 'Custom Styling',
        subtitle: 'Colors & themes',
        color: Colors.green,
        route: '/custom',
      ),
      _FeatureItem(
        icon: Icons.animation,
        title: 'Animations',
        subtitle: 'Smooth transitions',
        color: Colors.orange,
        route: '/animation',
      ),
      _FeatureItem(
        icon: Icons.hourglass_empty,
        title: 'Loading States',
        subtitle: 'Progress indicators',
        color: Colors.red,
        route: '/loading',
      ),
      _FeatureItem(
        icon: Icons.tune,
        title: 'Advanced Options',
        subtitle: 'Fine-tuned controls',
        color: Colors.teal,
        route: '/advanced',
      ),
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 1.2,
      ),
      itemCount: features.length,
      itemBuilder: (context, index) {
        return _FeatureCard(feature: features[index]);
      },
    );
  }

  Widget _buildQuickActions(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Quick Actions',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () =>
                        Navigator.of(context).pushNamed('/variants'),
                    icon: const Icon(Icons.explore),
                    label: const Text('Explore All Variants'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () => Navigator.of(context).pushNamed('/custom'),
                    icon: const Icon(Icons.edit),
                    label: const Text('Try Custom Styles'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _FeatureItem {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;
  final String route;

  const _FeatureItem({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
    required this.route,
  });
}

class _FeatureCard extends StatelessWidget {
  final _FeatureItem feature;

  const _FeatureCard({required this.feature});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: InkWell(
        onTap: () => Navigator.of(context).pushNamed(feature.route),
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                feature.icon,
                size: 32,
                color: feature.color,
              ),
              const SizedBox(height: 8),
              Text(
                feature.title,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 4),
              Text(
                feature.subtitle,
                style: Theme.of(context).textTheme.bodySmall,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class VariantsScreen extends StatelessWidget {
  const VariantsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final variants = [
      _VariantDemo(
        name: 'Standard',
        variant: SmartAppBarVariant.standard,
        description: 'Classic Material 3 design with clean appearance',
      ),
      _VariantDemo(
        name: 'Glass Effect',
        variant: SmartAppBarVariant.glass,
        description: 'Beautiful glass morphism with blur and transparency',
      ),
      _VariantDemo(
        name: 'Transparent',
        variant: SmartAppBarVariant.transparent,
        description: 'Fully transparent for overlay scenarios',
      ),
      _VariantDemo(
        name: 'Bordered',
        variant: SmartAppBarVariant.bordered,
        description: 'Subtle border appearance for modern look',
      ),
      _VariantDemo(
        name: 'Elevated',
        variant: SmartAppBarVariant.elevated,
        description: 'Prominent shadow and depth effect',
      ),
      _VariantDemo(
        name: 'Large',
        variant: SmartAppBarVariant.large,
        description: 'Big title app bar for hero sections',
      ),
    ];

    return Scaffold(
      appBar: const SmartAppBar(
        title: 'Visual Variants 🎨',
        actions: [SmartAppBarAction.search, SmartAppBarAction.favorite],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: variants.length,
        itemBuilder: (context, index) {
          return _VariantCard(demo: variants[index]);
        },
      ),
    );
  }
}

class _VariantDemo {
  final String name;
  final SmartAppBarVariant variant;
  final String description;

  const _VariantDemo({
    required this.name,
    required this.variant,
    required this.description,
  });
}

class _VariantCard extends StatelessWidget {
  final _VariantDemo demo;

  const _VariantCard({required this.demo});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Column(
        children: [
          _VariantPreview(variant: demo.variant),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  demo.name,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 8),
                Text(
                  demo.description,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: () => _navigateToDemo(context),
                  child: const Text('View Live Demo'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _navigateToDemo(BuildContext context) {
    switch (demo.variant) {
      case SmartAppBarVariant.glass:
        Navigator.of(context).pushNamed('/glass');
        break;
      case SmartAppBarVariant.transparent:
        Navigator.of(context).pushNamed('/transparent');
        break;
      case SmartAppBarVariant.bordered:
        Navigator.of(context).pushNamed('/bordered');
        break;
      case SmartAppBarVariant.elevated:
        Navigator.of(context).pushNamed('/elevated');
        break;
      case SmartAppBarVariant.large:
        Navigator.of(context).pushNamed('/large');
        break;
      default:
        Navigator.of(context).pushNamed('/custom');
    }
  }
}

class _VariantPreview extends StatelessWidget {
  final SmartAppBarVariant variant;

  const _VariantPreview({required this.variant});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.blue.withValues(alpha: 0.1),
            Colors.purple.withValues(alpha: 0.1),
          ],
        ),
      ),
      child: SmartAppBar(
        title: '${variant.name} Preview',
        variant: variant,
        actions: [SmartAppBarAction.search, SmartAppBarAction.favorite],
        backgroundColor: _getPreviewColor(variant),
      ),
    );
  }

  Color? _getPreviewColor(SmartAppBarVariant variant) {
    switch (variant) {
      case SmartAppBarVariant.standard:
        return null;
      case SmartAppBarVariant.glass:
        return Colors.white.withValues(alpha: 0.9);
      case SmartAppBarVariant.transparent:
        return null;
      case SmartAppBarVariant.bordered:
        return null;
      case SmartAppBarVariant.elevated:
        return null;
      case SmartAppBarVariant.large:
        return null;
    }
  }
}

class ActionsScreen extends StatelessWidget {
  const ActionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final actions = SmartAppBarAction.values;

    return Scaffold(
      appBar: const SmartAppBar(
        title: 'Smart Actions ⚡',
        actions: [SmartAppBarAction.notifications, SmartAppBarAction.profile],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: actions.length,
        itemBuilder: (context, index) {
          return _ActionCard(action: actions[index]);
        },
      ),
    );
  }
}

class _ActionCard extends StatelessWidget {
  final SmartAppBarAction action;

  const _ActionCard({required this.action});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor:
              Theme.of(context).colorScheme.primary.withValues(alpha: 0.1),
          child: Icon(
            action.icon,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        title: Text(_getActionName(action)),
        subtitle: Text(_getActionDescription(action)),
        trailing: Icon(
          Icons.arrow_forward_ios,
          size: 16,
          color: Theme.of(context).colorScheme.outline,
        ),
        onTap: () => _showActionDemo(context),
      ),
    );
  }

  String _getActionName(SmartAppBarAction action) {
    switch (action) {
      case SmartAppBarAction.notifications:
        return 'Notifications';
      case SmartAppBarAction.profile:
        return 'Profile';
      case SmartAppBarAction.edit:
        return 'Edit';
      case SmartAppBarAction.share:
        return 'Share';
      case SmartAppBarAction.settings:
        return 'Settings';
      case SmartAppBarAction.search:
        return 'Search';
      case SmartAppBarAction.more:
        return 'More Options';
      case SmartAppBarAction.add:
        return 'Add';
      case SmartAppBarAction.favorite:
        return 'Favorite';
      case SmartAppBarAction.bookmark:
        return 'Bookmark';
    }
  }

  String _getActionDescription(SmartAppBarAction action) {
    switch (action) {
      case SmartAppBarAction.notifications:
        return 'Show notification bell icon';
      case SmartAppBarAction.profile:
        return 'Display user profile icon';
      case SmartAppBarAction.edit:
        return 'Edit current item icon';
      case SmartAppBarAction.share:
        return 'Share content icon';
      case SmartAppBarAction.settings:
        return 'Settings gear icon';
      case SmartAppBarAction.search:
        return 'Search magnifying glass';
      case SmartAppBarAction.more:
        return 'More options (3 dots)';
      case SmartAppBarAction.add:
        return 'Add new item icon';
      case SmartAppBarAction.favorite:
        return 'Favorite/heart icon';
      case SmartAppBarAction.bookmark:
        return 'Bookmark/save icon';
    }
  }

  void _showActionDemo(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${_getActionName(action)} action demo'),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}

class CustomScreen extends StatefulWidget {
  const CustomScreen({super.key});

  @override
  State<CustomScreen> createState() => _CustomScreenState();
}

class _CustomScreenState extends State<CustomScreen> {
  Color _backgroundColor = Colors.blue;
  Color _foregroundColor = Colors.white;
  bool _centerTitle = false;
  bool _enableGradient = false;
  bool _showBackButton = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SmartAppBar(
        title: 'Custom Styling 🎨',
        variant: SmartAppBarVariant.elevated,
        backgroundColor: _backgroundColor,
        foregroundColor: _foregroundColor,
        centerTitle: _centerTitle,
        enableGradient: _enableGradient,
        showBackButton: _showBackButton,
        actions: [SmartAppBarAction.edit, SmartAppBarAction.share],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Customization Controls',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 16),
                    _buildColorPicker('Background Color', _backgroundColor,
                        (color) {
                      setState(() => _backgroundColor = color);
                    }),
                    const SizedBox(height: 16),
                    _buildColorPicker('Text Color', _foregroundColor, (color) {
                      setState(() => _foregroundColor = color);
                    }),
                    const SizedBox(height: 16),
                    SwitchListTile(
                      title: const Text('Center Title'),
                      value: _centerTitle,
                      onChanged: (value) =>
                          setState(() => _centerTitle = value),
                    ),
                    SwitchListTile(
                      title: const Text('Enable Gradient'),
                      value: _enableGradient,
                      onChanged: (value) =>
                          setState(() => _enableGradient = value),
                    ),
                    SwitchListTile(
                      title: const Text('Show Back Button'),
                      value: _showBackButton,
                      onChanged: (value) =>
                          setState(() => _showBackButton = value),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Current Configuration',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 8),
                    Text('Background: ${_backgroundColor.toString()}'),
                    Text('Foreground: ${_foregroundColor.toString()}'),
                    Text('Center Title: $_centerTitle'),
                    Text('Gradient: $_enableGradient'),
                    Text('Back Button: $_showBackButton'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildColorPicker(
      String label, Color color, ValueChanged<Color> onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          children: [
            _ColorOption(Colors.red, onChanged),
            _ColorOption(Colors.green, onChanged),
            _ColorOption(Colors.blue, onChanged),
            _ColorOption(Colors.purple, onChanged),
            _ColorOption(Colors.orange, onChanged),
            _ColorOption(Colors.teal, onChanged),
            _ColorOption(Colors.pink, onChanged),
            _ColorOption(Colors.indigo, onChanged),
          ],
        ),
      ],
    );
  }
}

class _ColorOption extends StatelessWidget {
  final Color color;
  final ValueChanged<Color> onChanged;

  const _ColorOption(this.color, this.onChanged);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onChanged(color),
      borderRadius: BorderRadius.circular(20),
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: color,
          border: Border.all(
            color: Theme.of(context).colorScheme.outline,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
}

class AnimationScreen extends StatelessWidget {
  const AnimationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SmartAppBar(
        title: 'Animations 🎬',
        variant: SmartAppBarVariant.glass,
        enableAnimations: true,
        actions: [SmartAppBarAction.add, SmartAppBarAction.favorite],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _AnimationCard(
            title: 'Fade Animation',
            description: 'Smooth opacity transitions',
            child: _FadeAnimationDemo(),
          ),
          const SizedBox(height: 16),
          _AnimationCard(
            title: 'Slide Animation',
            description: 'Vertical slide effects',
            child: _SlideAnimationDemo(),
          ),
          const SizedBox(height: 16),
          _AnimationCard(
            title: 'Scale Animation',
            description: 'Elastic scale effects',
            child: _ScaleAnimationDemo(),
          ),
        ],
      ),
    );
  }
}

class _AnimationCard extends StatelessWidget {
  final String title;
  final String description;
  final Widget child;

  const _AnimationCard({
    required this.title,
    required this.description,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 4),
            Text(description, style: Theme.of(context).textTheme.bodyMedium),
            const SizedBox(height: 16),
            child,
          ],
        ),
      ),
    );
  }
}

class _FadeAnimationDemo extends StatefulWidget {
  @override
  State<_FadeAnimationDemo> createState() => _FadeAnimationDemoState();
}

class _FadeAnimationDemoState extends State<_FadeAnimationDemo> {
  bool _visible = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AnimatedOpacity(
          opacity: _visible ? 1.0 : 0.3,
          duration: const Duration(seconds: 1),
          child: Container(
            height: 100,
            color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.1),
            child: const Center(child: Text('Fade Effect')),
          ),
        ),
        const SizedBox(height: 8),
        ElevatedButton(
          onPressed: () => setState(() => _visible = !_visible),
          child: Text(_visible ? 'Hide' : 'Show'),
        ),
      ],
    );
  }
}

class _SlideAnimationDemo extends StatefulWidget {
  @override
  State<_SlideAnimationDemo> createState() => _SlideAnimationDemoState();
}

class _SlideAnimationDemoState extends State<_SlideAnimationDemo>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    _animation = Tween<Offset>(
      begin: const Offset(-1.0, 0.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.elasticOut,
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SlideTransition(
          position: _animation,
          child: Container(
            height: 100,
            color: Theme.of(context).colorScheme.secondary.withValues(alpha: 0.1),
            child: const Center(child: Text('Slide Effect')),
          ),
        ),
        const SizedBox(height: 8),
        ElevatedButton(
          onPressed: () {
            if (_controller.status == AnimationStatus.completed) {
              _controller.reverse();
            } else {
              _controller.forward();
            }
          },
          child: const Text('Animate'),
        ),
      ],
    );
  }
}

class _ScaleAnimationDemo extends StatefulWidget {
  @override
  State<_ScaleAnimationDemo> createState() => _ScaleAnimationDemoState();
}

class _ScaleAnimationDemoState extends State<_ScaleAnimationDemo>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.elasticOut,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            return Transform.scale(
              scale: _animation.value,
              child: Container(
                height: 100,
                width: 200,
                color: Theme.of(context).colorScheme.tertiary.withValues(alpha: 0.1),
                child: const Center(child: Text('Scale Effect')),
              ),
            );
          },
        ),
        const SizedBox(height: 8),
        ElevatedButton(
          onPressed: () {
            if (_controller.status == AnimationStatus.completed) {
              _controller.reset();
            } else {
              _controller.forward();
            }
          },
          child: const Text('Animate'),
        ),
      ],
    );
  }
}

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  bool _isLoading = false;
  String _customTitle = 'Loading Screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SmartAppBar(
        title: _customTitle,
        isLoading: _isLoading,
        loadingIcon: Icons.refresh,
        actions: [SmartAppBarAction.settings, SmartAppBarAction.more],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Loading State Demo',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        ElevatedButton.icon(
                          onPressed: _toggleLoading,
                          icon:
                              Icon(_isLoading ? Icons.stop : Icons.play_arrow),
                          label: Text(
                              _isLoading ? 'Stop Loading' : 'Start Loading'),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: TextField(
                            decoration: const InputDecoration(
                              labelText: 'Custom Title',
                              border: OutlineInputBorder(),
                            ),
                            onChanged: (value) =>
                                setState(() => _customTitle = value),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Loading Features',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 8),
                    const Text('• Spinner appears next to title'),
                    const Text('• Custom loading icon support'),
                    const Text('• Title text still visible'),
                    const Text('• Smooth state transitions'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _toggleLoading() {
    setState(() {
      _isLoading = !_isLoading;
    });
  }
}

class AdvancedScreen extends StatelessWidget {
  const AdvancedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SmartAppBar(
        title: 'Advanced Options ⚙️',
        variant: SmartAppBarVariant.elevated,
        elevation: 8.0,
        blurIntensity: 0.3,
        enableGradient: true,
        backgroundColor: Colors.purple,
        foregroundColor: Colors.white,
        titlePadding: const EdgeInsets.symmetric(horizontal: 16),
        automaticallyImplyLeading: false,
        actions: [
          SmartAppBarAction.search,
          SmartAppBarAction.notifications,
          SmartAppBarAction.more,
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _AdvancedFeatureCard(
            title: 'Custom Elevation',
            description: 'Control shadow depth',
            child: _ElevationDemo(),
          ),
          const SizedBox(height: 16),
          _AdvancedFeatureCard(
            title: 'Blur Intensity',
            description: 'Glass effect strength',
            child: _BlurDemo(),
          ),
          const SizedBox(height: 16),
          _AdvancedFeatureCard(
            title: 'Custom Padding',
            description: 'Title positioning',
            child: _PaddingDemo(),
          ),
          const SizedBox(height: 16),
          _AdvancedFeatureCard(
            title: 'Leading Widget',
            description: 'Custom back button',
            child: _LeadingDemo(),
          ),
        ],
      ),
    );
  }
}

class _AdvancedFeatureCard extends StatelessWidget {
  final String title;
  final String description;
  final Widget child;

  const _AdvancedFeatureCard({
    required this.title,
    required this.description,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 4),
            Text(description),
            const SizedBox(height: 16),
            child,
          ],
        ),
      ),
    );
  }
}

class _ElevationDemo extends StatefulWidget {
  @override
  State<_ElevationDemo> createState() => _ElevationDemoState();
}

class _ElevationDemoState extends State<_ElevationDemo> {
  double _elevation = 4.0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 80,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.2),
                blurRadius: _elevation,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Center(
            child: Text('Elevation: $_elevation'),
          ),
        ),
        const SizedBox(height: 8),
        Slider(
          value: _elevation,
          min: 0,
          max: 20,
          divisions: 20,
          label: _elevation.toStringAsFixed(1),
          onChanged: (value) => setState(() => _elevation = value),
        ),
      ],
    );
  }
}

class _BlurDemo extends StatefulWidget {
  @override
  State<_BlurDemo> createState() => _BlurDemoState();
}

class _BlurDemoState extends State<_BlurDemo> {
  double _blurIntensity = 0.5;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 80,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.8 - (_blurIntensity * 0.5)),
            border: Border.all(
              color: Colors.black.withValues(alpha: 0.1),
              width: 0.5,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: _blurIntensity * 0.3),
                blurRadius: _blurIntensity * 20,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Center(
            child: Text('Blur: ${(_blurIntensity * 100).toInt()}%'),
          ),
        ),
        const SizedBox(height: 8),
        Slider(
          value: _blurIntensity,
          min: 0,
          max: 1,
          divisions: 10,
          label: '${(_blurIntensity * 100).toInt()}%',
          onChanged: (value) => setState(() => _blurIntensity = value),
        ),
      ],
    );
  }
}

class _PaddingDemo extends StatefulWidget {
  @override
  State<_PaddingDemo> createState() => _PaddingDemoState();
}

class _PaddingDemoState extends State<_PaddingDemo> {
  double _padding = 16.0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 60,
          color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.1),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: _padding),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text('Custom Padding Demo'),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Slider(
          value: _padding,
          min: 0,
          max: 40,
          divisions: 8,
          label: '${_padding.toInt()}px',
          onChanged: (value) => setState(() => _padding = value),
        ),
      ],
    );
  }
}

class _LeadingDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ElevatedButton.icon(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back),
          label: const Text('Custom Leading'),
        ),
        const SizedBox(width: 16),
        const Text('Custom leading widget support'),
      ],
    );
  }
}

// Individual variant demo screens
class GlassEffectScreen extends StatelessWidget {
  const GlassEffectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SmartAppBar(
        title: 'Glass Effect Demo ✨',
        variant: SmartAppBarVariant.glass,
        blurIntensity: 0.3,
        actions: [SmartAppBarAction.edit, SmartAppBarAction.share],
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage('https://picsum.photos/800/600?blur=3'),
            fit: BoxFit.cover,
          ),
        ),
        child: const Center(
          child: Card(
            margin: EdgeInsets.all(16),
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Glass Morphism Effect'),
                  SizedBox(height: 16),
                  Text(
                      'This demonstrates the beautiful glass effect with blur and transparency.'),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class TransparentScreen extends StatelessWidget {
  const TransparentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: SmartAppBar(
        title: 'Transparent AppBar 🌟',
        variant: SmartAppBarVariant.transparent,
        foregroundColor: Colors.white,
        actions: [SmartAppBarAction.search, SmartAppBarAction.more],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF667eea),
              Color(0xFF764ba2),
            ],
          ),
        ),
        child: const Center(
          child: Text(
            'Transparent AppBar Demo',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

class BorderedScreen extends StatelessWidget {
  const BorderedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SmartAppBar(
        title: 'Bordered AppBar 📋',
        variant: SmartAppBarVariant.bordered,
        backgroundColor: Colors.grey[50],
        actions: [SmartAppBarAction.search, SmartAppBarAction.settings],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Bordered AppBar',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  const Text(
                      'This demonstrates the bordered variant with subtle border styling.'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ElevatedScreen extends StatelessWidget {
  const ElevatedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SmartAppBar(
        title: 'Elevated AppBar ⬆️',
        variant: SmartAppBarVariant.elevated,
        elevation: 8.0,
        backgroundColor: Colors.blue[50],
        actions: [SmartAppBarAction.notifications, SmartAppBarAction.profile],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Elevated AppBar',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  const Text(
                      'This demonstrates the elevated variant with prominent shadow.'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class LargeAppBarScreen extends StatelessWidget {
  const LargeAppBarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SmartAppBar(
        title: 'Large AppBar Hero Section',
        variant: SmartAppBarVariant.large,
        backgroundColor: Colors.purple[100],
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: [SmartAppBarAction.share, SmartAppBarAction.bookmark],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Large AppBar Demo',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 8),
                  const Text(
                      'This demonstrates the large variant perfect for hero sections.'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
