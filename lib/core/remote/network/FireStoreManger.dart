import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently_c15_flutter/model/User.dart';

class FireStoreManger {
   static CollectionReference<User> accessUserCollection() {
   var UsersCollection= FirebaseFirestore.instance
        .collection("Users")
        .withConverter(
          fromFirestore: (snapshot, options){
            Map<String, dynamic>? data = snapshot.data(); // get Map
            return User.fromFireStore(data); // return Object
          },
          toFirestore: (user, options) {
            return user.toFireStore(); // get Object and return Map
          },
        );
   return UsersCollection;
  }

 static Future<void> saveUser(User user) {
    var collection = accessUserCollection();
    var document= collection.doc(user.id); // create a document with id
     return document.set(user);
  }
}
