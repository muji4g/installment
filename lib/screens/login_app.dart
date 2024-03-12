import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:installement1_app/screens/dashboard_page.dart';
import 'package:installement1_app/screens/signup_page.dart';
import 'package:installement1_app/theme/Textstyle.dart';
import 'package:installement1_app/widgets/FormFields.dart';
import 'package:installement1_app/widgets/bottomNavigationBar.dart';
import 'package:installement1_app/widgets/buttons.dart';

class LoginApp extends StatefulWidget {
  const LoginApp({super.key});

  @override
  State<LoginApp> createState() => _LoginAppState();
}

class _LoginAppState extends State<LoginApp> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  ScrollController scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0.0,
        backgroundColor: Colors.transparent,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 7.0),
            child: TextBtn(
              onPressedFunction: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => SignUpApp()),
                    (route) => false);
              },
              btntxt:
                  'Sing Up', //this buttons state might need to be changed with provider
              fontsize: 0.035,
            ),
          ),
        ],
      ),
      bottomNavigationBar: const Padding(
        padding: EdgeInsets.all(8.0),
        child: TermsAndConditions(),
      ),
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        controller: scrollController,
        child: Padding(
          padding: EdgeInsets.only(top: size.height * 0.04),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                  child: SvgPicture.asset(
                'assets/images/logo_blue.svg',
                width: size.width * .30,
              )),
              SizedBox(
                height: size.height * .025,
              ),
              Center(
                child: Text(
                  'Sign In',
                  style: customTextblack.copyWith(
                    fontSize: size.width * 0.052,
                    fontWeight:
                        FontWeight.lerp(FontWeight.w900, FontWeight.w900, 1),
                  ),
                ),
              ),
              Center(
                child: SizedBox(
                  width: size.width * 0.65,
                  child: Text(
                    'lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc vulputate libero ',
                    style: customTextblack.copyWith(
                        fontSize: size.width * 0.0235,
                        color: Color(0xff9F9F9F)),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              SizedBox(
                height: size.height * .030,
              ),
              SizedBox(
                  width: size.width * 0.9,
                  child: FormFields(
                      obscuretext: false,
                      formController: emailController,
                      hinttxt: 'Email')),
              SizedBox(
                height: size.width * 0.06,
              ),
              SizedBox(
                  width: size.width * 0.9,
                  child: FormFields(
                      obscuretext: true,
                      formController: passwordController,
                      visibilityIcon: IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.visibility_off,
                            color: Colors.grey,
                          )),
                      hinttxt: 'Password')),
              Padding(
                padding: EdgeInsets.only(left: size.width * .55, top: 2),
                child: TextBtn(
                  btntxt: 'Reset Password?',
                  fontsize: 0.040,
                  onPressedFunction: () {
                    // showModalBottomSheet<void>(
                    //   context: context,
                    //   builder: (BuildContext context) {
                    //     return
                    //   },
                    // );
                  },
                ),
              ),
              SizedBox(
                height: size.width * 0.05,
              ),
              PrimaryBtn(
                btntxt: 'Sign In',
                width: size.width * 0.9,
                onPressedFunction: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => btmNavBar()));
                },
              ),
              SizedBox(
                height: size.width * 0.05,
              ),
              Text(
                'or',
                style: customTextgrey.copyWith(fontSize: size.width * 0.03),
              ),
              SizedBox(
                height: size.width * 0.05,
              ),
              const SecondayBtn(
                btntxt: 'Sign In With Google',
              ),
              SizedBox(
                height: size.width * 0.04,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose

    scrollController.dispose();
    super.dispose();
  }
}
