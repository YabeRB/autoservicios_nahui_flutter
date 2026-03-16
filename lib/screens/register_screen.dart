import 'package:flutter/material.dart';
import '../colors.dart';
import 'login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _acceptedTerms = false;

  Widget _buildTextField({
    required String label,
    required String hint,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    bool isPassword = false,
    bool isConfirmPassword = false,
  }) {
    bool obscureText = isPassword ? _obscurePassword : (isConfirmPassword ? _obscureConfirmPassword : false);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        TextField(
          obscureText: obscureText,
          keyboardType: keyboardType,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            filled: true,
            fillColor: AppColors.inputFill,
            hintText: hint,
            hintStyle: const TextStyle(color: Color(0xFF6B6E84)),
            prefixIcon: Icon(icon, color: const Color(0xFF6B6E84)),
            suffixIcon: (isPassword || isConfirmPassword)
                ? IconButton(
              icon: Icon(
                  obscureText ? Icons.visibility_off : Icons.visibility,
                  color: const Color(0xFF6B6E84)
              ),
              onPressed: () {
                setState(() {
                  if (isPassword) {
                    _obscurePassword = !_obscurePassword;
                  } else {
                    _obscureConfirmPassword = !_obscureConfirmPassword;
                  }
                });
              },
            )
                : null,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(Icons.arrow_back, color: Colors.white, size: 28),
                  ),
                  const Expanded(
                    child: Center(
                      child: Text("Registro", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                    ),
                  ),
                  const SizedBox(width: 28),
                ],
              ),
              const SizedBox(height: 32),

              const Center(child: Text("Autoservicios Ñahui", style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold))),
              const SizedBox(height: 8),
              const Center(child: Text("Crea tu cuenta para empezar", style: TextStyle(color: Color(0xFF8B8E9F), fontSize: 14))),
              const SizedBox(height: 32),

              _buildTextField(label: "Nombre completo", hint: "Ej. Juan Pérez", icon: Icons.person_outline),
              _buildTextField(label: "Correo electrónico", hint: "ejemplo@correo.com", icon: Icons.email_outlined, keyboardType: TextInputType.emailAddress),
              _buildTextField(label: "Número de teléfono", hint: "+51 987 654 321", icon: Icons.phone_outlined, keyboardType: TextInputType.phone),
              _buildTextField(label: "Contraseña", hint: "••••••••", icon: Icons.lock_outline, isPassword: true),
              _buildTextField(label: "Confirmar contraseña", hint: "••••••••", icon: Icons.lock_outline, isConfirmPassword: true),

              Row(
                children: [
                  Theme(
                    data: Theme.of(context).copyWith(unselectedWidgetColor: const Color(0xFF6B6E84)),
                    child: Checkbox(
                      value: _acceptedTerms,
                      activeColor: AppColors.primaryBlue,
                      onChanged: (value) => setState(() => _acceptedTerms = value ?? false),
                    ),
                  ),
                  const Text("Acepto los ", style: TextStyle(color: Color(0xFF8B8E9F), fontSize: 14)),
                  const Text("términos y condiciones", style: TextStyle(color: AppColors.accentBlue, fontSize: 14, fontWeight: FontWeight.bold)),
                ],
              ),
              const SizedBox(height: 24),

              SizedBox(
                width: double.infinity,
                height: 60,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryBlue,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  onPressed: () {
                    if (!_acceptedTerms) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Debes aceptar los términos y condiciones')),
                      );
                    }
                  },
                  child: const Text("Crear cuenta", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                ),
              ),
              const SizedBox(height: 32),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("¿Ya tienes cuenta? ", style: TextStyle(color: Color(0xFF8B8E9F), fontSize: 14)),
                  GestureDetector(
                    onTap: () {

                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => const LoginScreen())
                      );
                    },
                    child: const Text("Iniciar sesión",
                        style: TextStyle(color: AppColors.accentBlue, fontSize: 14, fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}