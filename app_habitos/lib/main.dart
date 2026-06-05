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
			title: 'Hábitos Saludables',
			theme: ThemeData(
				useMaterial3: true,
				colorScheme: ColorScheme.fromSeed(
						seedColor: const Color(0xFF2563EB),
					brightness: Brightness.light,
				),
					scaffoldBackgroundColor: const Color(0xFFF3F8FF),
				appBarTheme: const AppBarTheme(
					centerTitle: false,
					backgroundColor: Colors.transparent,
					surfaceTintColor: Colors.transparent,
				),
				cardTheme: CardThemeData(
					elevation: 0,
					color: Colors.white,
					shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
				),
			),
			home: const HealthyHabitsApp(),
		);
	}
}

class HealthyHabitsApp extends StatefulWidget {
	const HealthyHabitsApp({super.key});

	@override
	State<HealthyHabitsApp> createState() => _HealthyHabitsAppState();
}

class _HealthyHabitsAppState extends State<HealthyHabitsApp> {
	int _currentIndex = 0;

	final List<Habit> _habits = [
		const Habit(
			name: 'Caminar al aire libre',
			benefit: 'Ayuda a despejar la mente y activa la circulación.',
			frequency: '20 a 30 minutos diarios',
			icon: Icons.park_rounded,
		),
		const Habit(
			name: 'Comer una fruta',
			benefit: 'Aporta vitaminas, fibra y energía natural.',
			frequency: 'Todos los días',
			icon: Icons.apple_rounded,
		),
		const Habit(
			name: 'Respirar profundo',
			benefit: 'Reduce el estrés y mejora la concentración.',
			frequency: '3 veces al día',
			icon: Icons.air_rounded,
		),
		const Habit(
			name: 'Dormir temprano',
			benefit: 'Favorece la recuperación física y mental.',
			frequency: '7 a 8 horas por noche',
			icon: Icons.nightlight_round,
		),
	];

	Commitment? _lastCommitment;

	void _addHabit(Habit habit) {
		setState(() {
			_habits.insert(0, habit);
			_currentIndex = 1;
		});
	}

	void _removeHabit(int index) {
		setState(() {
			_habits.removeAt(index);
		});
	}

	void _saveCommitment(Commitment commitment) {
		setState(() {
			_lastCommitment = commitment;
			_currentIndex = 2;
		});
	}

	@override
	Widget build(BuildContext context) {
		final pages = <Widget>[
			WelcomeScreen(
				onExploreHabits: () => setState(() => _currentIndex = 1),
			),
			HabitsScreen(
				habits: _habits,
				onAddHabit: _addHabit,
				onDeleteHabit: _removeHabit,
			),
			CommitmentScreen(
				onSubmit: _saveCommitment,
				lastCommitment: _lastCommitment,
			),
			const TipsScreen(),
		];

		return Scaffold(
			extendBody: true,
			body: SafeArea(
				child: AnimatedSwitcher(
					duration: const Duration(milliseconds: 300),
					child: pages[_currentIndex],
				),
			),
			bottomNavigationBar: NavigationBar(
				selectedIndex: _currentIndex,
				onDestinationSelected: (index) => setState(() => _currentIndex = index),
				destinations: const [
					NavigationDestination(icon: Icon(Icons.home_rounded), label: 'Inicio'),
					NavigationDestination(icon: Icon(Icons.fitness_center_rounded), label: 'Hábitos'),
					NavigationDestination(icon: Icon(Icons.edit_note_rounded), label: 'Compromiso'),
					NavigationDestination(icon: Icon(Icons.lightbulb_rounded), label: 'Consejos'),
				],
			),
		);
	}
}

class WelcomeScreen extends StatelessWidget {
	const WelcomeScreen({super.key, required this.onExploreHabits});

	final VoidCallback onExploreHabits;

