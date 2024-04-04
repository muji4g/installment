import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:installement1_app/widgets/product_details_widgets.dart';

class ProductService {
  final CollectionReference productsCollection =
      FirebaseFirestore.instance.collection('users');

  Future<DocumentSnapshot<Map<String, dynamic>>> getProductDetails(
      String userId, String productId) async {
    return await productsCollection
        .doc(userId)
        .collection('products')
        .doc(productId)
        .get();
  }
}
