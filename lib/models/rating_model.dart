class RatingModel {
  double rate;
  int count;

  RatingModel({required this.rate, required this.count});

  factory RatingModel.fromJson(Map<String, dynamic> json) {
    return RatingModel(
      rate: (json['rate'] is int) ? (json['rate'] as int).toDouble() : json['rate'],
      count: json['count'],
    );
  }
}
