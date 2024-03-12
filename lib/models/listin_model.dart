class ListinModel{
  String id;
  String name;

 ListinModel({required this.id, required this.name});

ListinModel.fromMap(Map<String, dynamic> map)
:id = map['id'],
name = map['name'];

Map<String, dynamic> toMap(){
  return{
    'id': id,
    'name': name,
  };
}

}