class Space {
  final String nama, capt, image;
  final int id;

  Space(
      {required this.nama,
        required this.capt,
        required this.image,
        required this.id});

  factory Space.fromJSON(Map parsedJson) {
    return Space(
        id: parsedJson['id'],
        nama: parsedJson['nama'],
        capt: parsedJson['capt'],
        image: parsedJson['image']);
  }
}