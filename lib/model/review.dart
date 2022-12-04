import 'dart:ffi';

class Review {
  int reviewerId;
  String nick;
  String image;
  double rating;
  String content;
  String reviewTime;

  Review(
      {required this.reviewerId,
      required this.rating,
      required this.image,
      required this.content,
      required this.nick,
      required this.reviewTime});
}
