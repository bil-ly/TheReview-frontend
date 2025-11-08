import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../../viewmodels/auth_viewmodel.dart';
import '../../core/constants.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _darkMode = true;
  bool _pushNotifications = true;
  bool _newReviewAlerts = true;
  bool _summaryDigests = false;

  Future<void> _handleLogout() async {
    final authViewModel = context.read<AuthViewModel>();
    await authViewModel.logout();

    if (mounted) {
      context.go(AppConstants.loginRoute);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('Settings'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            // Appearance Section
            _SectionHeader(title: 'APPEARANCE'),
            _SettingItem(
              icon: Icons.dark_mode_outlined,
              title: 'Dark Mode',
              trailing: Switch(
                value: _darkMode,
                onChanged: (value) {
                  setState(() {
                    _darkMode = value;
                  });
                },
                activeColor: const Color(0xFF00B8D4),
              ),
            ),
            const SizedBox(height: 24),
            // Notification Preferences
            _SectionHeader(title: 'NOTIFICATION PREFERENCES'),
            _SettingItem(
              icon: Icons.notifications_outlined,
              title: 'Push Notifications',
              trailing: Switch(
                value: _pushNotifications,
                onChanged: (value) {
                  setState(() {
                    _pushNotifications = value;
                  });
                },
                activeColor: const Color(0xFF00B8D4),
              ),
            ),
            _SettingItem(
              icon: Icons.new_releases_outlined,
              title: 'New Review Alerts',
              trailing: Switch(
                value: _newReviewAlerts,
                onChanged: (value) {
                  setState(() {
                    _newReviewAlerts = value;
                  });
                },
                activeColor: const Color(0xFF00B8D4),
              ),
            ),
            _SettingItem(
              icon: Icons.email_outlined,
              title: 'Summary Digests',
              trailing: Switch(
                value: _summaryDigests,
                onChanged: (value) {
                  setState(() {
                    _summaryDigests = value;
                  });
                },
                activeColor: const Color(0xFF00B8D4),
              ),
            ),
            const SizedBox(height: 24),
            // Linked Accounts
            _SectionHeader(title: 'LINKED ACCOUNTS'),
            _LinkedAccountItem(
              icon: Icons.g_mobiledata,
              name: 'Google',
              email: 'eliza.stone@gmail.com',
              onDisconnect: () {},
            ),
            _LinkedAccountItem(
              icon: Icons.business,
              name: 'LinkedIn',
              email: 'Eliza Stone',
              onDisconnect: () {},
            ),
            _LinkedAccountItem(
              icon: Icons.flutter_dash,
              name: 'Twitter',
              email: '@elizastone',
              onDisconnect: () {},
            ),
            const SizedBox(height: 24),
            // Support & Legal
            _SectionHeader(title: 'SUPPORT & LEGAL'),
            _NavigationItem(
              icon: Icons.help_outline,
              title: 'Help Center',
              onTap: () {},
            ),
            _NavigationItem(
              icon: Icons.privacy_tip_outlined,
              title: 'Privacy Policy',
              onTap: () {},
            ),
            _NavigationItem(
              icon: Icons.description_outlined,
              title: 'Terms of Service',
              onTap: () {},
            ),
            const SizedBox(height: 24),
            // Account Actions
            _SectionHeader(title: 'ACCOUNT ACTIONS'),
            _ActionItem(
              icon: Icons.logout,
              title: 'Log Out',
              textColor: const Color(0xFF00B8D4),
              onTap: _handleLogout,
            ),
            _ActionItem(
              icon: Icons.delete_outline,
              title: 'Delete Account',
              textColor: const Color(0xFFE53935),
              onTap: () {},
            ),
            const SizedBox(height: 32),
            // Version Info
            Center(
              child: Text(
                'Version 1.2.3 (Build 12345)',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.5),
                  fontSize: 12,
                ),
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;

  const _SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: Colors.white.withOpacity(0.6),
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}

class _SettingItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final Widget trailing;

  const _SettingItem({
    required this.icon,
    required this.title,
    required this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFF2A3544),
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: const Color(0xFF3A4554),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            color: Colors.white,
            size: 20,
          ),
        ),
        title: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 15,
            fontWeight: FontWeight.w500,
          ),
        ),
        trailing: trailing,
      ),
    );
  }
}

class _LinkedAccountItem extends StatelessWidget {
  final IconData icon;
  final String name;
  final String email;
  final VoidCallback onDisconnect;

  const _LinkedAccountItem({
    required this.icon,
    required this.name,
    required this.email,
    required this.onDisconnect,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFF2A3544),
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: const Color(0xFF3A4554),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            color: Colors.white,
            size: 20,
          ),
        ),
        title: Text(
          name,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Text(
          email,
          style: TextStyle(
            color: Colors.white.withOpacity(0.6),
            fontSize: 13,
          ),
        ),
        trailing: TextButton(
          onPressed: onDisconnect,
          child: const Text(
            'Disconnect',
            style: TextStyle(
              color: Color(0xFFE53935),
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}

class _NavigationItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const _NavigationItem({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFF2A3544),
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: const Color(0xFF3A4554),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            color: Colors.white,
            size: 20,
          ),
        ),
        title: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 15,
            fontWeight: FontWeight.w500,
          ),
        ),
        trailing: Icon(
          Icons.chevron_right,
          color: Colors.white.withOpacity(0.5),
        ),
        onTap: onTap,
      ),
    );
  }
}

class _ActionItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final Color textColor;
  final VoidCallback onTap;

  const _ActionItem({
    required this.icon,
    required this.title,
    required this.textColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFF2A3544),
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: textColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            color: textColor,
            size: 20,
          ),
        ),
        title: Text(
          title,
          style: TextStyle(
            color: textColor,
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
        onTap: onTap,
      ),
    );
  }
}
