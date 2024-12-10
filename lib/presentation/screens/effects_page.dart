import 'package:flutter/material.dart';

class EffectsPage extends StatelessWidget {
  // قائمة الأورام مع الوصف والأجزاء المتأثرة
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

  EffectsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 255, 255, 255),
              Color.fromARGB(255, 255, 255, 255),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: ListView.builder(
          padding: const EdgeInsets.all(20.0),
          itemCount: tumorEffects.length,
          itemBuilder: (context, index) {
            final tumor = tumorEffects[index];
            return Card(
              elevation: 6,
              margin: const EdgeInsets.symmetric(vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: InkWell(
                onTap: () {},
                borderRadius: BorderRadius.circular(16),
                child: Container(
                  padding: const EdgeInsets.all(20.0),
                  decoration: BoxDecoration(
                    color: _getCardColor(index),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        tumor['name'],
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        tumor['description'],
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.white70,
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Divider(
                        color: Colors.white70,
                        thickness: 1.2,
                      ),
                      const SizedBox(height: 10),
                      ...((tumor['details'] as List<dynamic>?) ?? []).map(
                        (detail) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4.0),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.circle,
                                size: 10,
                                color: Colors.white70,
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      detail['part'],
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color: Colors.white,
                                      ),
                                    ),
                                    if (detail['effect'] != null)
                                      Text(
                                        detail['effect'],
                                        style: const TextStyle(
                                          fontSize: 14,
                                          color: Colors.white70,
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
              ),
            );
          },
        ),
      ),
    );
  }

  Color _getCardColor(int index) {
    // ألوان الكروت مشابهة لصفحة "Medical Tips".
    const colors = [
      Color(0xFF1ABC9C), // أخضر زاهي
      Color(0xFF3498DB), // أزرق
      Color(0xFFF39C12), // برتقالي
      Color(0xFFE74C3C), // أحمر
      Color(0xFF2ECC71), // أصفر
      Color(0xFF9B59B6), // أزرق ما��ل
      Color(0xFFFF5722), // أحمر ��امق
      Color(0xFF34495E), // أبيض ��اهي
    ];
    return colors[index % colors.length];
  }
}
