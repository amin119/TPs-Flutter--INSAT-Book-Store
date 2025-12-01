class Book {
  String id; // optional Firestore/doc id or local id
  String name;
  int price;
  String image;

  Book(this.name, this.price, this.image, {this.id = ''});

  Map<String, dynamic> toMap() => {
        'name': name,
        'price': price,
        'image': image,
      };

  factory Book.fromMap(Map<String, dynamic> map, {String id = ''}) => Book(
        map['name'] as String,
        (map['price'] as num).toInt(),
        map['image'] as String,
        id: id,
      );

  @override
  String toString() => 'Book(id: $id, name: $name, price: $price, image: $image)';
}
