import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:listin_app/datasources/data_source.dart';
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
  final ListinDataSource _dataSource = ListinDataSource();
  List<ListinModel> listListins = [];
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  ListinModel? editinModel;

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
                    return Dismissible(
                      key: ValueKey<ListinModel>(model),
                      direction: DismissDirection.horizontal,
                      confirmDismiss: (direction) async {
                        direction == DismissDirection.endToStart
                            ? showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: const Text('Deseja deletar?'),
                                    content: const Text("Certeza que deseja deletar esse item?"),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          _removListin(model);
                                          Navigator.pop(context);

                                          refresh();
                                        },
                                        child: const Text("Sim"),
                                      ),
                                      TextButton(
                                        onPressed: () => Navigator.pop(context),
                                        child: const Text("Cancelar"),
                                      ),
                                    ],
                                  );
                                },
                              )
                            : ShowFormModal().showFormModal(context, refresh, model: model);
                        return null;
                      },
                      background: Container(
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.only(left: 8),
                        color: Colors.blueGrey,
                        child: const Icon(
                          Icons.edit,
                          size: 40,
                          color: Colors.white,
                        ),
                      ),
                      secondaryBackground: Container(
                        alignment: Alignment.centerRight,
                        padding: const EdgeInsets.only(right: 8),
                        color: Colors.red,
                        child: const Icon(
                          Icons.delete,
                          size: 40,
                          color: Colors.white,
                        ),
                      ),
                      child: ListinTile(
                        icon: const Icon(Icons.list_alt_rounded),
                        id: model.id,
                        name: model.name,
                      ),
                    );
                  },
                ),
              ),
            ),
    );
  }

  Future<void> refresh() async {
    List<ListinModel> temp = [];
    QuerySnapshot<Map<String, dynamic>> snapshot = await firestore.collection('listins').get();

    for (var element in snapshot.docs) {
      temp.add(ListinModel.fromMap(element.data()));
    }

    setState(() {
      listListins = temp;
    });
  }

  void _removListin(ListinModel model) async {
    await firestore.collection('listins').doc(model.id).delete();
    setState(() {
      listListins.remove(model);
    });
  }
}
