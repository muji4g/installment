import 'package:flutter/material.dart';

class ReSetBottomSheet extends StatefulWidget {
  const ReSetBottomSheet({super.key});

  @override
  State<ReSetBottomSheet> createState() => _ReSetBottomSheetState();
}

class _ReSetBottomSheetState extends State<ReSetBottomSheet> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        color: Colors.white,
      ),
      height: size.height * .35,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const Text('Modal BottomSheet'),
            ElevatedButton(
              child: const Text('Close BottomSheet'),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }
}
