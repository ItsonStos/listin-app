import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:listin_app/models/listin_model.dart';
import 'package:listin_app/screens/widgets/listin_tile.dart';
import 'package:uuid/uuid.dart';

class HomeScreem extends StatefulWidget {
  const HomeScreem({super.key});

  @override
  State<HomeScreem> createState() => _HomeScreemState();
}

class _HomeScreemState extends State<HomeScreem> {
  List<ListinModel> listListins = [];
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      appBar: AppBar(
        title: const Text('Listin - Feira Colaborativa'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showFormModal();
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
          : ListView(
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
    );
  }

  showFormModal() {
    String title = 'Adicionar Listin';
    String confirmationButton = 'Salvar';
    String skipButton = 'Cancelar';

    TextEditingController nameController = TextEditingController();

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(24),
        ),
      ),
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.all(32),
          child: ListView(
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(
                  label: Text('Nome do Listin'),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(skipButton),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      ListinModel listin = ListinModel(
                        id: const Uuid().v1(),
                        name: nameController.text,
                      );

                      firestore.collection(listin.id).doc(listin.name).set(
                            listin.toMap(),
                          );

                      Navigator.pop(context);
                    },
                    child: Text(confirmationButton),
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }

  refres() async {
    List<ListinModel> temp = [];
    QuerySnapshot<Map<String, dynamic>> snapshot = await firestore.collection('listins').get();

    for (var element in snapshot.docs) {
      temp.add(ListinModel.fromMap(element.data()));
    }

    setState(() {
      listListins = temp;
    });
  }
}
