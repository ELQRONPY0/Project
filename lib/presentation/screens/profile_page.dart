import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ai_tumor_detect/core/constant/color.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:provider/provider.dart';
import '../../features/auth/presentation/user_provider.dart';
import 'package:ai_tumor_detect/presentation/screens/profile_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _formKey = GlobalKey<FormState>();
  File? _profileImage;
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _bioController = TextEditingController();
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    // Populate controllers once when the widget is initialized.
    // The Consumer will handle subsequent updates.
    _populateControllersFromProvider();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  void _populateControllersFromProvider() {
    // Use listen: false because we are in initState or a callback.
    // The UI is rebuilt by the Consumer/Provider.of(context) in the build method.
    final user = Provider.of<UserProvider>(context, listen: false).user;
    if (user != null) {
      _nameController.text = user.name ?? '';
      _emailController.text = user.email ?? '';
      _phoneController.text = user.phone ?? '';
      _bioController.text = user.bio ?? '';
      if (user.profileImage != null && File(user.profileImage!).existsSync()) {
        _profileImage = File(user.profileImage!);
      } else {
        _profileImage = null;
      }
    }
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _profileImage = File(image.path);
      });
    }
  }

  void _toggleEditMode() {
    setState(() {
      _isEditing = !_isEditing;
      if (!_isEditing) {
        // If canceling edit, revert changes by re-populating from the provider.
        _populateControllersFromProvider();
      }
    });
  }

  void _saveProfile() {
    if (_formKey.currentState!.validate()) {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      userProvider.updateUser(
        name: _nameController.text,
        email: _emailController.text,
        phone: _phoneController.text,
        bio: _bioController.text,
        profileImage: _profileImage?.path,
      );
      setState(() {
        _isEditing = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profile updated successfully')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Using a Consumer to rebuild the UI when user data changes (e.g., on logout/login).
    return Consumer<UserProvider>(
      builder: (context, userProvider, child) {
        final user = userProvider.user;

        // This check ensures that if we land on this page logged out, we see an appropriate UI.
        if (user == null) {
          return Scaffold(
            appBar: AppBar(title: const Text('Profile')),
            body: const Center(
              child: Text('Please log in to view your profile.'),
            ),
          );
        }

        return Scaffold(
          backgroundColor: const Color(0xFFF6F8FA),
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new, color: AppColor.white),
              onPressed: () => Navigator.pop(context),
            ),
            title: const Text('Profile',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold)),
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
            elevation: 0,
            actions: [
              IconButton(
                icon: Icon(_isEditing ? Icons.close : Icons.edit,
                    color: Colors.white),
                onPressed: _toggleEditMode,
              ),
            ],
          ),
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                _buildProfileHeader(user),
                SizedBox(height: 24.h),
                _buildProfileForm(),
                _buildLogoutButton(context)
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildProfileHeader(user) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColor.primaryColor, AppColor.lightCyan],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        children: [
          SizedBox(height: 20.h),
          Stack(
            children: [
              Container(
                width: 120.w,
                height: 120.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 4.w),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(60.r),
                  child: _profileImage != null
                      ? Image.file(_profileImage!, fit: BoxFit.cover)
                      : (user?.profileImage != null
                          ? Image.network(user!.profileImage!,
                              fit: BoxFit.cover)
                          : Container(
                              color: Colors.white,
                              child: Icon(Icons.person,
                                  size: 60.r, color: AppColor.primaryColor),
                            )),
                ),
              ),
              if (_isEditing)
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: Container(
                    padding: EdgeInsets.all(8.w),
                    decoration: BoxDecoration(
                      color: AppColor.primaryColor,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2.w),
                    ),
                    child: InkWell(
                      onTap: _pickImage,
                      child: Icon(Icons.camera_alt,
                          color: Colors.white, size: 20.r),
                    ),
                  ),
                ),
            ],
          ),
          SizedBox(height: 16.h),
          Text(
            _nameController.text,
            style: TextStyle(
                fontSize: 24.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white),
          ),
          SizedBox(height: 4.h),
          Text(
            _emailController.text,
            style: TextStyle(
                fontSize: 16.sp, color: Colors.white.withOpacity(0.8)),
          ),
          SizedBox(height: 20.h),
        ],
      ),
    );
  }

  Widget _buildProfileForm() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle('Personal Information'),
            SizedBox(height: 16.h),
            _buildFormCard([
              _buildTextField(
                  controller: _nameController,
                  label: 'Full Name',
                  icon: Icons.person_outline,
                  enabled: _isEditing,
                  validator: (val) =>
                      val == null || val.isEmpty ? 'Enter your name' : null),
              _buildTextField(
                  controller: _emailController,
                  label: 'Email',
                  icon: Icons.email_outlined,
                  enabled: _isEditing,
                  keyboardType: TextInputType.emailAddress,
                  validator: (val) => val == null || !val.contains('@')
                      ? 'Enter valid email'
                      : null),
              _buildTextField(
                  controller: _phoneController,
                  label: 'Phone Number',
                  icon: Icons.phone_outlined,
                  enabled: _isEditing,
                  keyboardType: TextInputType.phone,
                  validator: (val) =>
                      val == null || val.isEmpty ? 'Enter phone number' : null),
            ]),
            SizedBox(height: 24.h),
            _buildSectionTitle('About'),
            SizedBox(height: 16.h),
            _buildFormCard([
              _buildTextField(
                  controller: _bioController,
                  label: 'Bio',
                  icon: Icons.description_outlined,
                  enabled: _isEditing,
                  maxLines: 3,
                  validator: (val) =>
                      val == null || val.isEmpty ? 'Enter your bio' : null),
            ]),
            if (_isEditing)
              Padding(
                padding: EdgeInsets.only(top: 24.h),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _saveProfile,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor.primaryColor,
                      padding: EdgeInsets.symmetric(vertical: 16.h),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r)),
                    ),
                    child: Text('Save Changes',
                        style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.white)),
                  ),
                ),
              ),
            SizedBox(height: 32.h),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.w),
      child: Text(
        title,
        style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: AppColor.primaryColor),
      ),
    );
  }

  Widget _buildFormCard(List<Widget> children) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4)),
        ],
      ),
      child: Column(
        children: children.map((child) {
          final index = children.indexOf(child);
          return Column(
            children: [
              child,
              if (index != children.length - 1)
                Divider(
                    height: 1,
                    thickness: 1,
                    color: Colors.grey.withOpacity(0.1),
                    indent: 16.w,
                    endIndent: 16.w),
            ],
          );
        }).toList(),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    required bool enabled,
    TextInputType? keyboardType,
    int? maxLines,
    String? Function(String?)? validator,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 16.w),
      child: TextFormField(
        controller: controller,
        enabled: enabled,
        keyboardType: keyboardType,
        maxLines: maxLines ?? 1,
        validator: validator,
        style: TextStyle(fontSize: 16.sp, color: Colors.black87),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(fontSize: 14.sp, color: Colors.black54),
          prefixIcon: Icon(icon, color: AppColor.primaryColor, size: 24.r),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: 12.h),
        ),
      ),
    );
  }

  Widget _buildLogoutButton(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton.icon(
          onPressed: () async {
            final userProvider =
                Provider.of<UserProvider>(context, listen: false);
            await userProvider.clearUser();
            // TODO: Navigate to login screen
            Navigator.of(context)
                .pushNamedAndRemoveUntil('/login', (route) => false);
          },
          icon: const Icon(Icons.logout, color: Colors.white),
          label: const Text('Logout',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold)),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.redAccent,
            padding: EdgeInsets.symmetric(vertical: 16.h),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.r),
            ),
          ),
        ),
      ),
    );
  }
}
