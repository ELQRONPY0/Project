import 'package:ai_tumor_detect/core/constant/color.dart';
import 'package:ai_tumor_detect/core/network/tumor_detection_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class DiagnosisPage extends StatefulWidget {
  final Function(int)? onNavigate;
  const DiagnosisPage({super.key, this.onNavigate});

  @override
  State<DiagnosisPage> createState() => _DiagnosisPageState();
}

class _DiagnosisPageState extends State<DiagnosisPage> {
  File? _selectedImage;
  bool _isLoading = false;
  String? _diagnosisResult;

  final ImagePicker _picker = ImagePicker();
  final TumorDetectionModel _model = TumorDetectionModel();

  get onNavigate => widget.onNavigate;

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      print('Image path: ${pickedFile.path}'); // طباعة مسار الصورة
      setState(() {
        _selectedImage = File(pickedFile.path);
        _diagnosisResult = null;
      });
    }
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
    });

    try {
      final result = await _model.diagnose(_selectedImage!);
      setState(() {
        _isLoading = false;
        _diagnosisResult = result;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      print('Error: $e'); // طباعة الخطأ في وحدة التحكم
      showSnackBar(
        context,
        "Failed to diagnose: ${e.toString()}", // عرض تفاصيل الخطأ للمستخدم
        backgroundColor: Colors.red,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "Upload an MRI scan to get an accurate diagnosis of potential brain tumor types.",
              style: TextStyle(fontSize: 16, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _pickImage,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                elevation: 8,
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
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
                  borderRadius: BorderRadius.circular(30),
                ),
                alignment: Alignment.center,
                height: 50,
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
            const SizedBox(height: 20),
            if (_selectedImage != null)
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.file(
                    _selectedImage!,
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              )
            else
              const Text(
                "No image selected yet.",
                style: TextStyle(color: Colors.grey, fontSize: 14),
              ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _isLoading ? null : _startDiagnosis,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                elevation: 8,
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
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
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Container(
                  alignment: Alignment.center,
                  height: 50,
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
                            SizedBox(height: 8.h),
                            const Text(
                              "Start Diagnosis",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ],
                        ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            if (_diagnosisResult != null)
              Card(
                elevation: 4,
                color: AppColor.lightCyan.withOpacity(0.2),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
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
                      const SizedBox(height: 8),
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
            const SizedBox(height: 32),
            if (_diagnosisResult != null)
              GestureDetector(
                onTap: () {
                  if (onNavigate != null) {
                    onNavigate(2);
                  }
                },
                child: Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Colors.orange, Colors.deepOrange],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.fitness_center, size: 32, color: Colors.white),
                      SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Recommended Exercises",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "Click to see exercises for your condition.",
                              style: TextStyle(
                                  fontSize: 14, color: Colors.white70),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            SizedBox(height: 24.h),
            const SizedBox(height: 20),
            if (_diagnosisResult != null || _selectedImage != null)
              ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text("Reset Diagnosis"),
                      content: const Text(
                          "Are you sure you want to reset the diagnosis?"),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text("Cancel"),
                        ),
                        TextButton(
                          onPressed: () {
                            setState(() {
                              _selectedImage = null;
                              _diagnosisResult = null;
                            });
                            Navigator.pop(context);
                          },
                          child: const Text("Reset"),
                        ),
                      ],
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  elevation: 8,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Ink(
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFFFFA726), Color(0xFFF57C00)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Container(
                    alignment: Alignment.center,
                    height: 50,
                    width: double.infinity,
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.restart_alt, color: Colors.white),
                        SizedBox(width: 8),
                        Text(
                          "Try Again",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

void showSnackBar(BuildContext context, String message,
    {Color backgroundColor = Colors.black}) {
  final snackBar = SnackBar(
    content: Text(message),
    backgroundColor: backgroundColor,
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
