import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false,
      title: 'Biblioteca Personal',
      theme: ThemeData(
        primarySwatch: Colors.brown,
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFA0826D),
        ),
      ),
      home: const HomePage(),
    );
  }
}
class Libro {
  final String titulo;
  final String autor;
  final String categoria;
  final int anio;
  bool disponible;

  Libro({
    required this.titulo,
    required this.autor,
    required this.categoria,
    required this.anio,
    this.disponible = true,
  });
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Biblioteca Personal')),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
                colors: [const Color(0xFFF5E6D3), const Color(0xFFEADCC6)],
          ),
        ),
        child: Center(
          child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.library_books, size: 80, color: Color(0xFF8B6F47)),
            const SizedBox(height: 20),
            const Text(
              'Bienvenido a tu Biblioteca',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF5D4A3A)),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ListaLibrosPage(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFA0826D),
                foregroundColor: Colors.white,
              ),
              child: const Text('Ver Lista de Libros'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const FormularioLibroPage(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFA0826D),
                foregroundColor: Colors.white,
              ),
              child: const Text('Agregar Nuevo Libro'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const NormasPage(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFA0826D),
                foregroundColor: Colors.white,
              ),
              child: const Text('Normas de Préstamo'),
            ),
          ],
        ),
        ),
      ),
    );
  }
}

class ListaLibrosPage extends StatefulWidget {
  const ListaLibrosPage({Key? key}) : super(key: key);

  @override
  State<ListaLibrosPage> createState() => _ListaLibrosPageState();
}

class _ListaLibrosPageState extends State<ListaLibrosPage> {
  final List<Libro> libros = [
    Libro(
      titulo: 'Apocalipsis',
      autor: 'Mario Mendoza',
      categoria: 'Novela',
      anio: 2011,
      disponible: true,
    ),
    Libro(
      titulo: '100 años de soledad',
      autor: 'Gabriel García Márquez',
      categoria: 'Realismo Mágico',
      anio: 1967,
      disponible: false,
    ),
    Libro(
      titulo: 'La casa de los espíritus',
      autor: 'Isabel Allende',
      categoria: 'Novela',
      anio: 1982,
      disponible: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lista de Libros')),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [const Color(0xFFF5E6D3), const Color(0xFFEADCC6)],
          ),
        ),
        child: ListView.builder(
          padding: const EdgeInsets.all(10),
        itemCount: libros.length,
        itemBuilder: (context, index) {
          final libro = libros[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8),
            child: ListTile(
              leading: const Icon(Icons.book),
              title: Text(libro.titulo, style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 5),
                  Text('Autor: ${libro.autor}'),
                  Text('Categoría: ${libro.categoria}'),
                  Text('Año: ${libro.anio}'),
                ],
              ),
              trailing: Text(
                libro.disponible ? 'Disponible' : 'Prestado',
                style: TextStyle(
                  color: libro.disponible ? Colors.green : Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
              isThreeLine: true,
            ),
          );
        },
        ),
      ),
    );
  }
}
class FormularioLibroPage extends StatefulWidget {
  const FormularioLibroPage({Key? key}) : super(key: key);

  @override
  State<FormularioLibroPage> createState() => _FormularioLibroPageState();
}

class _FormularioLibroPageState extends State<FormularioLibroPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _tituloController = TextEditingController();
  final TextEditingController _autorController = TextEditingController();
  final TextEditingController _anioController = TextEditingController();
  String? _categoriaSeleccionada;

  final List<String> _categorias = [
    'Novela',
    'Ciencia Ficción',
    'Fantasía',
    'Misterio',
    'Romance',
    'Autoayuda',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Registrar Nuevo Libro')),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [const Color(0xFFF5E6D3), const Color(0xFFEADCC6)],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
          key: _formKey,
          child: ListView(
            children: [
              const Text(
                'Formulario de Registro',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              // Título
              TextFormField(
                controller: _tituloController,
                decoration: const InputDecoration(
                  labelText: 'Título del Libro *',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'El título no puede estar vacío';
                  }
                  if (value.length < 3) {
                    return 'El título debe tener mínimo 3 caracteres';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15),
              // Autor
              TextFormField(
                controller: _autorController,
                decoration: const InputDecoration(
                  labelText: 'Autor *',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'El autor no puede estar vacío';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15),
              // Categoría
              DropdownButtonFormField<String>(
                value: _categoriaSeleccionada,
                decoration: const InputDecoration(
                  labelText: 'Categoría *',
                  border: OutlineInputBorder(),
                ),
                items: _categorias.map((categoria) {
                  return DropdownMenuItem(
                    value: categoria,
                    child: Text(categoria),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _categoriaSeleccionada = value;
                  });
                },
                validator: (value) {
                  if (value == null) {
                    return 'Debe seleccionar una categoría';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15),
              // Año
              TextFormField(
                controller: _anioController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Año de Publicación *',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'El año no puede estar vacío';
                  }
                  if (value.length != 4 || int.tryParse(value) == null) {
                    return 'El año debe tener 4 dígitos';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 30),
              // Botones
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(' Libro registrado'),
                              backgroundColor: Colors.green,
                            ),
                          );
                          _limpiarFormulario();
                        }
                      },
                      child: const Text('Guardar'),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey,
                      ),
                      child: const Text('Cancelar'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        ),
      ),
    );
  }

  void _limpiarFormulario() {
    _tituloController.clear();
    _autorController.clear();
    _anioController.clear();
    setState(() {
      _categoriaSeleccionada = null;
    });
  }

  @override
  void dispose() {
    _tituloController.dispose();
    _autorController.dispose();
    _anioController.dispose();
    super.dispose();
  }
}
class NormasPage extends StatelessWidget {
  const NormasPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Normas de Préstamo')),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [const Color(0xFFF5E6D3), const Color(0xFFEADCC6)],
          ),
        ),
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
          const Text(
            'Normas de Préstamo',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF5D4A3A)),
          ),
          const SizedBox(height: 20),
          _buildSeccion(
            '1. Período de Préstamo',
            'Los libros se pueden prestar por 20 días.\nSe puede solicitar una prórroga de 7 días adicionales.',
          ),
          _buildSeccion(
            '2. Requisitos',
            'Máximo 3 libros simultáneamente.\nNo puede tener libros atrasados.',
          ),
          _buildSeccion(
            '3. Devoluciones',
            'Los libros deben devolverse en la fecha acordada.\nLibros dañados generan cargos extras.',
          ),
          _buildSeccion(
            '4. Sanciones',
            'Atraso: \$1.000 por día.\nLibro perdido: \$50.000.',
          ),
          _buildSeccion(
            '5. Derechos del Usuario',
            'Acceso a todo el catálogo.\nSolicitar nuevos libros.\nApelación sobre sanciones.',
          ),
        ],
        ),
      ),
    );
  }

  Widget _buildSeccion(String titulo, String contenido) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          titulo,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFFA0826D)),
        ),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.85),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: const Color(0xFFC8B8A8), width: 1),
          ),
          child: Text(contenido),
        ),
        const SizedBox(height: 15),
      ],
    );
  }
}