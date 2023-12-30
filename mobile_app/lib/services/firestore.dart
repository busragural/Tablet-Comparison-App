import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {

  final CollectionReference tablets =
      FirebaseFirestore.instance.collection("tablets");

  Stream<QuerySnapshot> getTabletsStream(){
    
    final tabletsStrem = tablets.snapshots();
    return tabletsStrem;
  }
}
