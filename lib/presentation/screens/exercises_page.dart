import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ai_tumor_detect/core/constant/color.dart';

class ExercisesPage extends StatelessWidget {
  final String? tumorType;
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

  ExercisesPage({super.key, this.tumorType});

  @override
  Widget build(BuildContext context) {
    final exercisesList = tumorType != null
        ? tumorExercises[tumorType] ?? []
        : tumorExercises.entries.expand((e) => e.value).toList();

    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: tumorType != null
          ? AppBar(
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
                onPressed: () => Navigator.pop(context),
              ),
              title: Text(
                "Exercises for $tumorType",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              centerTitle: true,
              flexibleSpace: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [AppColor.primaryColor, AppColor.lightCyan],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              ),
              backgroundColor: Colors.transparent,
              elevation: 0,
            )
          : null,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.white,
              AppColor.lightCyan.withOpacity(0.1),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: ListView.builder(
          padding: EdgeInsets.all(20.w),
          itemCount: tumorType != null
              ? exercisesList.length
              : tumorExercises.keys.length,
          itemBuilder: (context, index) {
            if (tumorType != null) {
              return _buildExerciseCard(exercisesList[index], index);
            } else {
              final tumorType = tumorExercises.keys.elementAt(index);
              return _buildTumorSection(tumorType, index);
            }
          },
        ),
      ),
    );
  }

  Widget _buildTumorSection(String tumorType, int index) {
    final exercises = tumorExercises[tumorType]!;
    final cardColor = _getCardColor(index);

    return Card(
      elevation: 8,
      margin: EdgeInsets.symmetric(vertical: 12.h),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Container(
        padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              cardColor,
              cardColor.withOpacity(0.8),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: cardColor.withOpacity(0.3),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  _getTumorIcon(tumorType),
                  color: Colors.white,
                  size: 24.r,
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Text(
                    tumorType,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.sp,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),
            const Divider(color: Colors.white70, thickness: 1.2),
            SizedBox(height: 16.h),
            ...exercises.map(
              (exercise) => Padding(
                padding: EdgeInsets.symmetric(vertical: 8.h),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.fitness_center,
                      size: 20.r,
                      color: Colors.white70,
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            exercise['name']!,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16.sp,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            exercise['description']!,
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: Colors.white.withOpacity(0.8),
                              height: 1.4,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExerciseCard(Map<String, String> exercise, int index) {
    final cardColor = _getCardColor(index);

    return Card(
      elevation: 8,
      margin: EdgeInsets.symmetric(vertical: 12.h),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Container(
        padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              cardColor,
              cardColor.withOpacity(0.8),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: cardColor.withOpacity(0.3),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.fitness_center,
                  color: Colors.white,
                  size: 24.r,
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Text(
                    exercise['name']!,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.sp,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 12.h),
            Text(
              exercise['description']!,
              style: TextStyle(
                fontSize: 14.sp,
                color: Colors.white.withOpacity(0.9),
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }

  IconData _getTumorIcon(String tumorName) {
    switch (tumorName) {
      case 'Meningioma':
        return Icons.circle;
      case 'Astrocitoma':
        return Icons.circle;
      case 'Schwannoma':
        return Icons.circle;
      case 'Neurocitoma':
        return Icons.circle;
      case 'Carcinoma':
        return Icons.circle;
      case 'Papiloma':
        return Icons.circle;
      case 'Oligodendroglioma':
        return Icons.circle;
      case 'Glioblastoma':
        return Icons.circle;
      case 'Ependimoma':
        return Icons.circle;
      case 'Tuberculoma':
        return Icons.air;
      case 'Meduloblastoma':
        return Icons.circle;
      case 'Germinoma':
        return Icons.circle;
      case 'Granuloma':
        return Icons.circle;
      case 'Ganglioglioma':
        return Icons.circle;
      default:
        return Icons.circle;
    }
  }

  Color _getCardColor(int index) {
    const colors = [
      Color(0xFF1ABC9C),
      Color(0xFF3498DB),
      Color(0xFFF39C12),
      Color(0xFFE74C3C),
      Color(0xFF2ECC71),
      Color(0xFF9B59B6),
      Color(0xFFFF5722),
      Color(0xFF34495E),
    ];
    return colors[index % colors.length];
  }
}
