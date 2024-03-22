import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:installement1_app/theme/app_colors.dart';
import 'package:installement1_app/widgets/appbar_secondary.dart';
import 'package:installement1_app/widgets/buttons.dart';

class TermsConditions extends StatefulWidget {
  const TermsConditions({Key? key}) : super(key: key);

  @override
  _TermsConditionsState createState() => _TermsConditionsState();
}

class _TermsConditionsState extends State<TermsConditions> {
  InAppWebViewController? webViewController;
  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(75),
          child: AppBarSecondary(
              showLeading: true,
              showMenu: false,
              isarrowLeading: false,
              onPressed: () {
                Navigator.pop(context);
              },
              title: 'Terms & Conditions')),
      body: Column(
        children: [
          SizedBox(height: 16), // Add desired space between header and webview
          Expanded(
            child: Stack(
              children: [
                InAppWebView(
                  initialUrlRequest: URLRequest(
                    url: WebUri('https://www.google.com/'),
                  ),
                  onWebViewCreated: (controller) {
                    webViewController = controller;
                  },
                  onLoadStart: (controller, url) {
                    setState(() {
                      isLoading = true;
                    });
                  },
                  onLoadStop: (controller, url) {
                    setState(() {
                      isLoading = false;
                    });
                  },
                ),
                if (isLoading)
                  const Center(
                    child: SpinKitCircle(
                      color: primaryBlue,
                      size: 50,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
