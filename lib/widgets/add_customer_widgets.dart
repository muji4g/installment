import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:installement1_app/model/customer_model.dart';
import 'package:installement1_app/theme/TextStyle.dart';

class InfoTypeTile extends StatelessWidget {
  final String title;
  const InfoTypeTile({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.only(bottom: size.height * 0.03),
      child: Text(
        title,
        style: customTextgrey.copyWith(fontSize: size.width * 0.03),
      ),
    );
  }
}

/////////////TEXT FORM FIELD /////////////////////////
class TextFormAdd extends StatelessWidget {
  // final TextEditingController controller;
  final String hinttext;
  final String labeltext;
  const TextFormAdd({
    super.key,
    required this.hinttext,
    required this.labeltext,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          width: size.width * 0.22,
          child: Text(
            labeltext,
            style: customTextgrey.copyWith(fontSize: size.width * 0.03),
          ),
        ),
        SizedBox(
          width: size.width * 0.11,
        ),
        Expanded(
          child: TextField(
            // controller: controller,
            textAlign: TextAlign.left,
            keyboardType: hinttext == 'Customer ID'
                ? TextInputType.number
                : hinttext == 'Contact.'
                    ? TextInputType.number
                    : hinttext == 'CNIC Number.'
                        ? const TextInputType.numberWithOptions()
                        : TextInputType.multiline,
            style: hinttext == 'Customer ID'
                ? customTextblue.copyWith(fontSize: size.width * 0.03)
                : customTextblack.copyWith(fontSize: size.width * 0.03),
            decoration: InputDecoration(
                border: InputBorder.none,
                hintText: hinttext,
                hintStyle:
                    customTextgrey.copyWith(fontSize: size.width * 0.03)),
          ),
        )
      ],
    );
  }
}

////////////////////////////////Customer Info adding Container//////////////////
class AddCustomerInfoCard extends StatelessWidget {
  const AddCustomerInfoCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(18)),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.01),
        child: SizedBox(
          height: size.height * 0.32,
          child: ListView.builder(
            //the reason we use list View is simple: we can control the lenght and we can easily add items in future
            physics:
                const NeverScrollableScrollPhysics(), //disables scroll effect
            itemCount: 1,
            itemBuilder: (context, index) {
              return Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: size.height * 0.005,
                      horizontal: size.width * 0.01),
                  child: const Column(
                    children: [
                      TextFormAdd(
                          hinttext: 'Customer ID', labeltext: 'Customer ID'),
                      TextFormAdd(
                          hinttext: 'Enter Name Here', labeltext: 'Name.'),
                      TextFormAdd(hinttext: 'Email.', labeltext: 'Email'),
                      TextFormAdd(hinttext: 'Contact.', labeltext: 'Contact'),
                      TextFormAdd(
                          hinttext: 'CNIC Number.', labeltext: 'CNIC number'),
                      TextFormAdd(hinttext: 'Address.', labeltext: 'Address'),
                    ],
                  ));
            },
          ),
        ),
      ),
    );
  }
}

///////////////////////////////////////////////////////////
//////////////////Add Granter Info Section////////////////
/////////////////////////////////////////////////////////
class AddGranterInfo extends StatelessWidget {
  const AddGranterInfo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(18)),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.01),
        child: SizedBox(
          height: size.height * 0.27,
          child: ListView.builder(
            //the reason we use list View is simple: we can control the lenght and we can easily add items in future
            physics:
                const NeverScrollableScrollPhysics(), //disables scroll effect
            itemCount: 1,
            itemBuilder: (context, index) {
              return Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: size.height * 0.005,
                      horizontal: size.width * 0.01),
                  child: const Column(
                    children: [
                      TextFormAdd(
                          hinttext: 'Enter Name Here', labeltext: 'Name.'),
                      TextFormAdd(hinttext: 'Email.', labeltext: 'Email'),
                      TextFormAdd(hinttext: 'Contact.', labeltext: 'Contact'),
                      TextFormAdd(
                          hinttext: 'CNIC Number.', labeltext: 'CNIC number'),
                      TextFormAdd(hinttext: 'Address.', labeltext: 'Address'),
                    ],
                  ));
            },
          ),
        ),
      ),
    );
  }
}
