import 'package:ai_tumor_detect/core/constant/color.dart';
import 'package:ai_tumor_detect/core/helper/show_snack_bar.dart';
import 'package:ai_tumor_detect/core/network/tumor_detection_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'effects_page.dart'; // استيراد صفحة التأثيرات
import 'exercises_page.dart'; // استيراد صفحة التمارين
import 'dart:async';

class DiagnosisPage extends StatefulWidget {
  final Function(int)? onNavigate; // وظيفة للتنقل بين الصفحات

  const DiagnosisPage({super.key, this.onNavigate});

  @override
  State<DiagnosisPage> createState() => _DiagnosisPageState();
}

class _DiagnosisPageState extends State<DiagnosisPage> {
  File? _selectedImage;
  bool _isLoading = false;
  String? _diagnosisResult;
  double _progress = 0.0;
  bool _hasDiagnosed = false; // إضافة متغير لتتبع حالة التشخيص

  final ImagePicker _picker = ImagePicker();
  final TumorDetectionModel _model = TumorDetectionModel();

  @override
  void initState() {
    super.initState();
    _loadDiagnosisData();
  }

  Future<void> _loadDiagnosisData() async {
    final prefs = await SharedPreferences.getInstance();
    final diagnosisResult = prefs.getString('diagnosisResult');
    final imagePath = prefs.getString('selectedImagePath');
    final hasDiagnosed = prefs.getBool('hasDiagnosed') ?? false;

    if (hasDiagnosed && diagnosisResult != null) {
      setState(() {
        _diagnosisResult = diagnosisResult;
        _hasDiagnosed = true;
        if (imagePath != null) {
          _selectedImage = File(imagePath);
        }
      });
    }
  }

