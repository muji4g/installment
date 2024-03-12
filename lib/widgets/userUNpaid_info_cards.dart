import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:installement1_app/model/granter_model.dart';
import 'package:installement1_app/model/userdetails_model.dart';
import 'package:installement1_app/theme/TextStyle.dart';
import 'package:installement1_app/theme/app_colors.dart';

class GreyText extends StatelessWidget {
  final String text;
  const GreyText({super.key, required this.text});

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

class LeftInfoColumn extends StatelessWidget {
  final String title;
  const LeftInfoColumn({super.key, required this.title});

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

class InfoSectionUnPaid extends StatelessWidget {
  const InfoSectionUnPaid({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LeftInfoColumn(
          title: 'Name.',
        ),
        LeftInfoColumn(
          title: 'Email.',
        ),
        LeftInfoColumn(
          title: 'Contact.',
        ),
        LeftInfoColumn(
          title: 'CNIC Number.',
        ),
        LeftInfoColumn(
          title: 'Address.',
        ),
      ],
    );
  }
}

class RightColumnInfo extends StatelessWidget {
  final bool
      copyButton; //we control where to show copy button just set the value to true to show it on other values too
  final String title;
  const RightColumnInfo({
    super.key,
    required this.title,
    required this.copyButton,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.only(bottom: size.height * 0.03),
      child: Row(
        children: [
          Row(
            children: [
              Text(
                title,
                style: customTextblack.copyWith(
                    fontSize: size.width * 0.03, fontWeight: FontWeight.w500),
              ),
              SizedBox(
                width: size.width * 0.025,
              ),
              GestureDetector(
                  onTap: () {
                    final snackbar = SnackBar(
                      content: Text(
                        'Copied To ClipBoard!',
                        style: customTextblack.copyWith(fontSize: 14),
                      ),
                      backgroundColor: white,
                      behavior: SnackBarBehavior.floating,
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackbar);
                    FlutterClipboard.copy(
                        title); // this function will copy any value passed to it as of now it copies title which is any value in the model that is fetched and can be copied
                    print(
                        'Copied To ClipBoard'); //to test if fucntion is being called
                  },
                  child: copyButton
                      ? Image.asset(
                          'assets/images/copy_Icon.png',
                          width: size.width * 0.038,
                        )
                      : Container())
            ],
          ),
        ],
      ),
    );
  }
}

class CustomerInfoCardUnpaid extends StatelessWidget {
  const CustomerInfoCardUnpaid({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(18)),
      child: Padding(
        padding: EdgeInsets.symmetric(
            vertical: size.height * 0.001, horizontal: size.width * 0.01),
        child: SizedBox(
          height: size.height * 0.26,
          child: ListView.builder(
              itemCount: detailsList.length,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: size.height * 0.016,
                      horizontal: size.width * 0.02),
                  child: Row(
                    children: [
                      const InfoSectionUnPaid(),
                      SizedBox(
                        width: size.width * 0.1,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RightColumnInfo(
                              title: detailsList[index].customerName,
                              copyButton: false),
                          RightColumnInfo(
                              title: detailsList[index].customerEmail,
                              copyButton: true),
                          RightColumnInfo(
                              title: detailsList[index].customerContact,
                              copyButton: true),
                          RightColumnInfo(
                              title: detailsList[index].customerNIC,
                              copyButton: true),
                          RightColumnInfo(
                              title: detailsList[index].customerAddress,
                              copyButton: false),
                        ],
                      )
                    ],
                  ),
                );
              }),
        ),
      ),
    );
  }
}
