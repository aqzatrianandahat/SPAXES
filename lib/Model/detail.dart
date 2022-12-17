class Detail {
  final String nama, capt, image;
  final int id;

  Detail(
      {required this.nama,
      required this.capt,
      required this.image,
      required this.id});

  factory Detail.fromJSON(Map parsedJson) {
    return Detail(
        id: parsedJson['id'],
        nama: parsedJson['nama'],
        capt: parsedJson['capt'],
        image: parsedJson['image']);
  }
}
