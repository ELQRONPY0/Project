import 'package:flutter/material.dart';

class ExercisesPage extends StatefulWidget {
  final String tumorType; // نوع الورم بناءً على التشخيص

  const ExercisesPage({super.key, required this.tumorType});

  @override
  State<ExercisesPage> createState() => _ExercisesPageState();
}

class _ExercisesPageState extends State<ExercisesPage> {
  bool _isLoading = false;
  String? _errorMessage;
  List<Map<String, String>> _exercises = [];

  @override
  void initState() {
    super.initState();
    _loadMockData(); // تحميل بيانات وهمية عند بدء الصفحة
  }

  Future<void> _loadMockData() async {
    setState(() {
      _isLoading = true; // بدء التحميل
      _errorMessage = null;
    });

    // بيانات وهمية لاختبار واجهة المستخدم
    await Future.delayed(const Duration(seconds: 1)); // محاكاة وقت تحميل
    setState(() {
      _exercises = [
        {
          'name': 'Breathing Exercise',
          'description': 'A simple breathing exercise to relax your body.',
          // 'image': 'assets/images/breathing_exercise.gif',
        },
        {
          'name': 'Light Stretching',
          'description': 'Stretch your muscles gently to improve flexibility.',
          // 'image': 'assets/images/light_stretching.gif',
        },
        {
          'name': 'Walking Exercise',
          'description': 'Take a short walk to improve circulation.',
          // 'image': 'assets/images/walking_exercise.gif',
        },
        {
          'name': 'Meditation',
          'description': 'Spend 10 minutes meditating to reduce stress.',
          // 'image': 'assets/images/meditation.gif',
        },
      ];
      _isLoading = false; // انتهاء التحميل
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : _errorMessage != null
              ? Center(
                  child: Text(
                    _errorMessage!,
                    style: const TextStyle(color: Colors.red, fontSize: 16),
                  ),
                )
              : _exercises.isEmpty
                  ? const Center(
                      child: Text(
                        "No exercises found for this tumor type.",
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.all(16.0),
                      itemCount: _exercises.length,
                      itemBuilder: (context, index) {
                        final exercise = _exercises[index];
                        return Card(
                          elevation: 4,
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            children: [
                              // صورة GIF
                              ClipRRect(
                                borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(12),
                                ),
                                child: Image.asset(
                                  exercise['image'] ?? 'assets/images/logo.gif',
                                  height: 150,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              ListTile(
                                leading: const Icon(Icons.fitness_center,
                                    color: Colors.teal),
                                title: Text(
                                  exercise['name'] ?? 'Exercise Name',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                subtitle: Text(
                                  exercise['description'] ??
                                      'Exercise Description',
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
    );
  }
}
