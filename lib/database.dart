import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  Future addUserInfoToDBUser(String userId, Map<String, dynamic> userInfoMap) {
    return FirebaseFirestore.instance
        .collection("users")
        .doc(userId)
        .set(userInfoMap);
  }

  Future AddProduct(String category, String discount, String id, String name,
      int int_price, int int_quan, String url) {
    Map<String, dynamic> userInfoMap = {
      "id": id,
      "name": name,
      "discount": discount,
      "price": int_price,
      "quantity": int_quan,
      "url": url,
      "category": category
    };
    return FirebaseFirestore.instance
        .collection("Categories")
        .doc(category)
        .set({
      "data": FieldValue.arrayUnion([userInfoMap])
    }, SetOptions(merge: true));
  }
}
