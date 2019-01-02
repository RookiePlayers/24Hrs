import 'package:twenty_four_hours/Gym/Models/gym_Profile.dart';

class Friends {
  List<GymProfile> _friends = [];
  List<GymProfile> _blocked = [];
  List<GymProfile> _bestFriends = [];
  List<GymProfile> _mutualFriend = [];
  List<GymProfile> _friendInvites = [];

  Friends(this._friends, this._blocked, this._bestFriends, this._mutualFriend,
      this._friendInvites);

  List<GymProfile> get friendInvites => _friendInvites;

  set friendInvites(List<GymProfile> value) {
    _friendInvites = value;
  }

  List<GymProfile> getMutualFriend(GymProfile p) {
    bool mutual = false;
    for (GymProfile profile in _friends) {
      if (p.friends.friends.contains(profile)) mutual = true;
    }
    if (mutual == true) {
      _mutualFriend.add(p);
    }
    return _mutualFriend;
  }

  set mutualFriend(List<GymProfile> value) {
    _mutualFriend = value;
  }

  List<GymProfile> get bestFriends => _bestFriends;

  set bestFriends(List<GymProfile> value) {
    _bestFriends = value;
  }

  List<GymProfile> get blocked => _blocked;

  set blocked(List<GymProfile> value) {
    _blocked = value;
  }

  List<GymProfile> get friends => _friends;

  set friends(List<GymProfile> value) {
    _friends = value;
  }
}
