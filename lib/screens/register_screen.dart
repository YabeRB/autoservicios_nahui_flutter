import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../colors.dart';
import 'login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _acceptedTerms = false;
  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _registerUser() async {
    if (!_acceptedTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Debes aceptar los términos y condiciones')),
      );
      return;
    }

    if (_passwordController.text != _confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Las contraseñas no coinciden')),
      );
      return;
    }

    if (_nameController.text.isEmpty || _emailController.text.isEmpty || _passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, completa todos los campos')),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      await userCredential.user?.updateDisplayName(_nameController.text.trim());

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('¡Cuenta creada con éxito! Por favor inicia sesión.'), backgroundColor: Colors.green),
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
        );
      }
    } on FirebaseAuthException catch (e) {
      String errorMessage = 'Ocurrió un error al registrarse';
      if (e.code == 'weak-password') {
        errorMessage = 'La contraseña es muy débil (mínimo 6 caracteres)';
      } else if (e.code == 'email-already-in-use') {
        errorMessage = 'Ya existe una cuenta con este correo';
      } else if (e.code == 'invalid-email') {
        errorMessage = 'El formato del correo no es válido';
      }

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(errorMessage), backgroundColor: Colors.redAccent),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Widget _buildTextField({
    required String label,
    required String hint,
    required IconData icon,
    required TextEditingController controller,
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
          controller: controller,
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

              _buildTextField(label: "Nombre completo", hint: "Ej. Juan Pérez", icon: Icons.person_outline, controller: _nameController),
              _buildTextField(label: "Correo electrónico", hint: "ejemplo@correo.com", icon: Icons.email_outlined, keyboardType: TextInputType.emailAddress, controller: _emailController),
              _buildTextField(label: "Contraseña", hint: "••••••••", icon: Icons.lock_outline, isPassword: true, controller: _passwordController),
              _buildTextField(label: "Confirmar contraseña", hint: "••••••••", icon: Icons.lock_outline, isConfirmPassword: true, controller: _confirmPasswordController),

              Row(
                children: [
                  Theme(
                    data: Theme.of(context).copyWith(unselectedWidgetColor: const Color(0xFF6B6E84)),
                    child: Checkbox(
                      value: _acceptedTerms,
                      activeColor: AppColors.accentBlue,
                      checkColor: Colors.white,
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
                  onPressed: _isLoading ? null : _registerUser,
                  child: _isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text("Crear cuenta", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
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