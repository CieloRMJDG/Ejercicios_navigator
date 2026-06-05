import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const InicioScreen(),
    );
  }
}


class Aprendiz {
  final String nombre;
  final String ficha;
  final String estado;  

  Aprendiz({
    required this.nombre,
    required this.ficha,
    required this.estado,
  });
}

class Novedad {
  final String nombre;
  final String fecha;
  final String motivo;
  final String instructor;

  Novedad({
    required this.nombre,
    required this.fecha,
    required this.motivo,
    required this.instructor,
  });
}


List<Aprendiz> aprendices = [
  Aprendiz(nombre: 'Carlos Ramírez', ficha: '2758341', estado: 'asistio'),
  Aprendiz(nombre: 'Laura Gómez', ficha: '2758341', estado: 'tarde'),
  Aprendiz(nombre: 'Andrés Torres', ficha: '2758341', estado: 'no_asistio'),
  Aprendiz(nombre: 'Valentina Cruz', ficha: '2758341', estado: 'asistio'),
  Aprendiz(nombre: 'Miguel Herrera', ficha: '2758341', estado: 'tarde'),
  Aprendiz(nombre: 'Sofía Martínez', ficha: '2758341', estado: 'asistio'),
];

List<Novedad> novedades = [];





class InicioScreen extends StatelessWidget {
  const InicioScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Control de Asistencia'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.fact_check, size: 100, color: Colors.indigo),
              const SizedBox(height: 20),
              const Text(
                'Bienvenido',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                'Sistema de control de asistencia SENA',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 40),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ListadoScreen()),
                    );
                  },
                  icon: const Icon(Icons.people),
                  label: const Text('Ver listado de aprendices'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.indigo,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    textStyle: const TextStyle(fontSize: 16),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const NovedadScreen()),
                    );
                  },
                  icon: const Icon(Icons.report),
                  label: const Text('Reportar novedad'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    textStyle: const TextStyle(fontSize: 16),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ResumenScreen()),
                    );
                  },
                  icon: const Icon(Icons.bar_chart),
                  label: const Text('Ver resumen visual'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    textStyle: const TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}





class ListadoScreen extends StatelessWidget {
  const ListadoScreen({super.key});

