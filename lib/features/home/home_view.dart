import 'dart:io';

import 'package:contact/core/app_colors.dart';
import 'package:contact/features/home/widgets/contacts.dart';
import 'package:contact/features/home/widgets/custom_text_field.dart';
import 'package:contact/features/models/contacts_model.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});
  static String id = 'HomeView';

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final nameController = TextEditingController();

  final emailController = TextEditingController();

  final phoneController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  File? selectedImage;
  List<ContactModel> contacts = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 55, left: 16),
            alignment: Alignment.centerLeft,
            height: 45,
            width: 160,
            child: Image.asset('assets/images/Group 5.png'),
          ),

          ContactsView(
            contacts: contacts,
            onDelete: (index) {
              setState(() {
                contacts.removeAt(index);
              });
            },
          ),
        ],
      ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (contacts.isNotEmpty)
            SizedBox(
              width: 55,
              height: 55,
              child: FloatingActionButton(
                heroTag: 'deleteBtn',
                backgroundColor: Colors.red,
                mini: true,
                child: const Icon(Icons.delete, color: Colors.white),
                onPressed: () {
                  setState(() {
                    contacts.removeLast();
                  });
                },
              ),
            ),

          if (contacts.isNotEmpty) const SizedBox(height: 12),
          if (contacts.length < 6)
            FloatingActionButton(
              heroTag: 'addBtn',
              backgroundColor: AppColors.gold,
              child: const Icon(Icons.add, color: AppColors.primaryColor),
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: AppColors.primaryColor,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(40),
                    ),
                  ),
                  builder: (context) {
                    return buildBottomSheet();
                  },
                );
              },
            ),
        ],
      ),
    );
  }

  StatefulBuilder buildBottomSheet() {
    return StatefulBuilder(
      builder: (context, setModalState) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: SizedBox(
            height: 470,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 18,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: pickImage,
                        child: Container(
                          width: 145,
                          height: 145,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(28),
                            border: Border.all(
                              color: AppColors.gold,
                              width: 1.5,
                            ),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(28),
                            child: selectedImage == null
                                ? Lottie.asset(
                                    'assets/animations/image_picker.json',
                                    fit: BoxFit.cover,
                                  )
                                : Image.file(selectedImage!, fit: BoxFit.cover),
                          ),
                        ),
                      ),

                      const SizedBox(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 16),
                          SizedBox(
                            width: 155,
                            child: Text(
                              nameController.text.isEmpty
                                  ? 'User Name'
                                  : nameController.text,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: AppColors.gold,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 120,
                            child: Divider(
                              color: AppColors.gold,
                              thickness: 1.5,
                            ),
                          ),

                          SizedBox(
                            width: 155,
                            child: Text(
                              emailController.text.isEmpty
                                  ? 'example@email.com'
                                  : emailController.text,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: AppColors.gold,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 120,
                            child: Divider(
                              color: AppColors.gold,
                              thickness: 1.5,
                            ),
                          ),
                          Text(
                            phoneController.text.isEmpty
                                ? '+200000000000'
                                : phoneController.text,
                            style: const TextStyle(
                              color: AppColors.gold,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      CustomTextField(
                        controller: nameController,
                        hint: 'Enter User Name',
                        onChanged: (_) => setModalState(() {}),
                      ),
                      const SizedBox(height: 12),

                      CustomTextField(
                        controller: emailController,
                        hint: 'Enter User Email',
                        keyboardType: TextInputType.emailAddress,
                        onChanged: (_) => setModalState(() {}),
                      ),
                      const SizedBox(height: 12),

                      CustomTextField(
                        controller: phoneController,
                        hint: 'Enter User Phone',
                        keyboardType: TextInputType.phone,
                        onChanged: (_) => setModalState(() {}),
                      ),
                      const SizedBox(height: 12),
                      GestureDetector(
                        onTap: () {
                          if (contacts.length == 6) return;

                          setState(() {
                            contacts.add(
                              ContactModel(
                                name: nameController.text,
                                email: emailController.text,
                                phone: phoneController.text,
                                image: selectedImage,
                              ),
                            );
                          });
                          nameController.clear();
                          emailController.clear();
                          phoneController.clear();
                          selectedImage = null;
                          Navigator.pop(context);
                        },
                        child: Container(
                          alignment: Alignment.center,
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(
                            vertical: 16,
                            //horizontal: 24,
                          ),

                          decoration: BoxDecoration(
                            color: AppColors.gold,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Text(
                            "Enter User",
                            style: TextStyle(
                              color: AppColors.primaryColor,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        selectedImage = File(image.path);
      });
    }
  }
}
