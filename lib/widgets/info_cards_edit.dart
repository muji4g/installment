import 'package:flutter/material.dart';
import 'package:installement1_app/model/customer_model.dart';
import 'package:installement1_app/model/userdetails_model.dart';
import 'package:installement1_app/theme/TextStyle.dart';
import 'package:installement1_app/theme/app_colors.dart';

class EditCustomerInfo extends StatefulWidget {
  const EditCustomerInfo({super.key});

  @override
  State<EditCustomerInfo> createState() => _EditCustomerInfoState();
}

class _EditCustomerInfoState extends State<EditCustomerInfo> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      decoration:
          BoxDecoration(color: white, borderRadius: BorderRadius.circular(18)),
      child: Padding(
        padding: EdgeInsets.symmetric(
            vertical: size.height * 0.001, horizontal: size.width * 0.01),
        child: SizedBox(
          height: size.height * 0.3,
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
                        InfoSectionEdit(), //shows TYPE of detial like Customer ID, Customer Name, Customer Email
                      ],
                    ),
                    SizedBox(
                      width: size.width * 0.1,
                    ),
                    //This column fetches values from the model and displays it infront of the corresponding type
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            DetailSection(
                              // SETTING THIS TO TRUE WILL SIMPLY SHOW COPY BUTTON BTN IFRONT OF ID
                              modelType: detailsList[index].customerID,
                              showID: true, //CONTROLSS THE COLOR OF ID
                            ),
                          ],
                        ),
                        DetailSection(
                          modelType: detailsList[index].customerName,
                          showID: false,
                        ),
                        DetailSection(
                          modelType: detailsList[index].customerEmail,
                          showID: false,
                        ),
                        DetailSection(
                          modelType: detailsList[index].customerContact,
                          showID: false,
                        ),
                        DetailSection(
                          modelType: detailsList[index].customerNIC,
                          showID: false,
                        ),
                        DetailSection(
                          modelType: detailsList[index].customerAddress,
                          showID: false,
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

//////////widgets used above are below/////////////////////////
class DetailSection extends StatelessWidget {
  final bool showID; //this will control the color of the id
  //this controls the items that can be copied basically setting value to true will result the button to be shown anywhere needed
  final String
      modelType; //this displays the detials like Name id number etc infront of the corresponding Type
  const DetailSection({
    super.key,
    required this.showID,
    required this.modelType,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        EditInfoText(
          isCustomerID: showID,
          title: modelType,
        ),
      ],
    );
  }
}

//////////////////////////////
class EditInfoText extends StatelessWidget {
  final bool isCustomerID;
  //we control where to show copy button just set the value to true to show it on other values too
  final String title;
  const EditInfoText({
    super.key,
    required this.title,
    required this.isCustomerID,
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
                style: isCustomerID
                    ? customTextblue.copyWith(
                        fontSize: size.width * 0.03,
                        fontWeight: FontWeight.w500)
                    : customTextblack.copyWith(
                        fontSize: size.width * 0.03,
                        fontWeight: FontWeight
                            .w500), // here the color of Customer ID is being Controlled!!!!
              ),
              SizedBox(
                width: size.width * 0.025,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/////////////////////info sections///////////////////
///class InfoSectionPaid extends StatelessWidget {
class InfoSectionEdit extends StatelessWidget {
  const InfoSectionEdit({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DetailTitle(
          title: 'Customer ID.',
        ),
        DetailTitle(
          title: 'Name.',
        ),
        DetailTitle(
          title: 'Email.',
        ),
        DetailTitle(
          title: 'Contact.',
        ),
        DetailTitle(
          title: 'CNIC Number.',
        ),
        DetailTitle(
          title: 'Address.',
        ),
      ],
    );
  }
}

class DetailTitle extends StatelessWidget {
  final String title;
  const DetailTitle({super.key, required this.title});

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
