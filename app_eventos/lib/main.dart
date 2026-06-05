import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: const Color(0xFF0F766E),
      brightness: Brightness.light,
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Eventos Académicos',
      theme: ThemeData(
        colorScheme: colorScheme,
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF5F7FA),
        appBarTheme: const AppBarTheme(
          centerTitle: false,
          backgroundColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
        ),
        cardTheme: CardThemeData(
          color: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        ),
      ),
      home: const MainMenuPage(),
    );
  }
}

class AcademicEvent {
  const AcademicEvent({
    required this.name,
    required this.date,
    required this.place,
    required this.duration,
    required this.type,
    required this.description,
  });

  final String name;
  final String date;
  final String place;
  final String duration;
  final String type;
  final String description;
}

final List<AcademicEvent> academicEvents = [
  const AcademicEvent(
    name: 'Semillero de Futbol',
    date: '12 de junio de 2026',
    place: 'cancha futbol',
    duration: '2 horas',
    type: 'Seminario',
    description:
        'Espacio para demostrar tus habilidades en el deporte.',
  ),
  const AcademicEvent(
    name: 'Taller de Inteligencia Artificial',
    date: '20 de junio de 2026',
    place: 'Laboratorio de Computación',
    duration: '3 horas',
    type: 'Taller',
    description:
        'Actividad práctica para fortalecer tus conocimientos en inteligencia artificial.',
  ),
  const AcademicEvent(
    name: 'Semillero de teatro',
    date: '1 de julio de 2026',
    place: 'auditorio',
    duration: '1.5 horas',
    type: 'Taller',
    description:
        'Espacio para desarrollar habilidades en actuación y dirección teatral.',
  ),
];

class MainMenuPage extends StatelessWidget {
  const MainMenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFFE7F7F4), Color(0xFFF7FAFC), Color(0xFFEFF6FF)],
          ),
        ),
        child: SafeArea(
          child: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: const Color(0xFF0F766E),
                  borderRadius: BorderRadius.circular(28),
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Eventos académicos',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 12),
                    Text(
                      'Consulta la programación institucional.',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Wrap(
                spacing: 16,
                runSpacing: 16,
                children: [
                  _MenuCard(
                    title: 'Ver eventos',
                    icon: Icons.event_note,
                    color: const Color(0xFF115E59),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => const EventListPage(),
                        ),
                      );
                    },
                  ),
                  _MenuCard(
                    title: 'Inscribirme',
                    icon: Icons.app_registration,
                    color: const Color(0xFF1D4ED8),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => const RegistrationPage(),
                        ),
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(height: 28),
              const Text(
                'Próximos eventos',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 12),
              ...academicEvents.map(
                (event) => Padding(
                  padding: const EdgeInsets.only(bottom: 14),
                  child: _AcademicEventCard(
                    event: event,
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => EventDetailPage(event: event),
                        ),
                      );
                    },
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

class _MenuCard extends StatelessWidget {
  const _MenuCard({
    required this.title,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  final String title;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;

    return SizedBox(
      width: width >= 600 ? (width - 52) / 2 : double.infinity,
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        child: InkWell(
          borderRadius: BorderRadius.circular(22),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Icon(icon, color: color),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Icon(Icons.chevron_right, color: color),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class EventListPage extends StatelessWidget {
  const EventListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de eventos'),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: academicEvents.length,
        separatorBuilder: (_, __) => const SizedBox(height: 14),
        itemBuilder: (context, index) {
          final event = academicEvents[index];
          return _AcademicEventCard(
            event: event,
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => EventDetailPage(event: event),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class _AcademicEventCard extends StatelessWidget {
  const _AcademicEventCard({required this.event, required this.onTap});

  final AcademicEvent event;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(24),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      event.name,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  const Icon(Icons.arrow_forward_ios, size: 16),
                ],
              ),
              const SizedBox(height: 12),
              _InfoRow(icon: Icons.calendar_month, label: event.date),
              _InfoRow(icon: Icons.place, label: event.place),
              _InfoRow(icon: Icons.schedule, label: event.duration),
              _InfoRow(icon: Icons.category, label: event.type),
            ],
          ),
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Row(
        children: [
          Icon(icon, size: 18, color: Theme.of(context).colorScheme.primary),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              label,
              style: const TextStyle(fontSize: 15),
            ),
          ),
        ],
      ),
    );
  }
}

class EventDetailPage extends StatelessWidget {
  const EventDetailPage({super.key, required this.event});

  final AcademicEvent event;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalle del evento'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF0F766E), Color(0xFF1D4ED8)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(28),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Evento académico',
                  style: TextStyle(color: Colors.white70, fontSize: 14),
                ),
                const SizedBox(height: 8),
                Text(
                  event.name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                _DetailChip(text: event.type),
              ],
            ),
          ),
          const SizedBox(height: 20),
          _DetailSection(
            title: 'Información general',
            children: [
              _InfoRow(icon: Icons.calendar_month, label: event.date),
              _InfoRow(icon: Icons.place, label: event.place),
              _InfoRow(icon: Icons.schedule, label: event.duration),
              _InfoRow(icon: Icons.category, label: event.type),
            ],
          ),
          const SizedBox(height: 20),
          _DetailSection(
            title: 'Descripción',
            children: [
              Text(
                event.description,
                style: const TextStyle(fontSize: 15, height: 1.5),
              ),
            ],
          ),
          const SizedBox(height: 24),
          FilledButton.icon(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => RegistrationPage(eventName: event.name),
                ),
              );
            },
            icon: const Icon(Icons.app_registration),
            label: const Text('Inscribirse al evento'),
          ),
        ],
      ),
    );
  }
}

