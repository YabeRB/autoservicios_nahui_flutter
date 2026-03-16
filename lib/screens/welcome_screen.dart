import 'package:flutter/material.dart';
import '../colors.dart';
import 'login_screen.dart';
import 'register_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  const Icon(Icons.directions_car, color: AppColors.accentBlue),
                  const SizedBox(width: 8),
                  const Expanded(
                    child: Text(
                      "Autoservicios Ñahui",
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ),
                  Icon(Icons.help_outline, color: AppColors.textSecondary),
                ],
              ),
              const SizedBox(height: 24),

              Container(
                height: 180,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  image: const DecorationImage(
                    image: AssetImage('assets/images/car_init.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 32),

              const Text("Bienvenido a", style: TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold)),
              const Text("Autoservicios Ñahui", style: TextStyle(color: AppColors.accentBlue, fontSize: 26, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              const Text(
                "Gestiona servicios para tu vehículo de\nforma rápida y segura",
                textAlign: TextAlign.center,
                style: TextStyle(color: Color(0xFFA0A5B9), fontSize: 14),
              ),
              const Spacer(),

              SizedBox(
                width: double.infinity,
                height: 60,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryBlue,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginScreen()));
                  },
                  icon: const Icon(Icons.login, color: Colors.white),
                  label: const Text("Iniciar sesión", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                height: 60,
                child: OutlinedButton.icon(
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Color(0xFF2F3559), width: 1.5),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const RegisterScreen()));
                  },
                  icon: const Icon(Icons.person_add, color: Colors.white),
                  label: const Text("Registrarse", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                ),
              ),
              const SizedBox(height: 24),

              const Text("Continuar como invitado", style: TextStyle(color: Color(0xFFB3B8CD), fontSize: 14, fontWeight: FontWeight.bold)),
              const SizedBox(height: 24),
              const Text("POTENCIADO POR ÑAHUI TECH", style: TextStyle(color: Color(0xFF4B516D), fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1.5)),
            ],
          ),
        ),
      ),
    );
  }
}