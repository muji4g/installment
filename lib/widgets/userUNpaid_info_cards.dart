import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:installement1_app/model/installments_model.dart';
import 'package:installement1_app/model/products_model.dart';
import 'package:installement1_app/model/userdetails_model.dart';
import 'package:installement1_app/theme/TextStyle.dart';

import 'package:installement1_app/theme/app_colors.dart';

class GreyText extends StatelessWidget {
  final String text;
  const GreyText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Text(
      text,
      style: customTextgrey.copyWith(
          fontSize: size.width * 0.03, fontWeight: FontWeight.bold),
    );
  }
}
//Below is the code related to Info cards of USER PAID!!! in Customers page ONLY! READ COMMENTS FOR DETAILS
//CLOSE THE CODE SECTION USING > ARROW IF USING VISUAL STUDIO CODE BETTER READABILITY

///////////////////////////////////////////////////////
//this Section Has the Type Of Detail i.e Name, ID etc
/////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////
///the widget below is responsible for setting font Size and color for the type name of details like customerID, Name etc
////////
class TextTile extends StatelessWidget {
  final String title;
  const TextTile({super.key, required this.title});

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

///////////////////////////////////////////////////////////////
////The above widget is called below and the values are passed throught the widget below!!
/////////////////////////////////////////////////////////
class InfoSectionPaid extends StatelessWidget {
  const InfoSectionPaid({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextTile(
          title: 'Name.',
        ),
        TextTile(
          title: 'Email.',
        ),
        TextTile(
          title: 'Contact.',
        ),
        TextTile(
          title: 'CNIC Number.',
        ),
        TextTile(
          title: 'Address.',
        ),
      ],
    );
  }
}
/////Section ENDS HERE/////////////////////////////

///////////////////////////////////////////////////////////////////////////////////////////////////////
//this section will be used to call the detail from the model and controls the color of the ID number AND also controls the Copy Button//
///////////////////////////////////////////////////////////////////////////////////////////////////////
///The purpose of the widget below is control the color of customer ID and to control where to show copy button///
////////////
class InfoTextUnpaid extends StatelessWidget {
  final bool
      copyButton; //we control where to show copy button just set the value to true to show it on other values too
  final String title;
  const InfoTextUnpaid({
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
                    fontSize: size.width * 0.03,
                    fontWeight: FontWeight
                        .w500), // here the color of Customer ID is being Controlled!!!!
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

////the final values from the widget above are passed to this widget and this widget is later used to show values on the mobile Screen
class DetailSection extends StatelessWidget {
  //this will control the color of the id
  final bool
      showCopy; //this controls the items that can be copied basically setting value to true will result the button to be shown anywhere needed
  final String
      modelType; //this displays the detials like Name id number etc infront of the corresponding Type
  const DetailSection(
      {super.key, required this.modelType, required this.showCopy});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InfoTextUnpaid(
          copyButton: showCopy,
          title: modelType,
        ),
      ],
    );
  }
}

///THE ABOVE SECTION  ENDS HERE//////
///
///Below Is the Final Widget that display results on the Screen///////////////
///
///CUSTOMER INFO CARD//////////////////////////////////////////////////
class CustomerInfoCardUnpaid extends StatelessWidget {
  const CustomerInfoCardUnpaid({
    super.key,
  });

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
          height: size.height * 0.25,
          child: ListView.builder(
            //the reason we use list View is simple: we can control the lenght and we can easily add items in future
            physics:
                const NeverScrollableScrollPhysics(), //disables scroll effect
            itemCount: detailsList.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.symmetric(
                    vertical: size.height * 0.01,
                    horizontal: size.width * 0.02),
                child: Row(
                  children: [
                    //this Column shows TYPE of detial like Customer ID, Customer Name, Customer Email
                    const Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InfoSectionPaid(), //shows TYPE of detial like Customer ID, Customer Name, Customer Email
                      ],
                    ),
                    SizedBox(
                      width: size.width * 0.1,
                    ),
                    //This column fetches values from the model and displays it infront of the corresponding type
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        DetailSection(
                          showCopy: false,
                          modelType: detailsList[index].customerName,
                        ),
                        DetailSection(
                          showCopy: true,
                          modelType: detailsList[index].customerEmail,
                        ),
                        DetailSection(
                          showCopy: true,
                          modelType: detailsList[index].customerContact,
                        ),
                        DetailSection(
                          showCopy: true,
                          modelType: detailsList[index].customerNIC,
                        ),
                        DetailSection(
                          showCopy: false,
                          modelType: detailsList[index].customerAddress,
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

///NOTE THAT TWO COLUMNS WERE USED TO ALIGN THE TYPE OF DETAIL AND DETAIL ITSELF HORIZONTALLY!!!!!//////
////////////////////////////////////////Section ENDS HERE//////////////////////////////////////////////
/////////////////////////Product Info Section/////////////////////////////////
class ProductInfo extends StatelessWidget {
  const ProductInfo({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(18)),
      height: size.height * 0.09,
      child: ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(14),
          child: productList[2].productImage,
        ),
        title: Text(
          detailsList[0].order,
          style: customTextblack.copyWith(fontSize: size.width * 0.035),
        ),
        subtitle: Text(
          productList[1].productPrice,
          style: customTextblue.copyWith(fontSize: size.width * 0.035),
        ),
        trailing: Text(
          'x' + detailsList[0].quantity,
          style: customTextgrey.copyWith(fontSize: size.width * 0.04),
        ),
      ),
    );
  }
}

