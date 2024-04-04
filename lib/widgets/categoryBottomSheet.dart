import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:installement1_app/screens/product_details.dart';
import 'package:installement1_app/theme/TextStyle.dart';
import 'package:installement1_app/theme/app_colors.dart';
import 'package:installement1_app/widgets/buttons.dart';
import 'package:image_picker/image_picker.dart';

class AddCategoryBottomSheet extends StatefulWidget {
  const AddCategoryBottomSheet({Key? key}) : super(key: key);

  @override
  _AddCategoryBottomSheetState createState() => _AddCategoryBottomSheetState();
}

class _AddCategoryBottomSheetState extends State<AddCategoryBottomSheet> {
  File? selectedImage;
  late TextEditingController titleController;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    User? user = FirebaseAuth.instance.currentUser;

    Future<void> pickImage() async {
      final picker = ImagePicker();
      final pickedImage = await picker.pickImage(source: ImageSource.gallery);
      if (pickedImage != null) {
        setState(() {
          selectedImage = File(pickedImage.path);
        });
      }
    }

    return PopScope(
      canPop: false,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
        child: Container(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            padding: MediaQuery.of(context).viewInsets,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Add Category',
                  style: customTextblack.copyWith(
                    fontSize: size.width * 0.04,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                GestureDetector(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(28),
                      color: selectedImage != null
                          ? Colors.transparent
                          : Colors.grey.withOpacity(0.2),
                    ),
                    width: size.width * 0.8,
                    height: size.height * 0.25,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        selectedImage != null
                            ? Image.file(
                                selectedImage!,
                                fit: BoxFit.contain,
                                width: size.width * 0.45,
                              )
                            : const Icon(Icons.image),
                        selectedImage != null
                            ? const Text('Tap To Change the Image')
                            : const Text('Upload An Image'),
                      ],
                    ),
                  ),
                  onTap: () {
                    pickImage();
                  },
                ),
                TextFormField(
                  controller: titleController,
                  decoration:
                      const InputDecoration(labelText: 'Category Title'),
                ),
                const SizedBox(height: 20),
                isLoading
                    ? SpinKitDualRing(
                        lineWidth: 2,
                        color: primaryBlue,
                        size: 40,
                      )
                    : PrimaryBtn(
                        btntxt: 'Add Category',
                        onPressedFunction: selectedImage == null
                            ? () {
                                final snackBar = const SnackBar(
                                  behavior: SnackBarBehavior.floating,
                                  backgroundColor: Colors.redAccent,
                                  content: Text('Add Image/title'),
                                );
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                                Navigator.pop(context);
                              }
                            : () async {
                                setState(() {
                                  isLoading = true;
                                });
                                // Check if category already exists
                                bool categoryExists =
                                    await _checkCategoryExists(
                                  user!.uid,
                                  titleController.text,
                                );

                                if (categoryExists) {
                                  final snackBar = const SnackBar(
                                    backgroundColor: Colors.redAccent,
                                    content: Text('Category Already Exists!'),
                                  );
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                  setState(() {
                                    isLoading = false;
                                  });
                                  Navigator.pop(context);
                                  return;
                                }

                                String imageURL =
                                    await _uploadImage(selectedImage!);

                                await _addCategoryToFirestore(
                                  user.uid,
                                  titleController.text,
                                  imageURL,
                                );

                                Navigator.pop(context);
                              },
                        width: size.width * 0.5,
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    titleController.dispose();
    super.dispose();
  }
}

Future<bool> _checkCategoryExists(String userId, String title) async {
  QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
      .instance
      .collection('users')
      .doc(userId)
      .collection('categories')
      .where('title', isEqualTo: title)
      .limit(1)
      .get();

  return snapshot.docs.isNotEmpty;
}

Future<String> _uploadImage(File imageFile) async {
  String fileName = DateTime.now().millisecondsSinceEpoch.toString();
  Reference reference =
      FirebaseStorage.instance.ref().child('images/$fileName');
  UploadTask uploadTask = reference.putFile(imageFile);
  TaskSnapshot snapshot = await uploadTask.whenComplete(() => null);
  String downloadURL = await snapshot.ref.getDownloadURL();
  return downloadURL;
}

Future<void> _addCategoryToFirestore(
    String userId, String title, String imageURL) async {
  DocumentReference<Map<String, dynamic>> docRef = FirebaseFirestore.instance
      .collection('users')
      .doc(userId)
      .collection('categories')
      .doc();

  await docRef.set({
    'title': title,
    'categoryID': docRef.id,
    'Date Added': DateTime.now(),
    'categoryImage': imageURL,
  });
}

///// U  P  D A T E     C A T E G O R Y   S E C T I O N
class UpdateCategoryBottomSheet extends StatefulWidget {
  const UpdateCategoryBottomSheet({super.key});

  @override
  State<UpdateCategoryBottomSheet> createState() =>
      _UpdateCategoryBottomSheetState();
}

class _UpdateCategoryBottomSheetState extends State<UpdateCategoryBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