  Future<void> _saveDiagnosisData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('diagnosisResult', _diagnosisResult ?? '');
    await prefs.setString('selectedImagePath', _selectedImage?.path ?? '');
    await prefs.setBool('hasDiagnosed', _hasDiagnosed);
  }

  Future<void> _clearDiagnosisData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('diagnosisResult');
    await prefs.remove('selectedImagePath');
    await prefs.remove('hasDiagnosed');
  }

  Future<void> _pickImage() async {
    if (_hasDiagnosed) {
      // إذا كان هناك تشخيص سابق، نعرض تنبيهاً
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Warning"),
          content: const Text(
              "You have a previous diagnosis. Please reset before uploading a new image."),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("OK"),
            ),
          ],
        ),
      );
      return;
    }

    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Choose from Gallery'),
                onTap: () async {
                  Navigator.pop(context);
                  final pickedFile =
                      await _picker.pickImage(source: ImageSource.gallery);
                  if (pickedFile != null) {
                    setState(() {
                      _selectedImage = File(pickedFile.path);
                      _diagnosisResult = null;
                    });
                    await _saveDiagnosisData();
                  }
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_camera),
                title: const Text('Take a Photo'),
                onTap: () async {
                  Navigator.pop(context);
                  final pickedFile =
                      await _picker.pickImage(source: ImageSource.camera);
                  if (pickedFile != null) {
                    setState(() {
                      _selectedImage = File(pickedFile.path);
                      _diagnosisResult = null;
                    });
                    await _saveDiagnosisData();
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _startDiagnosis() async {
    if (_selectedImage == null) {
      showSnackBar(
        context,
        "Please upload an MRI scan first.",
        backgroundColor: Colors.orange,
      );
      return;
    }

    setState(() {
      _isLoading = true;
      _progress = 0.0;
    });

    // Simulate progress
    Timer.periodic(const Duration(milliseconds: 100), (timer) {
      if (_progress < 0.9) {
        setState(() {
          _progress += 0.1;
        });
      } else {
        timer.cancel();
      }
    });

    try {
      final result = await _model.diagnose(_selectedImage!);
      setState(() {
        _isLoading = false;
        _progress = 1.0;
        _diagnosisResult = result;
        _hasDiagnosed = true; // تحديث حالة التشخيص
      });
      await _saveDiagnosisData();

      // Show result dialog
      if (mounted) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Diagnosis Result'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(result),
                const SizedBox(height: 16),
                const Text(
                  'Would you like to view more details about the effects?',
                  style: TextStyle(fontSize: 14),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EffectsPage(tumorType: result),
                    ),
                  );
                },
                child: const Text('View Effects'),
              ),
            ],
          ),
        );
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
        _progress = 0.0;
      });
      if (mounted) {
        showSnackBar(
          context,
          "Failed to diagnose: ${e.toString()}",
          backgroundColor: Colors.red,
        );
      }
    }
  }

  void _resetDiagnosis() async {
    setState(() {
      _selectedImage = null;
      _diagnosisResult = null;
      _progress = 0.0;
      _hasDiagnosed = false; // إعادة تعيين حالة التشخيص
    });
    await _clearDiagnosisData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Padding(
                padding: EdgeInsets.all(16.w),
                child: Column(
                  children: [
                    const Text(
                      "Upload an MRI scan to get an accurate diagnosis of potential brain tumor types.",
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 20.h),
                    ElevatedButton(
                      onPressed: _pickImage,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        elevation: 8,
                        padding: EdgeInsets.symmetric(
                            horizontal: 4.w, vertical: 2.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.r),
                        ),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [
                              AppColor.primaryColor,
                              Color.fromARGB(255, 155, 238, 238),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(30.r),
                        ),
                        alignment: Alignment.center,
                        height: 50.h,
                        width: double.infinity,
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.upload, color: Colors.white),
                            SizedBox(width: 8),
                            Text(
                              "Upload MRI Scan",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
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
            SizedBox(height: 20.h),
            if (_selectedImage != null)
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12.r),
                  child: Image.file(
                    _selectedImage!,
                    height: 200.h,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              )
            else
              const Text(
                "No image selected yet",
                style: TextStyle(color: Colors.grey, fontSize: 14),
              ),
            SizedBox(height: 20.h),
            if (_isLoading)
              Column(
                children: [
                  LinearProgressIndicator(
                    value: _progress,
                    backgroundColor: Colors.grey[200],
                    valueColor:
                        AlwaysStoppedAnimation<Color>(AppColor.primaryColor),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    'Analyzing... ${(_progress * 100).toInt()}%',
                    style: TextStyle(
                      color: AppColor.primaryColor,
                      fontSize: 14.sp,
                    ),
                  ),
                ],
              ),
            SizedBox(height: 20.h),
            if (!_hasDiagnosed) // إظهار زر التشخيص فقط إذا لم يكن هناك تشخيص سابق
              ElevatedButton(
                onPressed: _isLoading ? null : _startDiagnosis,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  elevation: 8,
                  padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.r),
                  ),
                ),
                child: Ink(
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xFF4CAF50),
                        Color.fromARGB(255, 116, 221, 121)
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(30.r),
                  ),
                  child: Container(
                    alignment: Alignment.center,
                    height: 50.h,
                    width: double.infinity,
                    child: _isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Image(
                                  image: AssetImage("assets/images/x-rays.png"),
                                ),
                              ),
                              SizedBox(width: 8.w),
                              const Text(
                                "Start Diagnosis",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                  ),
                ),
              ),
            if (_diagnosisResult != null) ...[
              SizedBox(height: 20.h),
              Card(
                elevation: 4,
                color: AppColor.lightCyan.withOpacity(0.2),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Padding(
                  padding: EdgeInsets.all(16.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Diagnosis Result:",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        _diagnosisResult!,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              EffectsPage(tumorType: _diagnosisResult),
                        ),
                      );
                    },
                    icon: const Icon(Icons.medical_services),
                    label: const Text("View Effects"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor.primaryColor,
                      foregroundColor: Colors.white,
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              ExercisesPage(tumorType: _diagnosisResult),
                        ),
                      );
                    },
                    icon: const Icon(Icons.fitness_center),
                    label: const Text("View Exercises"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor.primaryColor,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ],
              ),
            ],
            if (_diagnosisResult != null || _selectedImage != null)
              Padding(
                padding: EdgeInsets.only(top: 20.h),
                child: ElevatedButton.icon(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text("Reset Diagnosis"),
                        content: const Text(
                            "Are you sure you want to reset the diagnosis?"),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text("Cancel"),
                          ),
                          TextButton(
                            onPressed: () {
                              _resetDiagnosis();
                              Navigator.pop(context);
                            },
                            child: const Text("Reset"),
                          ),
                        ],
                      ),
                    );
                  },
                  icon: const Icon(Icons.restart_alt),
                  label: const Text("Try Again"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    foregroundColor: Colors.white,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