	@override
	Widget build(BuildContext context) {
		return Container(
			decoration: const BoxDecoration(
				gradient: LinearGradient(
					colors: [Color(0xFFEAF2FF), Color(0xFFF8FBFF), Color(0xFFD9E8FF)],
					begin: Alignment.topLeft,
					end: Alignment.bottomRight,
				),
			),
			child: ListView(
				padding: const EdgeInsets.all(20),
				children: [
					const SizedBox(height: 8),
					_HeroCard(onExploreHabits: onExploreHabits),
					const SizedBox(height: 20),

					const SizedBox(height: 12),
					const _InfoCard(
						icon: Icons.school_rounded,
						title: 'Guía de aprendizaje Flutter',
						description: 'Esta aplicación organiza hábitos saludables, registro personal y consejos prácticos en una sola experiencia visual.',
					),
					const SizedBox(height: 12),
					const _InfoCard(
						icon: Icons.check_circle_rounded,
						title: 'Objetivo',
						description: 'Promover rutinas sostenibles con una interfaz clara, dinámica y motivadora.',
					),
				],
			),
		);
	}
}

class _HeroCard extends StatelessWidget {
	const _HeroCard({required this.onExploreHabits});

	final VoidCallback onExploreHabits;

	@override
	Widget build(BuildContext context) {
		final colorScheme = Theme.of(context).colorScheme;
		return Container(
			padding: const EdgeInsets.all(24),
			decoration: BoxDecoration(
				gradient: LinearGradient(
					colors: [colorScheme.primary, const Color(0xFF14B8A6)],
					begin: Alignment.topLeft,
					end: Alignment.bottomRight,
				),
				borderRadius: BorderRadius.circular(32),
				boxShadow: [
					BoxShadow(
						color: colorScheme.primary.withValues(alpha: 0.24),
						blurRadius: 24,
						offset: const Offset(0, 10),
					),
				],
			),
			child: Column(
				crossAxisAlignment: CrossAxisAlignment.start,
				children: [
					const Icon(Icons.energy_savings_leaf_rounded, color: Colors.white, size: 42),
					const SizedBox(height: 18),
					const Text(
						'Hábitos saludables',
						style: TextStyle(
							color: Colors.white,
							fontSize: 30,
							fontWeight: FontWeight.w800,
						),
					),
					const SizedBox(height: 10),
					const Text(
						'Una app visual para construir rutinas positivas, compromisos personales y consejos que sí se pueden sostener.',
						style: TextStyle(color: Colors.white, height: 1.45),
					),
					const SizedBox(height: 20),
					FilledButton.tonal(
						onPressed: onExploreHabits,
						style: FilledButton.styleFrom(
							backgroundColor: Colors.white,
							foregroundColor: colorScheme.primary,
							padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
						),
						child: const Text('Explorar hábitos'),
					),
				],
			),
		);
	}
}

class SectionTitle extends StatelessWidget {
	const SectionTitle({super.key, required this.title, required this.subtitle});

	final String title;
	final String subtitle;

	@override
	Widget build(BuildContext context) {
		return Column(
			crossAxisAlignment: CrossAxisAlignment.start,
			children: [
				Text(
					title,
					style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
				),
				const SizedBox(height: 6),
				Text(
					subtitle,
					style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.black54, height: 1.4),
				),
			],
		);
	}
}

class _InfoCard extends StatelessWidget {
	const _InfoCard({required this.icon, required this.title, required this.description});

	final IconData icon;
	final String title;
	final String description;

	@override
	Widget build(BuildContext context) {
		return Card(
			child: Padding(
				padding: const EdgeInsets.all(18),
				child: Row(
					crossAxisAlignment: CrossAxisAlignment.start,
					children: [
						Container(
							padding: const EdgeInsets.all(12),
							decoration: BoxDecoration(
								color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.10),
								borderRadius: BorderRadius.circular(16),
							),
							child: Icon(icon, color: Theme.of(context).colorScheme.primary),
						),
						const SizedBox(width: 14),
						Expanded(
							child: Column(
								crossAxisAlignment: CrossAxisAlignment.start,
								children: [
									Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
									const SizedBox(height: 6),
									Text(description, style: const TextStyle(height: 1.45, color: Colors.black87)),
								],
							),
						),
					],
				),
			),
		);
	}
}

