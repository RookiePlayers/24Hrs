
import 'package:twenty_four_hours/Gym/Models/Follows.dart';
import 'package:twenty_four_hours/Gym/Models/Friends.dart';
import 'package:twenty_four_hours/Gym/Models/Gallery.dart';

class LifestyleProfile{
     Follows follow = new Follows();
  String UID = '';
  Gallery gallery = new Gallery();
  Friends friends;
  String bio = 'Hey There!, Welcome to MyFit Profile';

  LifestyleProfile({
    this.follow,
    this.UID,
    this.gallery,
    this.friends,
    this.bio
  });

}