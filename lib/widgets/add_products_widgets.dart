import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';

class ImageAdd extends StatefulWidget {
  const ImageAdd({super.key});

  @override
  State<ImageAdd> createState() => _ImageAddState();
}

class _ImageAddState extends State<ImageAdd> {
  File? SelectedImage;
  // bool isImageUploaded = false;
  // XFile? pickedImage;
  // final picker = ImagePicker();

  // Future<void> pickImageFromGallery() async {
  //   print('function called');
  //   XFile? file = await picker.pickImage(source: ImageSource.gallery);

  //   setState(() {
  //     pickedImage = file;
  //     isImageUploaded = true;
  //   });
  // }

  // Implement sending image logic}
  @override
  Widget build(BuildContext context) {
    Future<void> pickImage() async {
      final picker = ImagePicker();
      final pickedImage = await picker.pickImage(source: ImageSource.gallery);
      if (pickedImage != null) {
        setState(() {
          SelectedImage = File(pickedImage.path);
        });
      }
    }

    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width * .3,
      height: size.height * .15,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            offset: const Offset(
              1,
              4.0,
            ),
            blurRadius: 9.0,
            spreadRadius: 0.0,
          ), //BoxShadow
        ],
      ),
      child: TextButton(
        onPressed: () {
          pickImage();
        },
        child: SelectedImage != null
            ? Image.file(SelectedImage!)
            : SvgPicture.asset('assets/images/addCategory.svg'),
      ),
    );
  }
}

////////////////////////PRODUCT INFO Area//////////////////////////////
class ProductInfo extends StatefulWidget {
  const ProductInfo({super.key});

  @override
  State<ProductInfo> createState() => _ProductInfoState();
}

class _ProductInfoState extends State<ProductInfo> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: ),
    );
  }
}
