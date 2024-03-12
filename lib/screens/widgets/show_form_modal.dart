import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:listin_app/models/listin_model.dart';
import 'package:uuid/uuid.dart';

class ShowFormModal extends StatefulWidget {
  const ShowFormModal({super.key});

  @override
  State<ShowFormModal> createState() => _ShowFormModalState();
}

class _ShowFormModalState extends State<ShowFormModal> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return const SizedBox();
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
}
