class Categories {
  final String name;
  final int id;

  Categories({required this.name, required this.id});

  @override
  String toString() {
    return 'Category: { name: $name, id: $id }';
  }
}