class HabitsScreen extends StatelessWidget {
	const HabitsScreen({
		super.key,
		required this.habits,
		required this.onAddHabit,
		required this.onDeleteHabit,
	});

	final List<Habit> habits;
	final ValueChanged<Habit> onAddHabit;
	final ValueChanged<int> onDeleteHabit;

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			backgroundColor: Colors.transparent,
			floatingActionButton: FloatingActionButton.extended(
				onPressed: () => _showHabitSheet(context),
				icon: const Icon(Icons.add_rounded),
				label: const Text('Nuevo hábito'),
			),
			body: ListView(
				padding: const EdgeInsets.all(20),
				children: [
					const SectionTitle(
						title: 'Lista dinámica de hábitos',
						subtitle: 'Agrega o elimina hábitos para personalizar tu rutina saludable.',
					),
					const SizedBox(height: 16),
					if (habits.isEmpty)
						const _EmptyState()
					else
						...List.generate(habits.length, (index) {
							final habit = habits[index];
							return Padding(
								padding: const EdgeInsets.only(bottom: 12),
								child: Dismissible(
									key: ValueKey('${habit.name}-$index'),
									direction: DismissDirection.endToStart,
									background: Container(
										alignment: Alignment.centerRight,
										padding: const EdgeInsets.symmetric(horizontal: 20),
										decoration: BoxDecoration(
											color: Colors.red.withValues(alpha: 0.12),
											borderRadius: BorderRadius.circular(24),
										),
										child: const Icon(Icons.delete_rounded, color: Colors.red),
									),
									onDismissed: (_) => onDeleteHabit(index),
									child: HabitCard(habit: habit),
								),
							);
						}),
				],
			),
		);
	}

	void _showHabitSheet(BuildContext context) {
		showModalBottomSheet<void>(
			context: context,
			isScrollControlled: true,
			backgroundColor: Colors.transparent,
			builder: (context) => _HabitFormSheet(onSave: onAddHabit),
		);
	}
}

class _EmptyState extends StatelessWidget {
	const _EmptyState();

	@override
	Widget build(BuildContext context) {
		return Card(
			child: Padding(
				padding: const EdgeInsets.all(24),
				child: Column(
					children: [
						Icon(Icons.inbox_rounded, size: 48, color: Theme.of(context).colorScheme.primary),
						const SizedBox(height: 12),
						const Text('Todavía no hay hábitos guardados'),
						const SizedBox(height: 6),
						const Text('Usa el botón para crear uno nuevo.', textAlign: TextAlign.center),
					],
				),
			),
		);
	}
}

class HabitCard extends StatelessWidget {
	const HabitCard({super.key, required this.habit});

	final Habit habit;

	@override
	Widget build(BuildContext context) {
		final colorScheme = Theme.of(context).colorScheme;
		return Card(
			child: Padding(
				padding: const EdgeInsets.all(18),
				child: Row(
					crossAxisAlignment: CrossAxisAlignment.start,
					children: [
						Container(
							padding: const EdgeInsets.all(14),
							decoration: BoxDecoration(
								color: colorScheme.primary.withValues(alpha: 0.10),
								borderRadius: BorderRadius.circular(18),
							),
							child: Icon(habit.icon, color: colorScheme.primary),
						),
						const SizedBox(width: 14),
						Expanded(
							child: Column(
								crossAxisAlignment: CrossAxisAlignment.start,
								children: [
									Text(habit.name, style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w800)),
									const SizedBox(height: 6),
									Text(habit.benefit, style: const TextStyle(height: 1.45, color: Colors.black87)),
									const SizedBox(height: 10),
									Wrap(
										spacing: 8,
										runSpacing: 8,
										children: [
											_Pill(label: habit.frequency, icon: Icons.schedule_rounded),
										],
									),
								],
							),
						),
					],
				),
			),
		);
	}
}

