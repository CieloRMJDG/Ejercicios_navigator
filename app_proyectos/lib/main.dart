import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: InicioScreen(),
    );
  }
}

class InicioScreen extends StatelessWidget {
  const InicioScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Seguimiento de Proyectos"),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Icon(Icons.assignment, size: 80, color: Colors.indigo),

            const SizedBox(height: 10),

            const Text(
              "Dashboard Principal",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Card(
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: [Icon(Icons.folder), Text("4"), Text("Total")],
                    ),
                  ),
                ),

                Card(
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Icon(Icons.check_circle),
                        Text("1"),
                        Text("Finalizado"),
                      ],
                    ),
                  ),
                ),

                Card(
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Icon(Icons.update),
                        Text("2"),
                        Text("Proceso"),
                      ],
                    ),
                  ),
                ),

                Card(
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Icon(Icons.warning),
                        Text("1"),
                        Text("Atrasado"),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 30),

            Card(
              child: ListTile(
                leading: const Icon(Icons.list),
                title: const Text("Lista de Proyectos"),
                subtitle: const Text("Ver proyectos"),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ListaScreen(),
                    ),
                  );
                },
              ),
            ),

            Card(
              child: ListTile(
                leading: const Icon(Icons.edit),
                title: const Text("Reporte de Avance"),
                subtitle: const Text("Registrar avance"),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const FormularioScreen(),
                    ),
                  );
                },
              ),
            ),

            Card(
              child: ListTile(
                leading: const Icon(Icons.lightbulb),
                title: const Text("Recomendaciones"),
                subtitle: const Text("Consejos para el equipo"),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const RecomendacionesScreen(),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ListaScreen extends StatelessWidget {
  const ListaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final proyectos = const [
      'Rediseño de la app móvil',
      'Implementación de Firebase',
      'Campaña de marketing digital',
      'Desarrollo de prototipo web',
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Proyectos'),
        backgroundColor: Colors.indigo,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemBuilder: (context, index) {
          return ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.indigo.shade100,
              child: Text('${index + 1}'),
            ),
            title: Text(proyectos[index]),
            subtitle: const Text('Estado: En progreso'),
          );
        },
        separatorBuilder: (context, index) => const Divider(),
        itemCount: proyectos.length,
      ),
    );
  }
}

class FormularioScreen extends StatefulWidget {
  const FormularioScreen({super.key});

  @override
  State<FormularioScreen> createState() => _FormularioScreenState();
}

class _FormularioScreenState extends State<FormularioScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _projectNameController = TextEditingController();
  final TextEditingController _progressController = TextEditingController();
  String? _selectedStatus = 'En progreso';

  @override
  void dispose() {
    _projectNameController.dispose();
    _progressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reporte de Avance'),
        backgroundColor: Colors.indigo,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _projectNameController,
                decoration: const InputDecoration(
                  labelText: 'Nombre del proyecto',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Ingrese el nombre del proyecto';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _progressController,
                decoration: const InputDecoration(
                  labelText: 'Porcentaje de avance',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  final number = int.tryParse(value ?? '');
                  if (number == null || number < 0 || number > 100) {
                    return 'Ingrese un porcentaje entre 0 y 100';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                initialValue: _selectedStatus,
                items: const [
                  DropdownMenuItem(
                    value: 'En progreso',
                    child: Text('En progreso'),
                  ),
                  DropdownMenuItem(
                    value: 'Finalizado',
                    child: Text('Finalizado'),
                  ),
                  DropdownMenuItem(value: 'Atrasado', child: Text('Atrasado')),
                ],
                decoration: const InputDecoration(
                  labelText: 'Estado',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) => setState(() => _selectedStatus = value),
              ),
              const SizedBox(height: 24),
              FilledButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Avance registrado correctamente'),
                      ),
                    );
                    _projectNameController.clear();
                    _progressController.clear();
                    setState(() {
                      _selectedStatus = 'En progreso';
                    });
                  }
                },
                child: const Text('Guardar avance'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RecomendacionesScreen extends StatelessWidget {
  const RecomendacionesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final recomendaciones = const [
      'Revisar el cronograma semanalmente.',
      'Comunicar bloqueos en cuanto aparezcan.',
      'Asignar tareas claras y medibles.',
      'Documentar los avances importantes.',
      'Celebrar pequeños logros del equipo.',
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Recomendaciones'),
        backgroundColor: Colors.indigo,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: recomendaciones.length,
        separatorBuilder: (context, index) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          return Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                recomendaciones[index],
                style: const TextStyle(fontSize: 16),
              ),
            ),
          );
        },
      ),
    );
  }
}
