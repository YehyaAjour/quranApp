class GetInstructorResponse {
  Result result;

  GetInstructorResponse({this.result});

  GetInstructorResponse.fromJson(Map<String, dynamic> json) {
    result =
        json['result'] != null ? new Result.fromJson(json['result']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.result != null) {
      data['result'] = this.result.toJson();
    }
    return data;
  }
}

class Result {
  bool success;
  String message;
  Data data;
  int statusCode;

  Result({this.success, this.message, this.data, this.statusCode});

  Result.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    statusCode = json['status_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    data['status_code'] = this.statusCode;
    return data;
  }
}

class Data {
  Instructor instructor;

  Data({this.instructor});

  Data.fromJson(Map<String, dynamic> json) {
    instructor = json['instructor'] != null
        ? new Instructor.fromJson(json['instructor'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.instructor != null) {
      data['instructor'] = this.instructor.toJson();
    }
    return data;
  }
}

class Instructor {
  int id;
  String name;
  String email;
  String joinedAt;
  List<Group> group;

  Instructor({this.id, this.name, this.email, this.joinedAt, this.group});

  Instructor.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    joinedAt = json['joined_at'];
    if (json['group'] != null) {
      group = new List<Group>();
      json['group'].forEach((v) {
        group.add(new Group.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['joined_at'] = this.joinedAt;
    if (this.group != null) {
      data['group'] = this.group.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Group {
  int id;
  String name;
  String createdAt;
  List<Students> students;

  Group({this.id, this.name, this.createdAt, this.students});

  Group.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    createdAt = json['created_at'];
    if (json['students'] != null) {
      students = new List<Students>();
      json['students'].forEach((v) {
        students.add(new Students.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['created_at'] = this.createdAt;
    if (this.students != null) {
      data['students'] = this.students.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Students {
  int id;
  String name;
  String email;
  String joinedAt;

  Students({this.id, this.name, this.email, this.joinedAt});

  Students.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    joinedAt = json['joined_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['joined_at'] = this.joinedAt;
    return data;
  }
}
