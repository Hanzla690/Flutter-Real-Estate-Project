class HouseModel {
  String houseId,
      userId,
      propertyType,
      city,
      area,
      address,
      areaSize,
      title,
      description,
      creationTime;
  int price;
  // List imageURLs;

  HouseModel({
    required this.houseId,
    required this.userId,
    required this.propertyType,
    required this.city,
    required this.area,
    required this.address,
    required this.areaSize,
    required this.price,
    required this.title,
    required this.description,
    required this.creationTime,
  });

  static List<HouseModel> data = [
    HouseModel(
      houseId: "#1001",
      userId: "#1234",
      propertyType: "Sale",
      city: "Lahore",
      area: "Bahria",
      address: "unknown",
      areaSize: "5 Marla",
      price: 12500000,
      title: "Bahria house",
      description: "Nice beautiful place",
      creationTime: "3 months",
    ),
    HouseModel(
      houseId: "#1002",
      userId: "#5678",
      propertyType: "Rent",
      city: "Karachi",
      area: "Clifton",
      address: "123 Main St",
      areaSize: "8 Marla",
      price: 20000,
      title: "Clifton Apartment",
      description: "Modern living space",
      creationTime: "1 month",
    ),
    HouseModel(
      houseId: "#1003",
      userId: "#9876",
      propertyType: "Sale",
      city: "Islamabad",
      area: "G-11",
      address: "456 Oak St",
      areaSize: "10 Marla",
      price: 17500000,
      title: "G-11 House",
      description: "Spacious and elegant",
      creationTime: "6 months",
    ),
    HouseModel(
      houseId: "#1004",
      userId: "#5432",
      propertyType: "Rent",
      city: "Rawalpindi",
      area: "Satellite Town",
      address: "789 Pine St",
      areaSize: "12 Marla",
      price: 30000,
      title: "Satellite Town Villa",
      description: "Family-friendly neighborhood",
      creationTime: "2 months",
    ),
    HouseModel(
      houseId: "#1005",
      userId: "#1357",
      propertyType: "Sale",
      city: "Lahore",
      area: "Johar Town",
      address: "101 Cedar St",
      areaSize: "7 Marla",
      price: 9000000,
      title: "Johar Town Residence",
      description: "Close to amenities",
      creationTime: "4 months",
    ),
  ];

  Map<String, dynamic> toJSON() {
    return {
      'houseId': houseId,
      'userId': userId,
      'propertyType': propertyType,
      'city': city,
      'area': area,
      'address': address,
      'areaSize': areaSize,
      'price': price,
      'title': title,
      'description': description,
      'creationTime': creationTime,
    };
  }

  static HouseModel fromMap(Map<String, dynamic> json) {
    return HouseModel(
        houseId: json['houseId'],
        userId: json['userId'],
        propertyType: json['propertyType'],
        city: json['city'],
        area: json['area'],
        address: json['address'],
        areaSize: json['areaSize'],
        price: json['price'],
        title: json['title'],
        description: json['description'],
        creationTime: json['creationTime']);
  }
}
