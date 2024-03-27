class CourcesModel {
  final String topic;
  final String sub_title_1;
  final String sub_title_2;
  final String sub_title_3;
  final String sub_title_4;
  final String sub_title_5;
  final String sub_title_6;
  final String sub_title_7;
  final String sub_title_8;
  final String image;

  CourcesModel(
    this.topic,
    this.sub_title_1,
    this.sub_title_2,
    this.sub_title_3,
    this.sub_title_4,
    this.sub_title_5,
    this.sub_title_6,
    this.sub_title_7,
    this.sub_title_8,
    this.image,
  );

  factory CourcesModel.fromJson(Map<String, dynamic> json) {
    return CourcesModel(
      json['topic'],
      json['sub_title_1'],
      json['sub_title_2'],
      json['sub_title_3'],
      json['sub_title_4'],
      json['sub_title_5'],
      json['sub_title_6'],
      json['sub_title_7'],
      json['sub_title_8'],
      json['image'],
    );
  }
}
