import 'package:flutter/material.dart';
import 'hoja_ingreso_screen.dart';
class RoleSelectionScreen extends StatelessWidget {
  const RoleSelectionScreen({super.key});

  Widget _buildRoleCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color iconBgColor,
    required Color cardColor,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 20),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white.withOpacity(0.05)),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: iconBgColor,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(icon, color: Colors.white, size: 28),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Text(subtitle, style: const TextStyle(color: Color(0xFF8B8E9F), fontSize: 13)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF10121D),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF6E78D6)),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text("Autoservicios Ñahui",
            style: TextStyle(color: Color(0xFF6E78D6), fontSize: 16, fontWeight: FontWeight.bold)),
        centerTitle: false,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),

              const Text(
                "SELECCIÓN DE ACCESO",
                style: TextStyle(color: Color(0xFF6E78D6), fontSize: 12, fontWeight: FontWeight.bold, letterSpacing: 2.0),
              ),
              const SizedBox(height: 12),
              const Text(
                "¿Qué eres?",
                style: TextStyle(color: Colors.white, fontSize: 44, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Container(
                width: 50,
                height: 4,
                decoration: BoxDecoration(
                  color: const Color(0xFF3844C7),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 56),

              _buildRoleCard(
                icon: Icons.admin_panel_settings,
                title: "Administrador",
                subtitle: "Gestión total y analíticas",
                iconBgColor: const Color(0xFF1D2469),
                cardColor: const Color(0xFF161B2E),
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Accediendo como Administrador...")),
                  );
                },
              ),

              _buildRoleCard(
                icon: Icons.manage_accounts,
                title: "Empleado",
                subtitle: "Operaciones y servicios técnicos",
                iconBgColor: const Color(0xFF454961),
                cardColor: const Color(0xFF1A1C29),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const HojaIngresoScreen()),
                  );
                },
              ),

              const Spacer(),

              const Text(
                "Sistema de Gestión de Precisión v2.0",
                style: TextStyle(color: Color(0xFF5B627A), fontSize: 12),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}