class _DetailChip extends StatelessWidget {
  const _DetailChip({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(text),
      backgroundColor: Colors.white.withOpacity(0.14),
      labelStyle: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w600,
      ),
      side: BorderSide.none,
    );
  }
}

class _DetailSection extends StatelessWidget {
  const _DetailSection({required this.title, required this.children});

  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 12),
          ...children,
        ],
      ),
    );
  }
}

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key, this.eventName});

  final String? eventName;

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _participantNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _documentController = TextEditingController();

  final List<String> _programs = const [
    'Analisis y desarrollo de software',
    'Administración de empresas',
    'Produccion Pecuaria',
    'Comercio exterior',
    'Recursos humanos',
  ];

  String? _selectedProgram;

  @override
  void initState() {
    super.initState();
    _selectedProgram = _programs.first;
  }

  @override
  void dispose() {
    _participantNameController.dispose();
    _emailController.dispose();
    _documentController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Inscripción exitosa${widget.eventName != null ? ' a ${widget.eventName}' : ''}.',
        ),
      ),
    );

    _participantNameController.clear();
    _emailController.clear();
    _documentController.clear();
    setState(() {
      _selectedProgram = _programs.first;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Formulario de inscripción'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          if (widget.eventName != null) ...[
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: const Color(0xFFE0F2FE),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                'Inscripción para: ${widget.eventName}',
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
            const SizedBox(height: 16),
          ],
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
            ),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _participantNameController,
                    decoration: const InputDecoration(
                      labelText: 'Nombre del participante',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'El nombre es obligatorio';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      labelText: 'Correo',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      final email = value?.trim() ?? '';
                      if (email.isEmpty) {
                        return 'El correo es obligatorio';
                      }
                      if (!email.contains('@') || !email.contains('.')) {
                        return 'Ingrese un correo válido';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _documentController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Documento',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if ((value ?? '').trim().length < 6) {
                        return 'El documento debe tener mínimo 6 caracteres';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    value: _selectedProgram,
                    decoration: const InputDecoration(
                      labelText: 'Programa de formación',
                      border: OutlineInputBorder(),
                    ),
                    items: _programs
                        .map(
                          (program) => DropdownMenuItem<String>(
                            value: program,
                            child: Text(program),
                          ),
                        )
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedProgram = value;
                      });
                    },
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      onPressed: _submitForm,
                      child: const Text('Enviar inscripción'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}