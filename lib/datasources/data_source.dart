import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:listin_app/models/listin_model.dart';

abstract class ListinDataSource {
  Future<List<ListinModel>> getListins();
  Future<void> addListin(ListinModel listin);
  Future<void> updateListin(ListinModel listin);
  Future<void> deleteListin(String id);
}

class FirestoreListinDataSource extends ListinDataSource {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Future<List<ListinModel>> getListins() async {
    final List<ListinModel> listListins = [];
    final QuerySnapshot<Map<String, dynamic>> snapshot = await firestore.collection('listins').get();

    for (var element in snapshot.docs) {
      listListins.add(ListinModel.fromMap(element.data()));
    }

    return listListins;
  }

  @override
  Future<void> addListin(ListinModel listin) async {
    await firestore.collection('listins').doc(listin.id).set(listin.toMap());
  }

  @override
  Future<void> updateListin(ListinModel listin) async {
    await firestore.collection('listins').doc(listin.id).set(listin.toMap());
  }

  @override
  Future<void> deleteListin(String id) async {
    await firestore.collection('listins').doc(id).delete();
  }
}
