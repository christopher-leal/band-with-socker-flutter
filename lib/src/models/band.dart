class Band {
  String id;
  String name;
  int votes;

  Band({this.id, this.name, this.votes});

  factory Band.fromMap(Map<String, dynamic> json) => Band(
      id: json.containsKey('id') ? json["id"] : 'no-id',
      name: json.containsKey('name') ? json["name"] : 'name',
      votes: json.containsKey('votes') ? json["votes"] : 'votes');
}
