class Profile {
  String nick;
  String tier;
  List position;
  String playStyle;
  String introduce;
  bool isOn;
  bool isPlayer;
  double star;

  List reviews;

  Profile(
      {required this.nick,
      required this.tier,
      required this.position,
      required this.playStyle,
      required this.introduce,
      required this.isOn,
      required this.isPlayer,
      required this.star,
      required this.reviews});
}
