

import 'package:flutter/material.dart';

// Punto de inicio de la aplicación.
void main() {
  runApp(const MyApp());
}

// Configuración principal de la aplicación.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      // Configuración del tema y colores generales.
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF216E45),
        ),
        scaffoldBackgroundColor: const Color(0xFFF4F8F5),
      ),

      // Pantalla inicial.
      home: const RegistroScreen(),
    );
  }
}

// Pantalla del formulario de registro.
class RegistroScreen extends StatefulWidget {
  const RegistroScreen({super.key});

  @override
  State<RegistroScreen> createState() => _RegistroScreenState();
}

// Contiene los datos y funciones del formulario.
class _RegistroScreenState extends State<RegistroScreen> {

  // Controladores para capturar la información.
  final TextEditingController nombreController = TextEditingController();
  final TextEditingController direccionController = TextEditingController();
  final TextEditingController fechaController = TextEditingController();
  final TextEditingController cargoController = TextEditingController();

  // Variable para almacenar los datos que se mostrarán.
  String datos = '';

  // Función para seleccionar la fecha de nacimiento.
  Future<void> seleccionarFecha() async {
    DateTime? fecha = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    // Si se selecciona una fecha, se muestra en el campo.
    if (fecha != null) {
      setState(() {
        fechaController.text =
        '${fecha.day.toString().padLeft(2, '0')}/'
            '${fecha.month.toString().padLeft(2, '0')}/'
            '${fecha.year}';
      });
    }
  }

  // Libera los controladores al cerrar la pantalla.
  @override
  void dispose() {
    nombreController.dispose();
    direccionController.dispose();
    fechaController.dispose();
    cargoController.dispose();
    super.dispose();
  }

  // Construye la interfaz gráfica.
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      // Encabezado de la aplicación.
      appBar: AppBar(
        title: const Text(
          'Empresa XYZ - Registro',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF216E45),
        foregroundColor: Colors.white,
        centerTitle: false,
      ),

      // Contenido principal de la pantalla.
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),

          // Organiza los elementos verticalmente.
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [

              // Título del formulario.
              const Text(
                'Formulario de registro',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF216E45),
                ),
              ),

              const SizedBox(height: 8),

              // Texto de orientación para el usuario.
              const Text(
                'Ingrese la información solicitada.',
                style: TextStyle(color: Colors.black54),
              ),

              const SizedBox(height: 20),

              // Campo para el nombre completo.
              TextField(
                controller: nombreController,
                decoration: InputDecoration(
                  labelText: 'Nombre completo',
                  prefixIcon: const Icon(Icons.person),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),

              const SizedBox(height: 15),

              // Campo para la dirección.
              TextField(
                controller: direccionController,
                decoration: InputDecoration(
                  labelText: 'Dirección',
                  prefixIcon: const Icon(Icons.location_on),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),

              const SizedBox(height: 15),

              // Campo de fecha con calendario.
              TextField(
                controller: fechaController,
                readOnly: true,
                onTap: seleccionarFecha,
                decoration: InputDecoration(
                  labelText: 'Fecha de nacimiento',
                  hintText: 'dd/mm/aaaa',
                  prefixIcon: const Icon(Icons.calendar_month),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),

              const SizedBox(height: 15),

              // Campo para el cargo.
              TextField(
                controller: cargoController,
                decoration: InputDecoration(
                  labelText: 'Cargo',
                  prefixIcon: const Icon(Icons.work),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),

              const SizedBox(height: 25),

              // Botón para mostrar los datos.
              SizedBox(
                height: 50,
                child: ElevatedButton(
                  onPressed: () {

                    // Comprueba que los campos estén completos.
                    if (nombreController.text.isEmpty ||
                        direccionController.text.isEmpty ||
                        fechaController.text.isEmpty ||
                        cargoController.text.isEmpty) {

                      // Muestra un mensaje si faltan datos.
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Por favor, complete todos los campos.',
                          ),
                        ),
                      );
                    } else {

                      // Actualiza la información mostrada.
                      setState(() {
                        datos = 'DATOS REGISTRADOS\n\n'
                            'Nombre: ${nombreController.text}\n'
                            'Dirección: ${direccionController.text}\n'
                            'Nacimiento: ${fechaController.text}\n'
                            'Cargo: ${cargoController.text}';
                      });
                    }
                  },

                  // Diseño del botón.
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF216E45),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),

                  // Texto del botón.
                  child: const Text(
                    'MOSTRAR DATOS',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Tarjeta donde aparecerán los datos.
              if (datos.isNotEmpty)
                Container(
                  padding: const EdgeInsets.all(16),

                  // Personaliza la tarjeta de resultados.
                  decoration: BoxDecoration(
                    color: const Color(0xFFE3F1E8),
                    border: Border.all(
                      color: const Color(0xFF216E45),
                    ),
                    borderRadius: BorderRadius.circular(15),
                  ),

                  // Presenta los datos registrados.
                  child: Text(
                    datos,
                    style: const TextStyle(
                      fontSize: 15,
                      height: 1.6,
                    ),
                  ),
                )
              else
              // Mensaje inicial antes de registrar.
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: const Color(0xFFD5E4DA),
                    ),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: const Text(
                    'Aquí se mostrarán los datos al presionar el botón.',
                    style: TextStyle(color: Colors.black54),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
