import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:listin_app/helpers/firestore_analytics_helpers.dart';
import 'package:listin_app/models/listin_model.dart';
import 'package:uuid/uuid.dart';

class ShowFormModal {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  TextEditingController nameController = TextEditingController();
  FirestoreAnalyticsHelpers analytics = FirestoreAnalyticsHelpers();

  String title = 'Adicionar Listin';
  String confirmationButton = 'Salvar';
  String skipButton = 'Cancelar';

  showFormModal(context, Function refreshCallback, {ListinModel? model}) {
    if (model != null) {
      title = "Editando ${model.name}";
      //listin.id = model.id;
      nameController.text = model.name;
    }

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
                      _saveToListin(nameController.text.trim());
                      refreshCallback();
                      analytics.incrementarListasAdicionadas();

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

  void _saveToListin(String name, {ListinModel? model}) {
    if (name.isNotEmpty) {
      final String id = const Uuid().v1();
      final ListinModel listin = ListinModel(id: id, name: nameController.text);

      if (model != null) {
        listin.id = model.id;
      }

      firestore.collection('listins').doc(listin.id).set(listin.toMap());
    }
  }

  void editListin(ListinModel? model) {
    if (model != null) {
      title = "Editando ${model.name}";
      //listin.id = model.id;
      nameController.text = model.name;
    }
  }
}