class _Pill extends StatelessWidget {
	const _Pill({required this.label, required this.icon});

	final String label;
	final IconData icon;

	@override
	Widget build(BuildContext context) {
		return Chip(
			avatar: Icon(icon, size: 18, color: Theme.of(context).colorScheme.primary),
			label: Text(label),
			side: BorderSide(color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.16)),
			backgroundColor: Theme.of(context).colorScheme.primary.withValues(alpha: 0.08),
		);
	}
}

class _HabitFormSheet extends StatefulWidget {
	const _HabitFormSheet({required this.onSave});

	final ValueChanged<Habit> onSave;

	@override
	State<_HabitFormSheet> createState() => _HabitFormSheetState();
}

class _HabitFormSheetState extends State<_HabitFormSheet> {
	final _formKey = GlobalKey<FormState>();
	final _nameController = TextEditingController();
	final _benefitController = TextEditingController();
	final _frequencyController = TextEditingController();

	IconData _selectedIcon = Icons.favorite_rounded;

	@override
	void dispose() {
		_nameController.dispose();
		_benefitController.dispose();
		_frequencyController.dispose();
		super.dispose();
	}

	@override
	Widget build(BuildContext context) {
		final bottomInset = MediaQuery.of(context).viewInsets.bottom;
		return Padding(
			padding: EdgeInsets.only(bottom: bottomInset),
			child: Container(
				decoration: const BoxDecoration(
					color: Colors.white,
					borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
				),
				child: SingleChildScrollView(
					padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
					child: Form(
						key: _formKey,
						child: Column(
							mainAxisSize: MainAxisSize.min,
							crossAxisAlignment: CrossAxisAlignment.start,
							children: [
								Center(
									child: Container(
										width: 48,
										height: 5,
										decoration: BoxDecoration(
											color: Colors.black12,
											borderRadius: BorderRadius.circular(999),
										),
									),
								),
								const SizedBox(height: 16),
								Text('Nuevo hábito', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800)),
								const SizedBox(height: 6),
								const Text('Completa los campos para guardarlo en la lista dinámica.'),
								const SizedBox(height: 18),
								TextFormField(
									controller: _nameController,
									decoration: const InputDecoration(labelText: 'Nombre del hábito'),
									validator: _requiredValidator,
								),
								const SizedBox(height: 12),
								TextFormField(
									controller: _benefitController,
									decoration: const InputDecoration(labelText: 'Beneficio'),
									validator: _requiredValidator,
								),
								const SizedBox(height: 12),
								TextFormField(
									controller: _frequencyController,
									decoration: const InputDecoration(labelText: 'Frecuencia recomendada'),
									validator: _requiredValidator,
								),
								const SizedBox(height: 12),
								DropdownButtonFormField<IconData>(
									value: _selectedIcon,
									decoration: const InputDecoration(labelText: 'Ícono'),
									items: const [
										DropdownMenuItem(value: Icons.favorite_rounded, child: Text('Corazón')),
										DropdownMenuItem(value: Icons.water_drop_rounded, child: Text('Agua')),
										DropdownMenuItem(value: Icons.directions_walk_rounded, child: Text('Caminar')),
										DropdownMenuItem(value: Icons.nightlight_round, child: Text('Descanso')),
										DropdownMenuItem(value: Icons.restaurant_rounded, child: Text('Alimentación')),
									],
									onChanged: (value) {
										if (value != null) {
											setState(() => _selectedIcon = value);
										}
									},
								),
								const SizedBox(height: 20),
								SizedBox(
									width: double.infinity,
									child: FilledButton(
										onPressed: _submit,
										child: const Text('Guardar hábito'),
									),
								),
							],
						),
					),
				),
			),
		);
	}

	String? _requiredValidator(String? value) {
		if (value == null || value.trim().isEmpty) {
			return 'Este campo es obligatorio';
		}
		return null;
	}

	void _submit() {
		if (!_formKey.currentState!.validate()) {
			return;
		}
		widget.onSave(
			Habit(
				name: _nameController.text.trim(),
				benefit: _benefitController.text.trim(),
				frequency: _frequencyController.text.trim(),
				icon: _selectedIcon,
			),
		);
		Navigator.of(context).pop();
		ScaffoldMessenger.of(context).showSnackBar(
			const SnackBar(content: Text('Hábito agregado correctamente')),
		);
	}
}

