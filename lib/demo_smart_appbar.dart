import 'package:flutter/material.dart';
import 'smart_appbar.dart';

void main() {
  runApp(const SmartAppBarDemo());
}

class SmartAppBarDemo extends StatelessWidget {
  const SmartAppBarDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SmartAppBar Demo',
      debugShowCheckedModeBanner: false,
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
      themeMode: ThemeMode.system,
      home: const HomeScreen(),
      routes: {
        '/home': (context) => const HomeScreen(),
        '/petProfile': (context) => const PetProfileScreen(),
        '/settings': (context) => const SettingsScreen(),
        '/profile': (context) => const ProfileScreen(),
        '/dashboard': (context) => const DashboardScreen(),
      },
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SmartAppBar(), // Automatic: transparent variant, title "Home 🏠", notifications + profile actions
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF1E3A8A),
              Color(0xFF1E40AF),
              Color(0xFF3B82F6),
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                '🏠 Welcome to Home Screen',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'This is a transparent SmartAppBar',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white70,
                ),
              ),
              const SizedBox(height: 40),
              _buildNavigationCard(context, 'Pet Profile 🐾', '/petProfile'),
              const SizedBox(height: 16),
              _buildNavigationCard(context, 'Settings ⚙️', '/settings'),
              const SizedBox(height: 16),
              _buildNavigationCard(context, 'Profile 👤', '/profile'),
              const SizedBox(height: 16),
              _buildNavigationCard(context, 'Dashboard 📊', '/dashboard'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavigationCard(BuildContext context, String title, String route) {
    return Card(
      elevation: 8,
      child: ListTile(
        leading: Icon(
          _getIconForRoute(route),
          color: Theme.of(context).colorScheme.primary,
        ),
        title: Text(title),
        subtitle: Text('Navigate to ${title.toLowerCase()}'),
        onTap: () => Navigator.of(context).pushNamed(route),
      ),
    );
  }

  IconData _getIconForRoute(String route) {
    switch (route) {
      case '/petProfile':
        return Icons.pets;
      case '/settings':
        return Icons.settings;
      case '/profile':
        return Icons.person;
      case '/dashboard':
        return Icons.dashboard;
      default:
        return Icons.home;
    }
  }
}

class PetProfileScreen extends StatelessWidget {
  const PetProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SmartAppBar(), // Automatic: glass variant, title "Pet Profile 🐾", edit + share actions
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF8B5A96),
              Color(0xFF9C27B0),
              Color(0xFFBA68C8),
            ],
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.pets,
                  size: 120,
                  color: Colors.white,
                ),
                const SizedBox(height: 20),
                const Text(
                  '🐾 Max the Golden Retriever',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                const Text(
                  'Age: 3 years old',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white70,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Favorite activity: Playing fetch',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white70,
                  ),
                ),
                const SizedBox(height: 40),
                ElevatedButton.icon(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('🎾 Playing fetch with Max!'),
                        backgroundColor: Colors.green,
                      ),
                    );
                  },
                  icon: const Icon(Icons.play_arrow),
                  label: const Text('Play with Max'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.purple,
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SmartAppBar(), // Automatic: bordered variant, title "Settings ⚙️", search + more actions
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            const Text(
              'Settings',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            _buildSettingsSection('Account', [
              _buildSettingsItem(Icons.person, 'Profile Settings', 'Manage your profile information'),
              _buildSettingsItem(Icons.security, 'Privacy & Security', 'Control your data and privacy'),
            ]),
            const SizedBox(height: 20),
            _buildSettingsSection('Preferences', [
              _buildSettingsItem(Icons.notifications, 'Notifications', 'Configure notification preferences'),
              _buildSettingsItem(Icons.palette, 'Theme & Display', 'Customize appearance'),
            ]),
       
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        Card(
          child: Column(children: children),
        ),
      ],
    );
  }

  Widget _buildSettingsItem(IconData icon, String title, String subtitle) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: () {
        // Handle settings item tap
      },
    );
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SmartAppBar(), // Automatic: standard variant, title "Profile 👤", edit + settings actions
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const CircleAvatar(
                      radius: 50,
                      child: Icon(Icons.person, size: 50),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Manouraaa',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'manar@gmail.com',
                      style: TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildStatItem('120', 'Posts'),
                        _buildStatItem('1.2K', 'Followers'),
                        _buildStatItem('800', 'Following'),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            _buildProfileListItem(Icons.favorite, 'Favorite Posts', 'View your liked posts'),
            _buildProfileListItem(Icons.bookmark, 'Bookmarks', 'View saved content'),
            _buildProfileListItem(Icons.history, 'History', 'View your activity history'),
            _buildProfileListItem(Icons.share, 'Invite Friends', 'Share the app with friends'),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(String number, String label) {
    return Column(
      children: [
        Text(
          number,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Text(
          label,
          style: const TextStyle(color: Colors.grey),
        ),
      ],
    );
  }

  Widget _buildProfileListItem(IconData icon, String title, String subtitle) {
    return Card(
      child: ListTile(
        leading: Icon(icon),
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () {
          // Handle profile item tap
        },
      ),
    );
  }
}

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SmartAppBar(), // Automatic: glass variant, title "Dashboard 📊", notifications + search actions
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF1B4332),
              Color(0xFF2D5A47),
              Color(0xFF52B788),
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              const Text(
                '📊 Dashboard Overview',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  _buildDashboardCard('Users', '1,234', Icons.people, Colors.blue),
                  const SizedBox(width: 16),
                  _buildDashboardCard('Revenue', '\$12.5K', Icons.attach_money, Colors.green),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  _buildDashboardCard('Orders', '89', Icons.shopping_cart, Colors.orange),
                  const SizedBox(width: 16),
                  _buildDashboardCard('Growth', '+15%', Icons.trending_up, Colors.purple),
                ],
              ),
              const SizedBox(height: 30),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDashboardCard(String title, String value, IconData icon, Color color) {
    return Expanded(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(icon, color: color, size: 32),
              const SizedBox(height: 8),
              Text(
                value,
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              Text(
                title,
                style: const TextStyle(color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActivityItem(String activity, String time) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          const Icon(Icons.circle, size: 8, color: Colors.green),
          const SizedBox(width: 12),
          Expanded(child: Text(activity)),
          Text(
            time,
            style: const TextStyle(color: Colors.grey, fontSize: 12),
          ),
        ],
      ),
    );
  }
}