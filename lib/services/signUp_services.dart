import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

void signUpuser(String userName, String userEmail, String userContact,
    String storeName, String userAddress, String userPassword) async {
  User? userID = FirebaseAuth.instance.currentUser;
  try {
    FirebaseFirestore.instance.collection('users').doc(userID?.uid).set({
      'UserId': userID?.uid,
      'FullName': userName,
      'Email': userEmail,
      'ContactNum': userContact,
      'StoreName': storeName,
      'password': userPassword,
      'Adddress': userAddress,
      'Account Created On': DateTime.now(),
    });
  } on FirebaseAuthException catch (e) {
    print('Error $e');
  }
}
