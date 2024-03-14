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

  ListinModel? editingModel;

  showFormModal(context, Function refreshCallback, {ListinModel? model}) {
    _editToListin(model);

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
                    onPressed: () async {
                      if (editingModel != null) {
                        _editItem();
                      } else {
                        _addItem();
                      }
                      Navigator.pop(context);

                      analytics.incrementarListasAdicionadas();
                      refreshCallback();
                    },
                    child: Text(confirmationButton),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  void _addItem() {
    final String id = const Uuid().v1();
    final ListinModel listin = ListinModel(id: id, name: nameController.text);
    firestore.collection('listins').doc(listin.id).set(listin.toMap());
  }

  void _editItem() {
    if (editingModel != null) {
      editingModel!.name = nameController.text;
      firestore.collection('listins').doc(editingModel!.id).set(editingModel!.toMap());
    }
  }

  void _editToListin(ListinModel? model) {
    if (model != null) {
      title = "Editando ${model.name}";
      nameController.text = model.name;
      editingModel = model;
    }
  }
}
