import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:installement1_app/model/installments_model.dart';
import 'package:installement1_app/theme/TextStyle.dart';
import 'package:installement1_app/theme/app_colors.dart';

class LowOpacityText extends StatelessWidget {
  final String text;
  const LowOpacityText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Opacity(
      opacity: 0.4,
      child: Text(
        text,
        style: customTextblack.copyWith(
            fontSize: size.width * 0.034, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class ImageAdd extends StatefulWidget {
  const ImageAdd({super.key});

  @override
  State<ImageAdd> createState() => _ImageAddState();
}

class _ImageAddState extends State<ImageAdd> {
  File? SelectedImage;
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
      width: size.width * .29,
      height: size.height * .13,
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
        style: ButtonStyle(
          splashFactory: InkRipple.splashFactory,
          overlayColor: MaterialStateColor.resolveWith((states) => primaryBlue),
        ),
        onPressed: () {
          pickImage();
        },
        child: SelectedImage != null
            ? Image.file(SelectedImage!)
            : SvgPicture.asset(
                'assets/images/addCategory.svg',
                width: size.width * 0.3,
              ),
      ),
    );
  }
}

////////////////////////PRODUCT INFO Area//////////////////////////////
class ProductInfo extends StatefulWidget {
  final String title;
  final String price;
  final String quantity;

  const ProductInfo(
      {super.key,
      required this.title,
      required this.price,
      required this.quantity});

  @override
  State<ProductInfo> createState() => _ProductInfoState();
}

class _ProductInfoState extends State<ProductInfo> {
  @override
  Widget build(BuildContext context) {
    final String title = widget.title;
    final String price = widget.price;
    final String quantity = widget.quantity;
    Size size = MediaQuery.of(context).size;

    return Container(
        decoration: BoxDecoration(
          color: white,
          borderRadius: BorderRadius.circular(18),
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
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: size.width * 0.05, vertical: size.height * 0.015),
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(
                  hintText: title,
                  border: InputBorder.none,
                  hintStyle:
                      customTextgrey.copyWith(fontSize: size.width * 0.035),
                ),
              ),
              TextFormField(
                keyboardType: const TextInputType.numberWithOptions(),
                decoration: InputDecoration(
                  hintText: quantity,
                  border: InputBorder.none,
                  hintStyle: customTextgrey.copyWith(
                    fontSize: size.width * 0.035,
                  ),
                ),
              ),
              TextFormField(
                keyboardType: const TextInputType.numberWithOptions(),
                decoration: InputDecoration(
                  hintText: price,
                  border: InputBorder.none,
                  hintStyle:
                      customTextgrey.copyWith(fontSize: size.width * 0.035),
                ),
              ),
            ],
          ),
        ));
  }
}
/////////////////////////////////////////////
//////Installment Plan Section//////////////
///////////////////////////////////////////

class InstallmentPlanSection extends StatelessWidget {
  const InstallmentPlanSection({super.key});

  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;
    return Container(
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
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const BluebgContainer(),
            RadioButton(),
          ],
        ),
      ),
    );
  }
}

///reuseble blue background Container/////
class BluebgContainer extends StatelessWidget {
  const BluebgContainer({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        color: primaryBlue.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'EMI',
              style: customTextblue.copyWith(
                  fontSize: size.width * 0.032,
                  color: primaryBlue.withOpacity(0.7)),
            ),
            Text(
              'Monthly Installment',
              style: customTextblue.copyWith(
                  fontSize: size.width * 0.032,
                  color: primaryBlue.withOpacity(0.7)),
            ),
          ],
        ),
      ),
    );
  }
}

//////////////////////////////////
/////Re use able Radio Button////
////////////////////////////////
class RadioButton extends StatefulWidget {
  // final num val;

  RadioButton({
    super.key,
  });

  @override
  State<RadioButton> createState() => _RadioButtonState();
}

class _RadioButtonState extends State<RadioButton> {
  String? selectedValue = 'value';
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // String? selectedValue =
    //     'value'; // Initialize with the index of the initially selected radio button (if any)

    return SizedBox(
      height: size.height * 0.2,
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        itemCount: installments[1].installmentPlan.length,
        itemBuilder: (context, index) => ListTile(
          title: Row(
            children: [
              Text(installments[1].installmentPlan[index]),
              SizedBox(width: size.width * 0.01),
              Text(installments[2].installemtnPlanwords[0]),
            ],
          ),
          leading: Radio(
            value: installments[1].installmentPlan[index],
            groupValue:
                selectedValue, // Use selectedValue as the consistent groupValue
            onChanged: (value) {
              setState(() {
                selectedValue = value;
                // Cast value to int explicitly
              });
            },
            activeColor: primaryBlue,
          ),
        ),
      ),
    );
  }
}

////////////////////////////////////////////////////////////////////////////////////
/////////////////////////About product SECTION//////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////
class Description extends StatelessWidget {
  const Description({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: size.width * 0.04,
        ),
        child: TextField(
          maxLines: null,
          decoration: InputDecoration(
            hintText: 'Description',
            border: InputBorder.none,
            hintStyle: customTextgrey.copyWith(fontSize: size.width * 0.035),
          ),
        ),
      ),
    );
  }
}