class CommitmentScreen extends StatefulWidget {
	const CommitmentScreen({super.key, required this.onSubmit, required this.lastCommitment});

	final ValueChanged<Commitment> onSubmit;
	final Commitment? lastCommitment;

	@override
	State<CommitmentScreen> createState() => _CommitmentScreenState();
}

class _CommitmentScreenState extends State<CommitmentScreen> {
	final _formKey = GlobalKey<FormState>();
	final _nameController = TextEditingController();
	final _habitController = TextEditingController();
	final _goalController = TextEditingController();
	final _reasonController = TextEditingController();

	@override
	void dispose() {
		_nameController.dispose();
		_habitController.dispose();
		_goalController.dispose();
		_reasonController.dispose();
		super.dispose();
	}

	@override
	Widget build(BuildContext context) {
		return ListView(
			padding: const EdgeInsets.all(20),
			children: [
				const SectionTitle(
					title: 'Formulario de compromiso personal',
					subtitle: 'Registra un objetivo concreto para sostener tu cambio semanal.',
				),
				const SizedBox(height: 16),
				Card(
					child: Padding(
						padding: const EdgeInsets.all(18),
						child: Form(
							key: _formKey,
							child: Column(
								children: [
									TextFormField(
										controller: _nameController,
										decoration: const InputDecoration(labelText: 'Nombre del usuario'),
										validator: _requiredValidator,
									),
									const SizedBox(height: 12),
									TextFormField(
										controller: _habitController,
										decoration: const InputDecoration(labelText: 'Hábito que desea mejorar'),
										validator: _requiredValidator,
									),
									const SizedBox(height: 12),
									TextFormField(
										controller: _goalController,
										decoration: const InputDecoration(labelText: 'Meta semanal'),
										validator: _goalValidator,
									),
									const SizedBox(height: 12),
									TextFormField(
										controller: _reasonController,
										maxLines: 3,
										decoration: const InputDecoration(labelText: 'Motivo personal'),
										validator: _reasonValidator,
									),
									const SizedBox(height: 20),
									SizedBox(
										width: double.infinity,
										child: FilledButton(
											onPressed: _submit,
											child: const Text('Guardar compromiso'),
										),
									),
								],
							),
						),
					),
				),
				if (widget.lastCommitment != null) ...[
					const SizedBox(height: 16),
					_CommitmentSummary(commitment: widget.lastCommitment!),
				],
			],
		);
	}

	String? _requiredValidator(String? value) {
		if (value == null || value.trim().isEmpty) {
			return 'Este campo es obligatorio';
		}
		return null;
	}

	String? _goalValidator(String? value) {
		if (value == null || value.trim().isEmpty) {
			return 'Este campo es obligatorio';
		}
		if (value.trim().length < 5) {
			return 'La meta debe tener mínimo 5 caracteres';
		}
		return null;
	}

	String? _reasonValidator(String? value) {
		if (value == null || value.trim().isEmpty) {
			return 'Este campo es obligatorio';
		}
		if (value.trim().length < 10) {
			return 'El motivo debe tener mínimo 10 caracteres';
		}
		return null;
	}

