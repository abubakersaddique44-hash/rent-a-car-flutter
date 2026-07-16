import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../providers/theme_provider.dart';
import '../constants/app_colors.dart';
import 'favorites_screen.dart';
import 'login_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  Future<void> _updatePhoto(BuildContext context, AuthProvider auth) async {
    final img = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (img != null && auth.user != null) {
      await auth.updateProfile(auth.user!.copyWith(profilePicture: img.path));
    }
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);
    final theme = Provider.of<ThemeProvider>(context);
    final u = auth.user;

    return Scaffold(
      appBar: AppBar(title: const Text('Profile'), centerTitle: true),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 30),
            _buildAvatar(u, () => _updatePhoto(context, auth)),
            const SizedBox(height: 16),
            Text(u?.name ?? 'Guest User', style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            Text(u?.email ?? '', style: const TextStyle(color: Colors.grey)),
            const SizedBox(height: 30),

            _section('Account', [
              _tile('Edit Profile', Icons.person_outline, () => null),
              _tile('My Favorites', Icons.favorite_border, () {
                Navigator.push(context, MaterialPageRoute(builder: (c) => const FavoritesScreen()));
              }),
            ]),
            
            _section('Settings', [
              ListTile(
                leading: const Icon(Icons.dark_mode_outlined),
                title: const Text('Dark Mode'),
                trailing: Switch(
                  value: theme.isDark,
                  onChanged: (v) => theme.setTheme(v),
                  activeThumbColor: AppColors.primary,
                ),
              ),
              _tile('Notifications', Icons.notifications_none, () => null),
            ]),

            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () async {
                    await auth.logout();
                    if (context.mounted) {
                      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (c) => const LoginScreen()), (r) => false);
                    }
                  },
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.red,
                    side: const BorderSide(color: Colors.red),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  child: const Text('Logout', style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAvatar(dynamic user, VoidCallback onEdit) {
    return Center(
      child: Stack(
        children: [
          CircleAvatar(
            radius: 55,
            backgroundColor: AppColors.primary,
            backgroundImage: user?.profilePicture != null
                ? (user.profilePicture.startsWith('http') ? NetworkImage(user.profilePicture) : FileImage(File(user.profilePicture)) as ImageProvider)
                : null,
            child: user?.profilePicture == null ? const Icon(Icons.person, size: 50, color: Colors.black) : null,
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: InkWell(
              onTap: onEdit,
              child: Container(
                padding: const EdgeInsets.all(6),
                decoration: const BoxDecoration(color: AppColors.primary, shape: BoxShape.circle),
                child: const Icon(Icons.camera_alt, size: 18, color: Colors.black),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _section(String title, List<Widget> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 5),
          child: Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.primary)),
        ),
        ...items,
      ],
    );
  }

  Widget _tile(String title, IconData icon, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      trailing: const Icon(Icons.arrow_forward_ios, size: 14),
      onTap: onTap,
    );
  }
}
