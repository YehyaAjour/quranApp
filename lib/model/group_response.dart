class GroupResponse {
  Result result;

  GroupResponse({this.result});

  GroupResponse.fromJson(Map<String, dynamic> json) {
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
  List<Collection> collection;
  Pagination pagination;

  Data({this.collection, this.pagination});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['collection'] != null) {
      collection = new List<Collection>();
      json['collection'].forEach((v) {
        collection.add(new Collection.fromJson(v));
      });
    }
    pagination = json['pagination'] != null
        ? new Pagination.fromJson(json['pagination'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.collection != null) {
      data['collection'] = this.collection.map((v) => v.toJson()).toList();
    }
    if (this.pagination != null) {
      data['pagination'] = this.pagination.toJson();
    }
    return data;
  }
}

class Collection {
  int id;
  String name;
  String createdAt;
  String updatedAt;

  Collection({this.id, this.name, this.createdAt, this.updatedAt});

  Collection.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Pagination {
  int totalCount;
  int totalPages;
  int currentPage;
  int limit;
  String nextPage;
  String prevPage;

  Pagination(
      {this.totalCount,
      this.totalPages,
      this.currentPage,
      this.limit,
      this.nextPage,
      this.prevPage});

  Pagination.fromJson(Map<String, dynamic> json) {
    totalCount = json['total_count'];
    totalPages = json['total_Pages'];
    currentPage = json['current_page'];
    limit = json['limit'];
    nextPage = json['next_page'];
    prevPage = json['prev_page'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_count'] = this.totalCount;
    data['total_Pages'] = this.totalPages;
    data['current_page'] = this.currentPage;
    data['limit'] = this.limit;
    data['next_page'] = this.nextPage;
    data['prev_page'] = this.prevPage;
    return data;
  }
}
