import 'package:flutter/material.dart';
import 'package:listin_app/models/listin_model.dart';
import 'package:listin_app/screens/widgets/show_form_modal.dart';

class ListinTile extends StatefulWidget {
  final Widget icon;
  final String id;
  final String name;
  final ListinModel? model;

  const ListinTile({
    super.key,
    required this.icon,
    required this.id,
    required this.name,
    this.model,
  });

  @override
  State<ListinTile> createState() => _ListinTileState();
}

class _ListinTileState extends State<ListinTile> {
  @override
  Widget build(BuildContext context) {
    ListinModel model = ListinModel(id: widget.id, name: widget.name);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Dismissible(
        key: ValueKey<ListinModel>(model),
        background: Container(
          color: Colors.blueGrey,
          child: const Icon(Icons.edit),
        ),
        secondaryBackground: Container(
          color: Colors.redAccent,
          child: const Icon(Icons.delete),
        ),
        onDismissed: (DismissDirection) {
          setState(() {
            ShowFormModal().showFormModal(context, refresh, model: model);
          });
        },
        child: Container(
          padding: const EdgeInsets.all(16),
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            color: Colors.white54,
            borderRadius: BorderRadius.all(
              Radius.circular(16),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              widget.icon,
              const SizedBox(
                width: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.name),
                  Text(widget.id),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  refresh() {}
}
