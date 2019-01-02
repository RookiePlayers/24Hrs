import 'package:twenty_four_hours/Gym/Models/gym_Profile.dart';
class ReplyComment
{
   GymProfile _commenter = new GymProfile();
  String _commment = '';
  List<GymProfile> _likedComment = [new GymProfile()];
 

  ReplyComment(
      [this._commenter, this._commment, this._likedComment]);

  List<GymProfile> get likedComment => _likedComment;

  @override
  String toString() {
    return 'Comments{_commenter: $_commenter, _commment: $_commment, _likedComment: $_likedComment}';
  }

  String get commment => _commment;

  set commment(String value) {
    _commment = value;
  }

  set likedComment(List<GymProfile> value) {
    _likedComment = value;
  }

  GymProfile get commenter => _commenter;

  set commenter(GymProfile value) {
    _commenter = value;
  }
}
class Comments {
  GymProfile _commenter = new GymProfile();
  String _commment = '';
  List<GymProfile> _likedComment = [new GymProfile()];
  List<ReplyComment> _replies = new List<ReplyComment>();
  DateTime _duration = new DateTime.now();

  Comments(
      [this._commenter, this._commment, this._likedComment, this._replies]);

  List<GymProfile> get likedComment => _likedComment;

  List<ReplyComment> get replies => _replies;

  set replies( List<ReplyComment> value) {
    _replies = value;
  }

  int getDuration(DateTime currentTime) {
    return _duration.difference(currentTime).inSeconds;
  }

  @override
  String toString() {
    return 'Comments{_commenter: $_commenter, _commment: $_commment, _likedComment: $_likedComment, _duration: $_duration}';
  }

  String get commment => _commment;

  set commment(String value) {
    _commment = value;
  }

  set likedComment(List<GymProfile> value) {
    _likedComment = value;
  }

  GymProfile get commenter => _commenter;

  set commenter(GymProfile value) {
    _commenter = value;
  }
}
