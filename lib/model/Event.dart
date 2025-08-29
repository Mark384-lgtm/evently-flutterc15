import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Event {
  String? id;
  String? type;
  String? title;
  String? description;
  Timestamp? date;
  double? longitude;
  double? latitude;

  Event({
    this.id,
    this.type,
    this.title,
    this.description,
    this.date,
    this.latitude,
    this.longitude,
  });

  Event.fromFireStore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
  ) {
    var data = snapshot.data();
    id= data?["id"];
    type= data?["type"];
    title= data?["title"];
    description= data?["description"];
    date= data?["date"];
    latitude= data?["latitude"];
    longitude= data?["longitude"];
  }

  Map<String,dynamic> toFirestore(){
    return {
      "id":id,
      "type":type,
      "title":title,
      "description":description,
      "longitude":longitude,
      "latitude":latitude,
      "date":date
    };
  }
}
