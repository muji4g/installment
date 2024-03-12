import 'package:flutter/material.dart';
import 'package:installement1_app/screens/login_app.dart';
import 'package:installement1_app/theme/Textstyle.dart';
import 'package:installement1_app/widgets/FormFields.dart';

import '../widgets/buttons.dart';

class SignUpApp extends StatefulWidget {
  const SignUpApp({super.key});

  @override
  State<SignUpApp> createState() => _SignUpAppState();
}

class _SignUpAppState extends State<SignUpApp> {
  TextEditingController fullnameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController contactController = TextEditingController();
  TextEditingController storeNameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController createPassController = TextEditingController();
  TextEditingController confirmPassController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Register',
            style: customTextblack.copyWith(
                fontSize: size.width * .06, fontWeight: FontWeight.w900),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 7.0),
              child: TextBtn(
                onPressedFunction: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => const LoginApp()),
                      (route) => false);
                },
                btntxt: 'Sing In',
                fontsize: 0.035,
              ),
            ),
          ]),
      body: Padding(
        padding: const EdgeInsets.only(top: 25),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FormFields(
                    formController: fullnameController,
                    obscuretext: false,
                    hinttxt: 'Full Name'),
                SizedBox(
                  height: size.height * .011,
                ),
                FormFields(
                    formController: emailController,
                    obscuretext: false,
                    hinttxt: 'Email'),
                SizedBox(
                  height: size.height * .011,
                ),
                FormFields(
                    formController: contactController,
                    obscuretext: false,
                    hinttxt: 'Contact'),
                SizedBox(
                  height: size.height * .011,
                ),
                FormFields(
                    formController: storeNameController,
                    obscuretext: false,
                    hinttxt: 'Store Name'),
                SizedBox(
                  height: size.height * .011,
                ),
                FormFields(
                    formController: addressController,
                    obscuretext: false,
                    hinttxt: 'Address'),
                SizedBox(
                  height: size.height * .011,
                ),
                FormFields(
                    formController: createPassController,
                    obscuretext: true,
                    hinttxt: 'Create Password'),
                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Text(
                    'password as unique as you are your gateway to secure and seamless access.',
                    style:
                        customTextgrey.copyWith(fontSize: size.width * 0.025),
                  ),
                ),
                SizedBox(
                  height: size.height * .013,
                ),
                FormFields(
                    formController: confirmPassController,
                    obscuretext: true,
                    hinttxt: 'Confirm Password'),
                SizedBox(
                  height: size.height * .05,
                ),
                PrimaryBtn(
                  width: size.width * 0.9,
                  btntxt: 'Sign Up',
                  onPressedFunction: () {},
                ),
                SizedBox(
                  height: size.height * .02,
                ),
                Text(
                  'or',
                  style: customTextgrey.copyWith(fontSize: size.width * 0.03),
                ),
                SizedBox(
                  height: size.height * .02,
                ),
                const SecondayBtn(
                  btntxt: 'Sign In With Google',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
