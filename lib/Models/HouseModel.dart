class HouseModel {
  String houseId,
      userId,
      adPurpose,
      propertyType,
      city,
      area,
      address,
      areaSize,
      title,
      description,
      creationTime;
  int price;
  List imageURLs;

  HouseModel({
    required this.houseId,
    required this.userId,
    required this.adPurpose,
    required this.propertyType,
    required this.city,
    required this.area,
    required this.address,
    required this.areaSize,
    required this.price,
    required this.title,
    required this.description,
    required this.creationTime,
    this.imageURLs = const [],
  });

  Map<String, dynamic> toJSON() {
    return {
      'houseId': houseId,
      'userId': userId,
      'adPurpose': adPurpose,
      'propertyType': propertyType,
      'city': city,
      'area': area,
      'address': address,
      'areaSize': areaSize,
      'price': price,
      'title': title,
      'description': description,
      'creationTime': creationTime,
      'images': imageURLs,
    };
  }

  static HouseModel fromMap(Map<String, dynamic> json) {
    return HouseModel(
        houseId: json['houseId'],
        userId: json['userId'],
        adPurpose: json['adPurpose'],
        propertyType: json['propertyType'],
        city: json['city'],
        area: json['area'],
        address: json['address'],
        areaSize: json['areaSize'],
        price: json['price'],
        title: json['title'],
        description: json['description'],
        creationTime: json['creationTime'],
        imageURLs: json['images']);
  }
}