  Color _colorEstado(String estado) {
    switch (estado) {
      case 'asistio':
        return Colors.green;
      case 'tarde':
        return Colors.orange;
      case 'no_asistio':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  IconData _iconEstado(String estado) {
    switch (estado) {
      case 'asistio':
        return Icons.check_circle;
      case 'tarde':
        return Icons.access_time;
      case 'no_asistio':
        return Icons.cancel;
      default:
        return Icons.help;
    }
  }

  String _textoEstado(String estado) {
    switch (estado) {
      case 'asistio':
        return 'Asistió';
      case 'tarde':
        return 'Llegó tarde';
      case 'no_asistio':
        return 'No asistió';
      default:
        return 'Desconocido';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Listado de Aprendices'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: aprendices.length,
        separatorBuilder: (context, index) => const SizedBox(height: 10),
        itemBuilder: (context, index) {
          final aprendiz = aprendices[index];
          final color = _colorEstado(aprendiz.estado);
          return Card(
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: BorderSide(color: color.withOpacity(0.4), width: 1.5),
            ),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: color.withOpacity(0.15),
                child: Icon(_iconEstado(aprendiz.estado), color: color),
              ),
              title: Text(
                aprendiz.nombre,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text('Ficha: ${aprendiz.ficha}'),
              trailing: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: color),
                ),
                child: Text(
                  _textoEstado(aprendiz.estado),
                  style: TextStyle(
                      color: color,
                      fontWeight: FontWeight.bold,
                      fontSize: 12),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}




class NovedadScreen extends StatefulWidget {
  const NovedadScreen({super.key});

  @override
  State<NovedadScreen> createState() => _NovedadScreenState();
}

class _NovedadScreenState extends State<NovedadScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController nombreController = TextEditingController();
  final TextEditingController fechaController = TextEditingController();
  final TextEditingController motivoController = TextEditingController();
  final TextEditingController instructorController = TextEditingController();

  String resultado = '';

  void registrarNovedad() {
    if (formKey.currentState!.validate()) {
      final nueva = Novedad(
        nombre: nombreController.text,
        fecha: fechaController.text,
        motivo: motivoController.text,
        instructor: instructorController.text,
      );
      novedades.add(nueva);
      setState(() {
        resultado =
            'Novedad registrada para ${nombreController.text} el ${fechaController.text}.';
      });
    }
  }

  void limpiar() {
    setState(() {
      nombreController.clear();
      fechaController.clear();
      motivoController.clear();
      instructorController.clear();
      resultado = '';
    });
  }

  @override
  void dispose() {
    nombreController.dispose();
    fechaController.dispose();
    motivoController.dispose();
    instructorController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reportar Novedad'),
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              const Icon(Icons.report_problem,
                  size: 90, color: Colors.orange),
              const SizedBox(height: 10),
              const Text(
                'Formulario de Novedad',
                style:
                    TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),

             
              TextFormField(
                controller: nombreController,
                decoration: const InputDecoration(
                  labelText: 'Nombre del aprendiz',
                  prefixIcon: Icon(Icons.person),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'El nombre es obligatorio';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15),

              TextFormField(
                controller: fechaController,
                decoration: const InputDecoration(
                  labelText: 'Fecha (dd/mm/aaaa)',
                  prefixIcon: Icon(Icons.calendar_today),
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.datetime,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'La fecha es obligatoria';
                  }
                  return null;
                },
              ),
   
              TextFormField(
                controller: motivoController,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: 'Motivo de la novedad',
                  prefixIcon: Icon(Icons.description),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'El motivo es obligatorio';
                  }
                  if (value.length < 10) {
                    return 'El motivo debe tener al menos 10 caracteres';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15),

       
              TextFormField(
                controller: instructorController,
                decoration: const InputDecoration(
                  labelText: 'Instructor que reporta',
                  prefixIcon: Icon(Icons.school),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'El nombre del instructor es obligatorio';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),

     
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: registrarNovedad,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 12),
                    ),
                    child: const Text('Registrar'),
                  ),
                  ElevatedButton(
                    onPressed: limpiar,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 12),
                    ),
                    child: const Text('Limpiar'),
                  ),
                ],
              ),
              const SizedBox(height: 20),

            
              if (resultado.isNotEmpty)
                Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.orange[50],
                    border: Border.all(color: Colors.orange),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    resultado,
                    style: const TextStyle(color: Colors.orange),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}




class ResumenScreen extends StatelessWidget {
  const ResumenScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final int asistieron =
        aprendices.where((a) => a.estado == 'asistio').length;
    final int tarde = aprendices.where((a) => a.estado == 'tarde').length;
    final int noAsistieron =
        aprendices.where((a) => a.estado == 'no_asistio').length;
    final int total = aprendices.length;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Resumen Visual'),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Icon(Icons.bar_chart, size: 80, color: Colors.teal),
            const SizedBox(height: 10),
            const Text(
              'Resumen de Asistencia',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),
            Text(
              'Total de aprendices: $total',
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 25),

            _tarjetaResumen(
              icono: Icons.check_circle,
              color: Colors.green,
              etiqueta: 'Asistieron',
              cantidad: asistieron,
              total: total,
            ),
            const SizedBox(height: 12),
            _tarjetaResumen(
              icono: Icons.access_time,
              color: Colors.orange,
              etiqueta: 'Llegaron tarde',
              cantidad: tarde,
              total: total,
            ),
            const SizedBox(height: 12),
            _tarjetaResumen(
              icono: Icons.cancel,
              color: Colors.red,
              etiqueta: 'No asistieron',
              cantidad: noAsistieron,
              total: total,
            ),

            const SizedBox(height: 30),
            const Divider(),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
  

  Widget _tarjetaResumen({
    required IconData icono,
    required Color color,
    required String etiqueta,
    required int cantidad,
    required int total,
  }) {
    final double porcentaje = total > 0 ? cantidad / total : 0;

    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        border: Border.all(color: color.withOpacity(0.4)),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Icon(icono, color: color, size: 30),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  etiqueta,
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: color),
                ),
              ),
              Text(
                '$cantidad / $total',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: color),
              ),
            ],
          ),
          const SizedBox(height: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: LinearProgressIndicator(
              value: porcentaje,
              minHeight: 10,
              backgroundColor: color.withOpacity(0.15),
              valueColor: AlwaysStoppedAnimation<Color>(color),
            ),
          ),
          const SizedBox(height: 5),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              '${(porcentaje * 100).toStringAsFixed(0)}%',
              style: TextStyle(color: color, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}