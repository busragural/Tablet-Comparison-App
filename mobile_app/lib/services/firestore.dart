import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {

  final CollectionReference _tablets =
      FirebaseFirestore.instance.collection("tablets");

  Future<QuerySnapshot> getTablets() => _tablets.get();
}
