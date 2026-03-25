import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../colors.dart';
import 'profile_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final displayName = user?.displayName ?? "Usuario";

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Bienvenido $displayName",
                style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              decoration: InputDecoration(
                filled: true,
                fillColor: AppColors.inputFill,
                hintText: "Buscar repuestos o accesorios...",
                hintStyle: const TextStyle(color: Color(0xFF5B627A)),
                prefixIcon: const Icon(Icons.search, color: AppColors.textSecondary),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
              ),
            ),
            const SizedBox(height: 24),

            const Text("Categorías", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),

            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildCategoryItem(Icons.local_gas_station, "Accesorios\nGasolina"),
                  _buildCategoryItem(Icons.ev_station, "Accesorios\nGLP"),
                  _buildCategoryItem(Icons.electric_car, "Accesorios\nGNV"),
                  _buildCategoryItem(Icons.oil_barrel, "Aceites\n"),
                ],
              ),
            ),
            const SizedBox(height: 24),

            const Text("Productos Destacados", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),

            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              children: [
                _buildProductItem("assets/images/product/spark_plugs.png", "Juego de Bujías", "S/ 115.00"),
                _buildProductItem("assets/images/product/valve.jpg", "Válvula de llenado GNV", "S/ 40.00"),
                _buildProductItem("assets/images/product/injectors.png", "Riel de Inyectores de gas Valtek 3", "S/ 200.00"),
                _buildProductItem("assets/images/product/oil.png", "Castrol Magnatec 5W-30", "S/ 170.00"),
              ],
            ),
          ],
        ),
      ),

      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: AppColors.cardBackground,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppColors.accentBlue,
        unselectedItemColor: AppColors.textSecondary,
        currentIndex: 0,
        onTap: (index) {
          if (index == 3) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ProfileScreen()),
            );
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Inicio"),
          BottomNavigationBarItem(icon: Icon(Icons.grid_view), label: "Categorías"),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_bag_outlined), label: "Mis pedidos"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Perfil"),
        ],
      ),
    );
  }

  Widget _buildCategoryItem(IconData icon, String label) {
    return Container(
      width: 100,
      height: 100,
      margin: const EdgeInsets.only(right: 16),
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 12),
      decoration: BoxDecoration(color: AppColors.primaryBlue, borderRadius: BorderRadius.circular(12)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.white, size: 30),
          const SizedBox(height: 8),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white, fontSize: 12, height: 1.2),
          ),
        ],
      ),
    );
  }

  Widget _buildProductItem(String imagePath, String name, String price) {
    return Container(
      decoration: BoxDecoration(color: AppColors.cardBackground, borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            child: Image.asset(
              imagePath,
              fit: BoxFit.cover,
              height: 90,
              errorBuilder: (context, error, stackTrace) => Container(
                height: 90,
                color: const Color(0xFF2A2D43),
                child: const Icon(Icons.image_not_supported, color: Colors.white54),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                    price,
                    style: const TextStyle(color: AppColors.accentBlue, fontSize: 14, fontWeight: FontWeight.bold)
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}