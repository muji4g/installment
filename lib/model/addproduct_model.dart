import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:installement1_app/controller/add_product_controller.dart';

class AddProductModel {
  Future<Map<String, String>> fetchCategories() async {
    try {
      String userId = FirebaseAuth.instance.currentUser!.uid;

      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await FirebaseFirestore.instance
              .collection('users')
              .doc(userId)
              .collection('categories')
              .get();

      // Fetching the items of categories as String:
      Map<String, String> categories = {};
      querySnapshot.docs.forEach((doc) {
        categories[doc.id] = doc['title'];
      });
      return categories;
    } catch (e) {
      throw Exception('Error fetching categories: $e');
    }
  }

  Future<String> addProductToFirestore(AddProducts product,
      List<String> imageUrls, String selectedCategory) async {
    User? user = FirebaseAuth.instance.currentUser;
    try {
      CollectionReference products = FirebaseFirestore.instance
          .collection('users')
          .doc(user!.uid)
          .collection('products');

      // Generate a document ID for the product
      var newProductRef = await products.add({
        'title': product.productName,
        'price': product.productPrice,
        'quantity': product.quantity,
        'description': product.description,
        'images': imageUrls, // Save the image URLs
        'Date Added On': DateTime.now(),
        'category': selectedCategory,
        'titlelowercase': product.productName.toLowerCase(),
        'titleuppercase': product.productName.toUpperCase()
      });

      // Retrieve the generated document ID
      return newProductRef.id;
    } catch (e) {
      throw Exception('Error adding product: $e');
    }
  }
}
//   Future<String> addProductToFirestore(AddProducts product) async {
//     User? user = FirebaseAuth.instance.currentUser;
//     try {
//       CollectionReference products = FirebaseFirestore.instance
//           .collection('users')
//           .doc(user!.uid)
//           .collection('products');

//       // Generate a document ID for the product
//       var newProductRef = await products.add({
//         'title': product.productName,
//         'price': product.productPrice,
//         'quantity': product.quantity,
//         'description': product.description,
//         'images': '',
//         'Date Added On': DateTime.now()
//       });

//       // Retrieve the generated document ID
//       return newProductRef.id;
//     } catch (e) {
//       throw Exception('Error adding product: $e');
//     }
//   }
// }
