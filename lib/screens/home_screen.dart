import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:listin_app/helpers/firestore_analytics_helpers.dart';
import 'package:listin_app/models/listin_model.dart';
import 'package:listin_app/screens/widgets/listin_tile.dart';
import 'package:listin_app/screens/widgets/show_form_modal.dart';

class HomeScreem extends StatefulWidget {
  const HomeScreem({super.key});

  @override
  State<HomeScreem> createState() => _HomeScreemState();
}

class _HomeScreemState extends State<HomeScreem> {
  List<ListinModel> listListins = [];
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  ListinModel? model;

  FirestoreAnalyticsHelpers analytics = FirestoreAnalyticsHelpers();

  @override
  void initState() {
    refresh();
    analytics.incrementarAcessosTotais();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      appBar: AppBar(
        title: const Text('Listin - Feira Colaborativa'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ShowFormModal().showFormModal(context, refresh);
        },
        child: const Icon(Icons.add),
      ),
      body: (listListins.isEmpty)
          ? const Center(
              child: Text(
                'Nenhuma lista inserida.\nVamos criar a primeira?',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18),
              ),
            )
          : RefreshIndicator(
              onRefresh: () {
                analytics.incrementarAtualizacoesManuais();
                return refresh();
              },
              child: ListView(
                children: List.generate(
                  listListins.length,
                  (index) {
                    ListinModel model = listListins[index];
                    return ListinTile(
                      icon: const Icon(Icons.list_alt_rounded),
                      id: model.id,
                      name: model.name,
                    );
                  },
                ),
              ),
            ),
    );
  }

  refresh() async {
    List<ListinModel> temp = [];
    QuerySnapshot<Map<String, dynamic>> snapshot = await firestore.collection('listins').get();

    for (var element in snapshot.docs) {
      temp.add(ListinModel.fromMap(element.data()));
    }

    setState(() {
      listListins = temp;
    });
  }

  void removListin(ListinModel model) {
    firestore.collection('listin').doc(model.id).delete();
  }
}
