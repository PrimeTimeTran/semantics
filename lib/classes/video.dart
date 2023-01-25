class Video {
  int? id;
  String? videoUrl;
  List<Question>? questions;

  Video({this.id, this.videoUrl, this.questions});

  Video.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    videoUrl = json['videoUrl'];
    if (json['questions'] != null) {
      questions = <Question>[];
      json['questions'].forEach((v) {
        questions!.add(Question.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['videoUrl'] = videoUrl;
    if (this.questions != null) {
      data['questions'] = questions!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Question {
  String? id;
  String? type;
  String? body;
  String? correctAnswerId;
  List<Ans>? ans;
  List<String>? correctAnswers;

  Question(
      {this.id,
      this.type,
      this.body,
      this.correctAnswerId,
      this.ans,
      this.correctAnswers});

  Question.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    body = json['body'];
    if (json['correctAnswerId'] != null) {
      correctAnswerId = json['correctAnswerId'];
    }
    if (json['ans'] != null) {
      ans = <Ans>[];
      json['ans'].forEach((v) {
        ans!.add(Ans.fromJson(v));
      });
    }
    if (json['correctAnswers'] != null) {
      correctAnswers = json['correctAnswers'].cast<String>();
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['type'] = type;
    data['body'] = body;
    data['correctAnswerId'] = correctAnswerId;
    if (ans != null) {
      data['ans'] = ans!.map((v) => v.toJson()).toList();
    }
    data['correctAnswers'] = correctAnswers;
    return data;
  }
}

class Ans {
  String? id;
  String? body;

  Ans({this.id, this.body});

  Ans.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    body = json['body'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['body'] = body;
    return data;
  }
}