/////////////////////////////////////////////////////////////////////////////////
/////////////////////PRODUCT INFO SECTION ENDS HERE//////////////////////////////
/////////////////////////////////////////////////////////////////////////////////
///
/////////////////////////////////////////////////////////////////////////////////
/////////////////////INSTALLMENT PLAN SECTION STARTS HERE////////////////////////////////////
///
class InstallmentPlan extends StatelessWidget {
  const InstallmentPlan({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(18)),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.01),
        child: SizedBox(
            height: size.height * 0.3,
            child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: installments.length,
                itemBuilder: (context, int index) {
                  return Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: size.height * 0.006,
                          horizontal: size.width * 0.005),
                      child: Column(
                        children: [
                          TextRow(
                              isTotal: false,
                              title: 'Instalment Duration',
                              type: installments[index].installemtnPlanwords[0],
                              value: '3'),
                          PaymentDetailRow(
                              isPaid: false,
                              month: installments[index].planMonths[index],
                              datePaid: installments[index].paymentDate,
                              amount: installments[index].amount)
                        ],
                      ));
                })),
      ),
    );
  }
}

//This widget is responsible for First Blue container and the total amount value in the Installment Plan Widget
class TextRow extends StatelessWidget {
  final String type;
  final String value;
  final String title;
  final bool isTotal;
  TextRow(
      {super.key,
      required this.isTotal,
      required this.type,
      required this.title,
      required this.value});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: isTotal == false
          ? Container(
              width: size.width * 1.2,
              height: size.height * 0.05,
              decoration: BoxDecoration(
                  color: primaryBlue.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.03),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(title,
                        style: customTextblue.copyWith(
                            fontSize: size.width * 0.035)),
                    Row(
                      children: [
                        Text(
                          value,
                          style: customTextblue.copyWith(
                              fontSize: size.width * 0.035),
                        ),
                        SizedBox(
                          width: size.width * 0.007,
                        ),
                        Text(type,
                            style: customTextblue.copyWith(
                                fontSize: size.width * 0.035))
                      ],
                    )
                  ],
                ),
              ),
            )
          : Row(
              children: [
                Text(
                  title,
                  style: customTextgrey.copyWith(
                      fontSize: size.width * 0.04, fontWeight: FontWeight.bold),
                ),
                Text(
                  value,
                  style: customTextgrey.copyWith(
                      fontSize: size.width * 0.04, fontWeight: FontWeight.bold),
                ),
              ],
            ),
    );
  }
}

///This widget shows the Payment Details including Month and other details.....
class PaymentDetailRow extends StatelessWidget {
  final String month;
  final String datePaid;
  final bool isPaid;
  final double amount;
  const PaymentDetailRow(
      {super.key,
      required this.isPaid,
      required this.month,
      required this.datePaid,
      required this.amount});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return isPaid == false
        ? Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                month,
                style: customTextgrey.copyWith(fontSize: size.width * 0.035),
              ),
              Text(
                amount.toString(),
                style: customTextgrey.copyWith(fontSize: size.width * 0.035),
              ),
              Text(
                datePaid,
                style: customTextgrey.copyWith(fontSize: size.width * 0.035),
              ),
            ],
          )
        : Text('This is A row');
  }
}
