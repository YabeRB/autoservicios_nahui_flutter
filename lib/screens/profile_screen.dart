import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import '../colors.dart';
import 'welcome_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final int _selectedIndex = 3;

  String? _userName;
  String? _userPhotoUrl;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  void _loadUserData() {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      setState(() {
        _userName = user.displayName ?? "Usuario de Ñahui";
        _userPhotoUrl = user.photoURL;
        _isLoading = false;
      });
    } else {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _signOut() async {
    try {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(child: CircularProgressIndicator()),
      );

      await FirebaseAuth.instance.signOut();

      if (await GoogleSignIn().isSignedIn()) {
        await GoogleSignIn().signOut();
      }

      await FacebookAuth.instance.logOut();

      if (mounted) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const WelcomeScreen()),
              (route) => false,
        );
      }
    } catch (e) {
      if (mounted) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error al cerrar sesión: $e")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),

              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: AppColors.cardBackground,
                    backgroundImage: _userPhotoUrl != null ? NetworkImage(_userPhotoUrl!) : null,
                    child: _userPhotoUrl == null
                        ? const Icon(Icons.person, size: 50, color: AppColors.textSecondary)
                        : null,
                  ),
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: const BoxDecoration(
                      color: AppColors.accentBlue,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.edit, size: 18, color: Colors.white),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              Text(
                _userName ?? "Cargando...",
                style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 4),
              const Text(
                "Cliente Casual",
                style: TextStyle(color: AppColors.accentBlue, fontSize: 16, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: AppColors.primaryBlue.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppColors.primaryBlue),
                ),
                child: const Text(
                  "VERIFICADO",
                  style: TextStyle(color: AppColors.accentBlue, fontSize: 12, fontWeight: FontWeight.bold, letterSpacing: 1.2),
                ),
              ),

              const SizedBox(height: 32),

              Container(
                decoration: BoxDecoration(
                  color: AppColors.primaryBlue,
                  borderRadius: BorderRadius.circular(16),
                ),
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(Icons.directions_car, color: Colors.white),
                    ),
                    const SizedBox(width: 16),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Mis Vehículos Registrados", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                          SizedBox(height: 4),
                          Text("0 vehículos activos", style: TextStyle(color: AppColors.textSecondary, fontSize: 13)),
                        ],
                      ),
                    ),
                    const Icon(Icons.chevron_right, color: Colors.white),
                  ],
                ),
              ),
              const SizedBox(height: 32),

              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "CONFIGURACIÓN DE CUENTA",
                  style: TextStyle(color: AppColors.textSecondary, fontSize: 12, fontWeight: FontWeight.bold, letterSpacing: 1.5),
                ),
              ),
              const SizedBox(height: 16),
              Container(
                decoration: BoxDecoration(
                  color: AppColors.cardBackground,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    _buildSettingsTile(icon: Icons.person_outline, title: "Información Personal"),
                    _buildDivider(),
                    _buildSettingsTile(icon: Icons.lock_outline, title: "Cambiar Contraseña"),
                    _buildDivider(),
                    _buildSettingsTile(icon: Icons.location_on_outlined, title: "Direcciones de Envío"),
                    _buildDivider(),
                    _buildSettingsTile(icon: Icons.payment_outlined, title: "Métodos de Pago", isLast: true),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "SOPORTE Y LEGAL",
                  style: TextStyle(color: AppColors.textSecondary, fontSize: 12, fontWeight: FontWeight.bold, letterSpacing: 1.5),
                ),
              ),
              const SizedBox(height: 16),
              Container(
                decoration: BoxDecoration(
                  color: AppColors.cardBackground,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    _buildSettingsTile(icon: Icons.support_agent, title: "Soporte Técnico", trailingIcon: Icons.open_in_new),
                    _buildDivider(),
                    _buildSettingsTile(icon: Icons.gavel_outlined, title: "Términos y Condiciones"),
                    _buildDivider(),
                    _buildSettingsTile(
                      icon: Icons.logout,
                      title: "Cerrar Sesión",
                      titleColor: Colors.redAccent,
                      iconColor: Colors.redAccent,
                      isLast: true,
                      onTap: _signOut,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              const Text(
                "VERSIÓN 1.0",
                style: TextStyle(color: Color(0xFF3A415A), fontSize: 11, fontWeight: FontWeight.bold, letterSpacing: 1.2),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),

      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: AppColors.cardBackground,
        ),
        child: BottomNavigationBar(
          backgroundColor: AppColors.cardBackground,
          type: BottomNavigationBarType.fixed,
          currentIndex: _selectedIndex,
          selectedItemColor: AppColors.accentBlue,
          unselectedItemColor: AppColors.textSecondary,
          selectedFontSize: 12,
          unselectedFontSize: 12,
          onTap: (index) {
            if (index == 0) {
              Navigator.pop(context);
            }
          },
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: "Inicio"),
            BottomNavigationBarItem(icon: Icon(Icons.grid_view_rounded), label: "Categorías"),
            BottomNavigationBarItem(icon: Icon(Icons.shopping_bag_rounded), label: "Mis pedidos"),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: "Perfil"),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsTile({
    required IconData icon,
    required String title,
    Color? titleColor,
    Color? iconColor,
    IconData trailingIcon = Icons.chevron_right,
    bool isLast = false,
    VoidCallback? onTap,
  }) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
      leading: Icon(icon, color: iconColor ?? AppColors.accentBlue, size: 24),
      title: Text(
        title,
        style: TextStyle(color: titleColor ?? Colors.white, fontSize: 15, fontWeight: FontWeight.w500),
      ),
      trailing: Icon(trailingIcon, color: AppColors.textSecondary, size: 20),
      onTap: onTap,
    );
  }

  Widget _buildDivider() {
    return const Divider(color: Color(0xFF252B44), height: 1, thickness: 1, indent: 60, endIndent: 20);
  }
}