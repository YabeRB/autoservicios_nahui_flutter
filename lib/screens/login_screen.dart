import 'package:flutter/material.dart';
import '../colors.dart';
import 'forgot_password_screen.dart';
import 'register_screen.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _obscurePassword = true;

  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);

  Future<void> _handleGoogleSignIn() async {
    try {
      final GoogleSignInAccount? account = await _googleSignIn.signIn();
      if (account != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Bienvenido: ${account.displayName}")),
        );
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Error: No se pudo seleccionar la cuenta")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(Icons.arrow_back, color: Colors.white, size: 28),
                  ),
                  const Expanded(
                    child: Center(
                      child: Text("Iniciar sesión",
                          style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                    ),
                  ),
                  const SizedBox(width: 28),
                ],
              ),
              const SizedBox(height: 32),

              const Icon(Icons.directions_car, color: AppColors.accentBlue, size: 64),
              const SizedBox(height: 16),
              const Text("Autoservicios Ñahui",
                  style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              const Text("Bienvenido de nuevo, ingresa tus credenciales",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: AppColors.textSecondary, fontSize: 14)),
              const SizedBox(height: 32),

              Container(
                decoration: BoxDecoration(
                  color: AppColors.cardBackground,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: const Color(0xFF252B44), width: 1),
                ),
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Correo electrónico o teléfono",
                        style: TextStyle(color: Colors.white, fontSize: 14)),
                    const SizedBox(height: 8),
                    TextField(
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: AppColors.inputFill,
                        hintText: "ejemplo@correo.com",
                        hintStyle: const TextStyle(color: Color(0xFF5B627A)),
                        prefixIcon: const Icon(Icons.email_outlined, color: AppColors.textSecondary),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                      ),
                    ),
                    const SizedBox(height: 16),

                    const Text("Contraseña", style: TextStyle(color: Colors.white, fontSize: 14)),
                    const SizedBox(height: 8),
                    TextField(
                      obscureText: _obscurePassword,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: AppColors.inputFill,
                        hintText: "••••••••",
                        hintStyle: const TextStyle(color: Color(0xFF5B627A)),
                        prefixIcon: const Icon(Icons.lock_outline, color: AppColors.textSecondary),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscurePassword ? Icons.visibility_off : Icons.visibility,
                            color: AppColors.textSecondary,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscurePassword = !_obscurePassword;
                            });
                          },
                        ),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                      ),
                    ),

                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const ForgotPasswordScreen()));
                        },
                        child: const Text("¿Olvidé mi contraseña?",
                            style: TextStyle(color: AppColors.accentBlue, fontWeight: FontWeight.bold, fontSize: 13)),
                      ),
                    ),
                    const SizedBox(height: 8),

                    SizedBox(
                      width: double.infinity,
                      height: 60,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryBlue,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        onPressed: () {
                        },
                        child: const Text("Iniciar sesión",
                            style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                      ),
                    ),
                    const SizedBox(height: 24),

                    Row(
                      children: [
                        const Expanded(child: Divider(color: Color(0xFF252B44), thickness: 1)),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          child: Text("O continuar con", style: TextStyle(color: Color(0xFF5B627A), fontSize: 12)),
                        ),
                        const Expanded(child: Divider(color: Color(0xFF252B44), thickness: 1)),
                      ],
                    ),
                    const SizedBox(height: 24),

                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton.icon(
                            style: OutlinedButton.styleFrom(
                              backgroundColor: AppColors.primaryBlue,
                              side: const BorderSide(color: AppColors.primaryBlue),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                              padding: const EdgeInsets.symmetric(vertical: 16),
                            ),
                            onPressed: _handleGoogleSignIn,
                            icon: const Icon(Icons.g_mobiledata, color: Colors.white, size: 30),
                            label: const Text("Google", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: OutlinedButton.icon(
                            style: OutlinedButton.styleFrom(
                              backgroundColor: AppColors.primaryBlue,
                              side: const BorderSide(color: AppColors.primaryBlue),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                              padding: const EdgeInsets.symmetric(vertical: 16),
                            ),
                            onPressed: () {
                            },
                            icon: const Icon(Icons.facebook, color: Colors.white),
                            label: const Text("Facebook", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(height: 32),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("¿No tienes cuenta? ", style: TextStyle(color: AppColors.textSecondary)),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const RegisterScreen())
                      );
                    },
                    child: const Text("Registrarte",
                        style: TextStyle(color: AppColors.accentBlue, fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}