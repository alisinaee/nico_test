class Model {
  Pages pages;
  bool status;
  String message;
  List<Object> object;

  Model({this.pages, this.status, this.message, this.object});

  Model.fromJson(Map<String, dynamic> json) {
    pages = json['pages'] != null ? new Pages.fromJson(json['pages']) : null;
    status = json['status'];
    message = json['message'];
    if (json['object'] != null) {
      object = new List<Object>();
      json['object'].forEach((v) {
        object.add(new Object.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.pages != null) {
      data['pages'] = this.pages.toJson();
    }
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.object != null) {
      data['object'] = this.object.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Pages {
  int pageNo;
  int defaultElementCount;
  int totalPages;

  Pages({this.pageNo, this.defaultElementCount, this.totalPages});

  Pages.fromJson(Map<String, dynamic> json) {
    pageNo = json['pageNo'];
    defaultElementCount = json['defaultElementCount'];
    totalPages = json['totalPages'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pageNo'] = this.pageNo;
    data['defaultElementCount'] = this.defaultElementCount;
    data['totalPages'] = this.totalPages;
    return data;
  }
}

class Object {
  String id;
  String title;
  String description;
  int createdAt;
  int adType;
  int exchangeType;
  int category;
  int publishStatus;
  int publishType;
  int publishPrice;
  int cityId;
  String cityName;
  int provienceId;
  String provienceName;
  double lat;
  double long;
  int price;
  bool isFavorite;
  List<String> images;
  User user;
  int status;

  Object(
      {this.id,
      this.title,
      this.description,
      this.createdAt,
      this.adType,
      this.exchangeType,
      this.category,
      this.publishStatus,
      this.publishType,
      this.publishPrice,
      this.cityId,
      this.cityName,
      this.provienceId,
      this.provienceName,
      this.lat,
      this.long,
      this.price,
      this.isFavorite,
      this.images,
      this.user,
      this.status});

  Object.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    createdAt = json['createdAt'];
    adType = json['adType'];
    exchangeType = json['exchangeType'];
    category = json['category'];
    publishStatus = json['publishStatus'];
    publishType = json['publishType'];
    publishPrice = json['publishPrice'];
    cityId = json['cityId'];
    cityName = json['cityName'];
    provienceId = json['provienceId'];
    provienceName = json['provienceName'];
    lat = json['lat'];
    long = json['long'];
    price = json['price'];
    isFavorite = json['isFavorite'];
    images = json['images'].cast<String>();
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['createdAt'] = this.createdAt;
    data['adType'] = this.adType;
    data['exchangeType'] = this.exchangeType;
    data['category'] = this.category;
    data['publishStatus'] = this.publishStatus;
    data['publishType'] = this.publishType;
    data['publishPrice'] = this.publishPrice;
    data['cityId'] = this.cityId;
    data['cityName'] = this.cityName;
    data['provienceId'] = this.provienceId;
    data['provienceName'] = this.provienceName;
    data['lat'] = this.lat;
    data['long'] = this.long;
    data['price'] = this.price;
    data['isFavorite'] = this.isFavorite;
    data['images'] = this.images;
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    data['status'] = this.status;
    return data;
  }
}

class User {
  String userId;
  String name;
  String familyName;
  String mobile;

  User({this.userId, this.name, this.familyName, this.mobile});

  User.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    name = json['name'];
    familyName = json['familyName'];
    mobile = json['mobile'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['name'] = this.name;
    data['familyName'] = this.familyName;
    data['mobile'] = this.mobile;
    return data;
  }
}
