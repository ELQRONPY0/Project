import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ai_tumor_detect/core/constant/color.dart';

class EffectsPage extends StatelessWidget {
  final String? tumorType;
  final List<Map<String, dynamic>> tumorEffects = [
    {
      'name': 'Meningioma',
      'description':
          'A tumor that arises from the meninges, the membranes surrounding the brain and spinal cord.',
      'details': [
        {'part': 'Brain', 'effect': 'May cause headaches and seizures.'},
        {'part': 'Spinal Cord', 'effect': 'Can lead to nerve compression.'},
        {'part': 'Skull', 'effect': 'May result in bone changes.'},
      ],
    },
    {
      'name': 'Astrocitoma',
      'description':
          'A tumor originating from star-shaped brain cells called astrocytes.',
      'details': [
        {'part': 'Brain', 'effect': 'Can affect cognitive functions.'},
        {
          'part': 'Central Nervous System',
          'effect': 'May impair motor skills.'
        },
      ],
    },
    {
      'name': 'Schwannoma',
      'description':
          'A benign tumor that develops from Schwann cells in the nervous system.',
      'details': [
        {'part': 'Nerves', 'effect': 'May cause pain or tingling.'},
        {'part': 'Hearing (Ear)', 'effect': 'Can lead to hearing loss.'},
        {'part': 'Spinal Cord', 'effect': 'May result in nerve compression.'},
      ],
    },
    {
      'name': 'Neurocitoma',
      'description':
          'A rare brain tumor that usually arises in the brain ventricles.',
      'details': [
        {
          'part': 'Brain Ventricles',
          'effect': 'Can obstruct cerebrospinal fluid.'
        },
        {'part': 'Spinal Cord', 'effect': 'May impair nerve function.'},
      ],
    },
    {
      'name': 'Carcinoma',
      'description': 'A malignant tumor that arises from epithelial cells.',
      'details': [
        {'part': 'Lungs', 'effect': 'Can cause respiratory issues.'},
        {'part': 'Liver', 'effect': 'May impair metabolic functions.'},
        {'part': 'Bones', 'effect': 'Can lead to fractures.'},
      ],
    },
    {
      'name': 'Papiloma',
      'description':
          'A benign tumor caused by the overgrowth of epithelial tissue.',
      'details': [
        {'part': 'Skin', 'effect': 'May cause wart-like growths.'},
        {'part': 'Mucous Membranes', 'effect': 'Can lead to discomfort.'},
      ],
    },
    {
      'name': 'Oligodendroglioma',
      'description': 'A tumor that arises from oligodendrocytes in the brain.',
      'details': [
        {
          'part': 'Brain',
          'effect': 'Can cause seizures and cognitive decline.'
        },
        {'part': 'Spinal Cord', 'effect': 'May impair motor functions.'},
      ],
    },
    {
      'name': 'Glioblastoma',
      'description': 'An aggressive type of cancer that occurs in the brain.',
      'details': [
        {
          'part': 'Brain',
          'effect': 'Can cause severe headaches and neurological deficits.'
        },
        {
          'part': 'Cerebral Cortex',
          'effect': 'May lead to loss of motor or sensory functions.'
        },
      ],
    },
    {
      'name': 'Ependimoma',
      'description':
          'A tumor that forms in the ependymal cells lining the ventricles of the brain.',
      'details': [
        {'part': 'Spinal Cord', 'effect': 'May cause pain and sensory loss.'},
        {
          'part': 'Brain Ventricles',
          'effect': 'Can block cerebrospinal fluid flow.'
        },
      ],
    },
    {
      'name': 'Tuberculoma',
      'description': 'A mass-like lesion caused by tuberculosis infection.',
      'details': [
        {'part': 'Lungs', 'effect': 'Can cause breathing difficulties.'},
        {'part': 'Brain', 'effect': 'May lead to headaches and confusion.'},
        {'part': 'Lymph Nodes', 'effect': 'Can cause swelling and pain.'},
      ],
    },
    {
      'name': 'Meduloblastoma',
      'description':
          'A fast-growing, high-grade tumor that originates in the cerebellum.',
      'details': [
        {'part': 'Brain Stem', 'effect': 'Can impair vital functions.'},
        {
          'part': 'Cerebellum',
          'effect': 'May cause balance and coordination issues.'
        },
      ],
    },
    {
      'name': 'Germinoma',
      'description': 'A rare tumor that arises from germ cells in the brain.',
      'details': [
        {'part': 'Pineal Gland', 'effect': 'Can disrupt sleep-wake cycles.'},
        {'part': 'Brain', 'effect': 'May cause headaches and nausea.'},
      ],
    },
    {
      'name': 'Granuloma',
      'description': 'An inflammation resulting in a small nodular lesion.',
      'details': [
        {
          'part': 'Lungs',
          'effect': 'May cause persistent cough and chest pain.'
        },
        {'part': 'Skin', 'effect': 'Can lead to localized swelling.'},
        {'part': 'Liver', 'effect': 'May impair liver function.'},
      ],
    },
    {
      'name': 'Ganglioglioma',
      'description':
          'A rare and slow-growing tumor composed of ganglion and glial cells.',
      'details': [
        {
          'part': 'Brain',
          'effect': 'Can lead to epilepsy and cognitive changes.'
        },
        {'part': 'Spinal Cord', 'effect': 'May impair mobility and sensation.'},
      ],
    },
  ];

  EffectsPage({super.key, this.tumorType});

  @override
  Widget build(BuildContext context) {
    final filteredEffects = tumorType != null
        ? tumorEffects.where((t) => t['name'] == tumorType).toList()
        : tumorEffects;

    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: tumorType != null
          ? AppBar(
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
                onPressed: () => Navigator.pop(context),
              ),
              title: Text(
                "Effects of $tumorType",
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
          itemCount: filteredEffects.length,
          itemBuilder: (context, index) {
            final tumor = filteredEffects[index];
            return _buildTumorCard(tumor, index);
          },
        ),
      ),
    );
  }

  Widget _buildTumorCard(Map<String, dynamic> tumor, int index) {
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
              _getCardColor(index),
              _getCardColor(index).withOpacity(0.8),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: _getCardColor(index).withOpacity(0.3),
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
                  _getTumorIcon(tumor['name']),
                  color: Colors.white,
                  size: 24.r,
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Text(
                    tumor['name'],
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
              tumor['description'],
              style: TextStyle(
                fontSize: 14.sp,
                color: Colors.white.withOpacity(0.9),
                height: 1.5,
              ),
            ),
            SizedBox(height: 16.h),
            const Divider(color: Colors.white70, thickness: 1.2),
            SizedBox(height: 16.h),
            ...(tumor['details'] as List<dynamic>).map(
              (detail) => Padding(
                padding: EdgeInsets.symmetric(vertical: 8.h),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.circle,
                      size: 8.r,
                      color: Colors.white70,
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            detail['part'],
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16.sp,
                              color: Colors.white,
                            ),
                          ),
                          if (detail['effect'] != null) ...[
                            SizedBox(height: 4.h),
                            Text(
                              detail['effect'],
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: Colors.white.withOpacity(0.8),
                                height: 1.4,
                              ),
                            ),
                          ],
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
        return Icons.circle;
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
