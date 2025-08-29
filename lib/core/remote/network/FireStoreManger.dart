import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently_c15_flutter/model/Event.dart';
import 'package:evently_c15_flutter/model/User.dart';

class FireStoreManger {
  //access collections in fire Store
  static CollectionReference<User> accessUserCollection() {
    var UsersCollection = FirebaseFirestore.instance
        .collection("Users")
        .withConverter(
          fromFirestore: (snapshot, options) {
            Map<String, dynamic>? data = snapshot.data(); // get Map
            return User.fromFireStore(data); // return Object
          },
          toFirestore: (user, options) {
            return user.toFireStore(); // get Object and return Map
          },
        );
    return UsersCollection;
  }

  static CollectionReference<Event> accessEventsCollection() {
    var collection = FirebaseFirestore.instance
        .collection("Events")
        .withConverter(
          fromFirestore: (snapshot, options) {
            return Event.fromFireStore(snapshot);
          },
          toFirestore: (event, options) {
            return event.toFirestore();
          },
        );
    return collection;
  }

  //save and get documents on firestore

  static Future<void> saveUser(User user) {
    var collection = accessUserCollection();
    var document = collection.doc(user.id); // create a document with id
    return document.set(user);
  }

  static saveEvent(Event event) {
    var collection = accessEventsCollection();
    var doc_ref = collection.doc();
    event.id = doc_ref.id;
    return doc_ref.set(event);
  }

  static Future<User?> getUSer(String uid) async {
    var collection = accessUserCollection();
    var docSnap = await collection.doc(uid).get();
    return docSnap.data();
  }

  static Future<List<Event>> getAllEvents() async {
    var collection = accessEventsCollection();
    var querysnapshot = await collection.get();
    var docs = querysnapshot.docs;
    List<Event> events= docs.map((doc) {
      return doc.data();
    }).toList();
    return events;
  }
}
