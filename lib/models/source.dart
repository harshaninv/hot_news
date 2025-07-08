class Source {
  Source({this.id, required this.name});

  final String? id;
  final String name;

  // Factory constructor for deserialization (converting JSON to Source object)
  factory Source.fromJson(Map<String, dynamic> json) {
    return Source(
      id: json['id'] as String?,
      name: json['name'] as String,
    );
  }

}
