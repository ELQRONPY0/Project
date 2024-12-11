import 'package:flutter/material.dart';

class ExercisesPage extends StatelessWidget {
  // جميع التمارين مصنفة حسب نوع الورم
  final Map<String, List<Map<String, String>>> tumorExercises = {
    'Meningioma': [
      {
        'name': 'Deep Breathing',
        'description': 'Relax your nervous system and reduce tension.'
      },
      {
        'name': 'Gentle Neck and Back Stretching',
        'description': 'Relieve spinal pressure.'
      },
      {
        'name': 'Relaxation Exercises (Yoga)',
        'description': 'Improve circulation and reduce headaches.'
      },
    ],
    'Astrocitoma': [
      {
        'name': 'Mental Exercises',
        'description': 'Play mental games like puzzles or chess.'
      },
      {
        'name': 'Balance Exercises',
        'description': 'Stand on one foot to improve coordination.'
      },
      {
        'name': 'Hand Exercises',
        'description': 'Squeeze a stress ball to strengthen hands.'
      },
    ],
    'Schwannoma': [
      {
        'name': 'Nerve Stretching',
        'description': 'Improve blood flow and reduce pain.'
      },
      {
        'name': 'Neck Relaxation',
        'description': 'Reduce pressure on the nerves.'
      },
      {
        'name': 'Hearing Exercises',
        'description': 'Stimulate auditory nerves with sound activities.'
      },
    ],
    'Neurocitoma': [
      {'name': 'Meditation', 'description': 'Reduce intracranial pressure.'},
      {
        'name': 'Stretching Exercises',
        'description': 'Improve blood flow to nerves.'
      },
      {'name': 'Yoga', 'description': 'Strengthen the nervous system.'},
    ],
    'Carcinoma': [
      {'name': 'Deep Breathing', 'description': 'Enhance lung capacity.'},
      {'name': 'Light Weight Exercises', 'description': 'Strengthen bones.'},
      {'name': 'Light Walking', 'description': 'Improve overall health.'},
    ],
    'Papiloma': [
      {
        'name': 'Simple Stretching',
        'description': 'Improve muscle flexibility.'
      },
      {
        'name': 'Immune Boosting Exercises',
        'description': 'Walk or swim to enhance immunity.'
      },
    ],
    'Oligodendroglioma': [
      {'name': 'Gentle Muscle Stretching', 'description': 'Relieve spasms.'},
      {
        'name': 'Cognitive Training',
        'description': 'Stimulate the brain and improve cognition.'
      },
      {'name': 'Yoga', 'description': 'Enhance relaxation and reduce stress.'},
    ],
    'Glioblastoma': [
      {
        'name': 'Relaxation Exercises',
        'description': 'Reduce headache-induced tension.'
      },
      {
        'name': 'Simple Balance Exercises',
        'description': 'Enhance motor functions.'
      },
      {'name': 'Light Walking', 'description': 'Maintain general fitness.'},
    ],
    'Ependimoma': [
      {'name': 'Deep Breathing', 'description': 'Improve blood circulation.'},
      {
        'name': 'Gentle Spinal Stretching',
        'description': 'Relieve nerve pressure.'
      },
      {
        'name': 'Swimming',
        'description': 'Improve spinal movement with less strain.'
      },
    ],
    'Tuberculoma': [
      {'name': 'Pranayama', 'description': 'Enhance lung function.'},
      {'name': 'Light Walking', 'description': 'Boost blood circulation.'},
      {
        'name': 'Neck Exercises',
        'description': 'Reduce pressure and improve breathing.'
      },
    ],
    'Meduloblastoma': [
      {
        'name': 'Balance Exercises',
        'description': 'Walk on a straight line to improve coordination.'
      },
      {'name': 'Stretching', 'description': 'Enhance muscle flexibility.'},
      {
        'name': 'Core Muscle Strengthening',
        'description': 'Improve stability.'
      },
    ],
    'Germinoma': [
      {'name': 'Meditation', 'description': 'Improve sleep quality.'},
      {'name': 'Gentle Stretching', 'description': 'Reduce stress.'},
      {
        'name': 'Yoga',
        'description': 'Enhance relaxation and reduce headaches.'
      },
    ],
    'Granuloma': [
      {'name': 'Deep Breathing', 'description': 'Enhance respiratory health.'},
      {'name': 'Light Walking', 'description': 'Improve circulation.'},
      {
        'name': 'Skin Massage',
        'description': 'Stimulate blood flow to affected areas.'
      },
    ],
    'Ganglioglioma': [
      {
        'name': 'Relaxation Exercises',
        'description': 'Reduce seizure likelihood.'
      },
      {
        'name': 'Cognitive Training',
        'description': 'Enhance memory and mental functions.'
      },
      {'name': 'Balance Exercises', 'description': 'Improve coordination.'},
    ],
  };

  ExercisesPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: tumorExercises.keys.length,
        itemBuilder: (context, index) {
          final tumorType = tumorExercises.keys.elementAt(index);
          final exercises = tumorExercises[tumorType]!;
          final cardColor = _getCardColor(index);
          final textColor = _getTextColor(cardColor);

          return Card(
            elevation: 6,
            margin: const EdgeInsets.symmetric(vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: cardColor,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: const Color(0xFFD1D9E6),
                  width: 1.5,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    tumorType,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                      color: textColor,
                    ),
                  ),
                  const Divider(
                    height: 20,
                    thickness: 1.5,
                    color: Color(0xFFE2E8F0),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: exercises.map((exercise) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
                          children: [
                            Icon(
                              Icons.fitness_center,
                              size: 20,
                              color: textColor,
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    exercise['name']!,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      color: textColor,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    exercise['description']!,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: textColor.withOpacity(0.8),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Color _getCardColor(int index) {
    const colors = [
      Color(0xFF1ABC9C), // أخضر زاهي
      Color(0xFF3498DB), // أزرق
      Color(0xFFF39C12), // برتقالي
      Color(0xFFE74C3C), // أحمر
      Color(0xFF2ECC71), // أصفر
      Color(0xFF9B59B6), // أزرق مائل
      Color(0xFFFF5722), // أحمر غامق
      Color(0xFF34495E), // أبيض باهي
    ];
    return colors[index % colors.length];
  }

  Color _getTextColor(Color backgroundColor) {
    // إذا كانت الخلفية داكنة نختار لون خط فاتح، والعكس صحيح.
    final brightness = backgroundColor.computeLuminance();
    return brightness > 0.5 ? Colors.black : Colors.white;
  }
}
