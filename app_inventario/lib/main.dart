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
            const Icon(
              Icons.assignment,
              size: 80,
              color: Colors.indigo,
            ),

            const SizedBox(height: 10),

            const Text(
              "Dashboard Principal",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Card(
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Icon(Icons.folder),
                        Text("4"),
                        Text("Total")
                      ],
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
                        Text("Finalizado")
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
                        Text("Proceso")
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
                        Text("Atrasado")
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
    return Scaffold(
      appBar: AppBar(
        title: const Text("Lista de Proyectos"),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Card(
            margin: const EdgeInsets.all(10),
            child: ListTile(
              leading: const Icon(Icons.folder, color: Colors.blue),
              title: const Text("Proyecto ADSO App"),
              subtitle: const Text(
                "Equipo: Equipo A\nAvance: 80%\nEstado: En proceso\nPróxima entrega: 10/06/2026",
              ),
            ),
          ),

          Card(
            margin: const EdgeInsets.all(10),
            child: ListTile(
              leading: const Icon(Icons.folder, color: Colors.green),
              title: const Text("Sistema de Inventario"),
              subtitle: const Text(
                "Equipo: Equipo B\nAvance: 60%\nEstado: En proceso\nPróxima entrega: 15/06/2026",
              ),
            ),
          ),

                          Card(
            margin: const EdgeInsets.all(10),
            child: ListTile(
              leading: const Icon(Icons.folder, color: Colors.green),
              title: const Text("Sistema de Inventario"),
              subtitle: const Text(
                "Equipo: Equipo B\nAvance: 60%\nEstado: En proceso\nPróxima entrega: 15/06/2026",
              ),
            ),
          ),

          Card(
            margin: const EdgeInsets.all(10),
            child: ListTile(
              leading: const Icon(Icons.folder, color: Colors.blue),
              title: const Text("Página Web Empresarial"),
              subtitle: const Text(
                "Equipo: Equipo C\nAvance: 100%\nEstado: Finalizado\nPróxima entrega: 05/06/2026",
              ),
            ),
          ),

          Card(
            margin: const EdgeInsets.all(10),
            child: ListTile(
              leading: const Icon(Icons.folder, color: Colors.red),
              title: const Text("Aplicación Móvil"),
              subtitle: const Text(
                "Equipo: Equipo D\nAvance: 40%\nEstado: Retrasado\nPróxima entrega: 20/06/2026",
              ),
            ),
          ),

          const SizedBox(height: 20),

          ElevatedButton.icon(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back),
            label: const Text("Regresar al inicio"),
          ),
        ],
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

  final _nombreController = TextEditingController();
  final _avanceController = TextEditingController();
  final _dificultadController = TextEditingController();
  final _accionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Reporte de Avance"),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nombreController,
                decoration: const InputDecoration(
                  labelText: "Nombre del proyecto",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.folder),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Ingrese el nombre del proyecto";
                  }
                  return null;
                },
              ),

              const SizedBox(height: 15),

              TextFormField(
                controller: _avanceController,
                decoration: const InputDecoration(
                  labelText: "Avance actual",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.percent),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Ingrese el avance actual";
                  }
                  return null;
                },
              ),

              const SizedBox(height: 15),

              TextFormField(
                controller: _dificultadController,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: "Dificultad encontrada",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.warning),
                ),
                validator: (value) {
                  if (value == null || value.length < 10) {
                    return "Mínimo 10 caracteres";
                  }
                  return null;
                },
              ),

              const SizedBox(height: 15),

              TextFormField(
                controller: _accionController,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: "Acción de mejora",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.build),
                ),
                validator: (value) {
                  if (value == null || value.length < 10) {
                    return "Mínimo 10 caracteres";
                  }
                  return null;
                },
              ),

              const SizedBox(height: 25),

              ElevatedButton.icon(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          "Reporte guardado correctamente",
                        ),
                      ),
                    );
                  }
                },
                icon: const Icon(Icons.save),
                label: const Text("Guardar reporte"),
              ),

              const SizedBox(height: 10),

              ElevatedButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back),
                label: const Text("Regresar al inicio"),
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
    return Scaffold(
      appBar: AppBar(
        title: const Text("Recomendaciones"),
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Card(
            margin: const EdgeInsets.all(10),
            child: ListTile(
              leading: const Icon(
                Icons.people,
                color: Colors.blue,
              ),
              title: const Text("Comunicación constante"),
              subtitle: const Text(
                "Mantener reuniones periódicas con el equipo.",
              ),
            ),
          ),

          Card(
            margin: const EdgeInsets.all(10),
            child: ListTile(
              leading: const Icon(
                Icons.assignment_ind,
                color: Colors.green,
              ),
              title: const Text("Distribuir tareas"),
              subtitle: const Text(
                "Asignar responsabilidades claras a cada integrante.",
              ),
            ),
          ),

          Card(
            margin: const EdgeInsets.all(10),
            child: ListTile(
              leading: const Icon(
                Icons.calendar_month,
                color: Colors.purple,
              ),
              title: const Text("Revisar cronograma"),
              subtitle: const Text(
                "Verificar las fechas de entrega establecidas.",
              ),
            ),
          ),

          Card(
            margin: const EdgeInsets.all(10),
            child: ListTile(
              leading: const Icon(
                Icons.update,
                color: Colors.teal,
              ),
              title: const Text("Registrar avances"),
              subtitle: const Text(
                "Actualizar semanalmente el progreso del proyecto.",
              ),
            ),
          ),

          Card(
            margin: const EdgeInsets.all(10),
            child: ListTile(
              leading: const Icon(
                Icons.lightbulb,
                color: Colors.amber,
              ),
              title: const Text("Resolver problemas rápidamente"),
              subtitle: const Text(
                "Buscar soluciones oportunamente para evitar retrasos.",
              ),
            ),
          ),

          const SizedBox(height: 20),

          ElevatedButton.icon(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back),
            label: const Text("Regresar al inicio"),
          ),
        ],
      ),
    );
  }
}