import 'package:flutter/material.dart';
import '../colors.dart';

class HojaIngresoScreen extends StatefulWidget {
  const HojaIngresoScreen({super.key});

  @override
  State<HojaIngresoScreen> createState() => _HojaIngresoScreenState();
}

class _HojaIngresoScreenState extends State<HojaIngresoScreen> {
  final Map<String, bool> _exterior = {
    'Plumillas': false, 'Brazos': false, 'Espejo Lateral': false, 'Faros': false,
    'Micas': false, 'Antena': false, 'Emblemas': false, 'Protector Puerta': false,
    'Parachoque Delantero': false, 'Parachoque Posterior': false, 'Lunas': false,
    'Tapa Gas': false, 'Vasos Ruedas': false, 'Carrocerías': false,
  };

  final Map<String, bool> _interior = {
    'Encendedor': false, 'Tapasoles': false, 'Manija Luces': false, 'Cinturones Seguridad': false,
    'Pisos de Jebe': false, 'Tapiz': false, 'Espejo Interior': false, 'Radio': false,
    'Toca Casseits': false, 'Ceniceros': false, 'Guantera': false, 'N° de Llaves': false,
    'Claxon': false, 'Parlantes': false,
  };

  final Map<String, bool> _motor = {
    'Tapa Liq. de Freno': false, 'Tapa Liq. de Embrague': false, 'Tapa de Radiador': false,
    'Tapas de Batería': false, 'Tapa Aceite': false, 'Tapa Timón Hidráulico': false,
    'Varilla Aceite': false, 'Varilla Aceite automático': false, 'Claxon Aire': false,
    'Fajas': false, 'Purificador Aire': false,
  };

  final Map<String, bool> _maletera = {
    'Llanta Repuesto': false, 'Seguro Llanta': false, 'Gata': false, 'Llave Ruedas': false,
    'Palanca': false, 'Estuche Herramientas': false, 'N° Herramientas': false,
    'N° Tapones Jebe': false, 'N° Cartones': false, 'Otros': false,
  };

  Widget _buildTextField(String label, {int flex = 1, int maxLines = 1, TextInputType type = TextInputType.text}) {
    return Expanded(
      flex: flex,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 8.0),
        child: TextField(
          maxLines: maxLines,
          keyboardType: type,
          style: const TextStyle(color: Colors.white, fontSize: 14),
          decoration: InputDecoration(
            labelText: label,
            labelStyle: const TextStyle(color: Color(0xFF8B8E9F), fontSize: 12),
            filled: true,
            fillColor: const Color(0xFF161B2E),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 24, bottom: 12),
      child: Text(
        title.toUpperCase(),
        style: const TextStyle(color: AppColors.accentBlue, fontSize: 16, fontWeight: FontWeight.bold, letterSpacing: 1.2),
      ),
    );
  }

  Widget _buildExpansionCategory(String title, Map<String, bool> categoryMap) {
    return Card(
      color: const Color(0xFF161B2E),
      margin: const EdgeInsets.only(bottom: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          iconColor: AppColors.accentBlue,
          collapsedIconColor: Colors.white,
          title: Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Wrap(
                spacing: 8.0,
                runSpacing: 0.0,
                children: categoryMap.keys.map((String key) {
                  return SizedBox(
                    width: (MediaQuery.of(context).size.width / 2) - 36,
                    child: CheckboxListTile(
                      contentPadding: EdgeInsets.zero,
                      controlAffinity: ListTileControlAffinity.leading,
                      activeColor: AppColors.primaryBlue,
                      checkColor: Colors.white,
                      title: Text(key, style: const TextStyle(color: Colors.white, fontSize: 12)),
                      value: categoryMap[key],
                      onChanged: (bool? value) {
                        setState(() {
                          categoryMap[key] = value ?? false;
                        });
                      },
                    ),
                  );
                }).toList(),
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
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text("HOJA DE INGRESO", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle("Datos Generales"),
            Row(
              children: [
                _buildTextField("Día/Mes/Año", type: TextInputType.datetime),
                _buildTextField("Teléfono", type: TextInputType.phone),
              ],
            ),
            Row(children: [_buildTextField("Nombre del Propietario")]),
            Row(children: [_buildTextField("Dirección")]),
            Row(
              children: [
                _buildTextField("N° de Placa"),
                _buildTextField("Colores"),
              ],
            ),
            Row(
              children: [
                _buildTextField("Marca"),
                _buildTextField("Modelo"),
              ],
            ),
            Row(
              children: [
                _buildTextField("Año de Fab.", type: TextInputType.number),
                _buildTextField("Carrocería"),
              ],
            ),

            _buildSectionTitle("Descripción del Vehículo"),
            _buildExpansionCategory("1. Exterior", _exterior),
            _buildExpansionCategory("2. Interior", _interior),
            _buildExpansionCategory("3. Motor", _motor),
            _buildExpansionCategory("4. Maletera", _maletera),

            _buildSectionTitle("Compresión de Cilindros"),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFF161B2E),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Ingrese la compresión medida para cada cilindro:",
                    style: TextStyle(color: Color(0xFF8B8E9F), fontSize: 12),
                  ),
                  const SizedBox(height: 12),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(8, (index) {
                        return Container(
                          width: 60,
                          margin: const EdgeInsets.only(right: 8),
                            child: TextField(
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.center,
                              style: const TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                labelText: "Cil ${index + 1}",
                                labelStyle: const TextStyle(color: AppColors.accentBlue, fontSize: 12),
                                filled: true,
                                fillColor: AppColors.background,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide.none
                                ),
                                contentPadding: const EdgeInsets.symmetric(vertical: 8),
                              ),
                            )
                        );
                      }),
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "* Diferencia máx. respecto al fabricante: 20%. Entre cilindros: 10%.",
                    style: TextStyle(color: Color(0xFF5B627A), fontSize: 10, fontStyle: FontStyle.italic),
                  ),
                ],
              ),
            ),

            _buildSectionTitle("Observaciones Adicionales"),
            Row(
              children: [
                _buildTextField("Escriba aquí anotaciones", maxLines: 4),
              ],
            ),

            const SizedBox(height: 32),

            SizedBox(
              width: double.infinity,
              height: 60,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryBlue,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Hoja de ingreso guardada exitosamente")),
                  );
                },
                child: const Text("Guardar Hoja de Ingreso", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}