	void _submit() {
		if (!_formKey.currentState!.validate()) {
			return;
		}
		widget.onSubmit(
			Commitment(
				userName: _nameController.text.trim(),
				habit: _habitController.text.trim(),
				weeklyGoal: _goalController.text.trim(),
				reason: _reasonController.text.trim(),
			),
		);
		ScaffoldMessenger.of(context).showSnackBar(
			const SnackBar(content: Text('Compromiso guardado')),
		);
	}
}

class _CommitmentSummary extends StatelessWidget {
	const _CommitmentSummary({required this.commitment});

	final Commitment commitment;

	@override
	Widget build(BuildContext context) {
		return Card(
			child: Padding(
				padding: const EdgeInsets.all(18),
				child: Column(
					crossAxisAlignment: CrossAxisAlignment.start,
					children: [
						Text('Último compromiso', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800)),
						const SizedBox(height: 12),
						_SummaryRow(label: 'Usuario', value: commitment.userName),
						_SummaryRow(label: 'Hábito', value: commitment.habit),
						_SummaryRow(label: 'Meta semanal', value: commitment.weeklyGoal),
						_SummaryRow(label: 'Motivo', value: commitment.reason),
					],
				),
			),
		);
	}
}

class _SummaryRow extends StatelessWidget {
	const _SummaryRow({required this.label, required this.value});

	final String label;
	final String value;

	@override
	Widget build(BuildContext context) {
		return Padding(
			padding: const EdgeInsets.only(bottom: 10),
			child: Column(
				crossAxisAlignment: CrossAxisAlignment.start,
				children: [
					Text(label, style: const TextStyle(fontWeight: FontWeight.w700)),
					const SizedBox(height: 2),
					Text(value, style: const TextStyle(color: Colors.black87)),
				],
			),
		);
	}
}

class TipsScreen extends StatelessWidget {
	const TipsScreen({super.key});

	@override
	Widget build(BuildContext context) {
		final tips = [
			(
				icon: Icons.local_drink_rounded,
				title: 'Hidratación constante',
				description: 'Ten agua cerca para recordar tomarla durante el día.',
			),
			(
				icon: Icons.restaurant_rounded,
				title: 'Platos equilibrados',
				description: 'Incluye proteína, frutas, verduras y suficiente energía.',
			),
			(
				icon: Icons.self_improvement_rounded,
				title: 'Movimiento diario',
				description: 'Activa tu cuerpo con caminatas, estiramientos o pausas activas.',
			),
			(
				icon: Icons.bedtime_rounded,
				title: 'Sueño reparador',
				description: 'Respeta horarios estables y reduce pantallas antes de dormir.',
			),
		];

		return ListView(
			padding: const EdgeInsets.all(20),
			children: [
				const SectionTitle(
					title: 'Pantalla de consejos',
					subtitle: 'Pequeñas acciones sostenibles para mejorar tu bienestar cada semana.',
				),
				const SizedBox(height: 16),
				...tips.map(
					(tip) => Padding(
						padding: const EdgeInsets.only(bottom: 12),
						child: Card(
							child: ListTile(
								contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
								leading: CircleAvatar(
									backgroundColor: Theme.of(context).colorScheme.primary.withValues(alpha: 0.12),
									child: Icon(tip.icon, color: Theme.of(context).colorScheme.primary),
								),
								title: Text(tip.title, style: const TextStyle(fontWeight: FontWeight.w700)),
								subtitle: Text(tip.description),
							),
						),
					),
				),
			],
		);
	}
}

class Habit {
	const Habit({required this.name, required this.benefit, required this.frequency, required this.icon});

	final String name;
	final String benefit;
	final String frequency;
	final IconData icon;
}

class Commitment {
	const Commitment({required this.userName, required this.habit, required this.weeklyGoal, required this.reason});

	final String userName;
	final String habit;
	final String weeklyGoal;
	final String reason;
}