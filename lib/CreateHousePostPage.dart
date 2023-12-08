import 'package:flutter/material.dart';
import 'package:flutter_project/FireStoreCollections.dart';
import 'package:flutter_project/HomePage.dart';
import 'package:flutter_project/Models/HouseModel.dart';
import 'package:flutter_project/User%20Authentication/UserAuthentication.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class CreatePost extends StatefulWidget {
  const CreatePost({super.key});

  @override
  State<CreatePost> createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
  String currentPurpose = "Sell",
      propertyType = 'House',
      selectedCity = "Select a City",
      areaSize = 'Marla';
  final ImagePicker imagePicker = ImagePicker();
  TextEditingController areaController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController areaSizeController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  List<XFile> images = [];
  List<String> cities = [
    'Karachi',
    'Lahore',
    'Faisalabad',
    'Rawalpindi',
    'Multan',
    'Hyderabad',
    'Gujranwala',
    'Peshawar',
    'Islamabad',
    'Bahawalpur',
    'Sargodha',
    'Sialkot',
    'Quetta',
    'Sukkur',
    'Jhang',
    'Shekhupura',
    'Mardan',
    'Gujrat',
    'Larkana',
    'Kasur',
    'Rahim Yar Khan',
    'Sahiwal',
    'Okara',
    'Wah Cantonment',
    'Dera Ghazi Khan',
    'Mingora',
    'Mirpur Khas',
    'Chiniot',
    'Nawabshah',
    'Kāmoke',
    'Burewala',
    'Jhelum',
    'Sadiqabad',
    'Khanewal',
    'Hafizabad',
    'Kohat',
    'Jacobabad',
    'Shikarpur',
    'Muzaffargarh',
    'Khanpur',
    'Gojra',
    'Bahawalnagar',
    'Abbottabad',
    'Muridke',
    'Pakpattan',
    'Khuzdar',
    'Jaranwala',
    'Chishtian',
    'Daska',
    'Bhalwal',
    'Mandi Bahauddin',
    'Ahmadpur East',
    'Kamalia',
    'Tando Adam',
    'Khairpur',
    'Dera Ismail Khan',
    'Vehari',
    'Nowshera',
    'Dadu',
    'Wazirabad',
    'Khushab',
    'Charsada',
    'Swabi',
    'Chakwal',
    'Mianwali',
    'Tando Allahyar',
    'Kot Adu',
    'Turbat'
  ];

  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RadioListTile(
                  title: Text('Sell'),
                  value: 'Sell',
                  groupValue: currentPurpose,
                  onChanged: (value) {
                    setState(() {
                      currentPurpose = value.toString();
                    });
                  }),
              RadioListTile(
                  title: Text('Rent'),
                  value: 'Rent',
                  groupValue: currentPurpose,
                  onChanged: (value) {
                    setState(() {
                      currentPurpose = value.toString();
                    });
                  }),
              SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  "Property Type",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              RadioListTile(
                  title: Text('House'),
                  value: 'House',
                  groupValue: propertyType,
                  onChanged: (value) {
                    setState(() {
                      propertyType = value.toString();
                    });
                  }),
              RadioListTile(
                  title: Text('Plot'),
                  value: 'Plot',
                  groupValue: propertyType,
                  onChanged: (value) {
                    setState(() {
                      propertyType = value.toString();
                    });
                  }),
              RadioListTile(
                  title: Text('Commercial'),
                  value: 'Commercial',
                  groupValue: propertyType,
                  onChanged: (value) {
                    setState(() {
                      propertyType = value.toString();
                    });
                  }),
              SizedBox(
                height: 5,
              ),
              InkWell(
                onTap: () {
                  showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return Container(
                          height: MediaQuery.of(context).size.height * 0.8,
                          width: MediaQuery.of(context).size.width,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 12),
                                child: TextField(
                                  decoration: InputDecoration(
                                    hintText: 'Search City',
                                    prefixIcon: Icon(Icons.search),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: ListView.builder(
                                  itemCount: cities.length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.only(
                                          top: 12, left: 12),
                                      child: InkWell(
                                        onTap: () {
                                          setState(() {
                                            selectedCity = cities[index];
                                          });
                                          Navigator.pop(context);
                                        },
                                        child: Text(
                                          cities[index],
                                          style: TextStyle(fontSize: 16),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        );
                      });
                },
                child: ListTile(
                  title: Text("City"),
                  subtitle: Text(selectedCity),
                  leading: Icon(Icons.location_on),
                  trailing: Icon(Icons.arrow_right),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              TextField(
                controller: areaController,
                decoration: InputDecoration(
                  hintText: 'Area',
                  prefixIcon: Icon(Icons.location_history),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                controller: addressController,
                decoration: InputDecoration(
                  hintText: 'Address',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
              ),
              ListTile(
                title: Text("Area Size"),
                subtitle: TextField(
                  controller: areaSizeController,
                  decoration: InputDecoration(
                      hintText: 'Enter area size',
                      border: UnderlineInputBorder()),
                ),
                leading: Icon(Icons.area_chart),
                trailing: DropdownButton(
                    value: areaSize,
                    onChanged: (value) {
                      setState(() {
                        areaSize = value.toString();
                      });
                    },
                    items: [
                      DropdownMenuItem(value: 'Marla', child: Text('Marla')),
                      DropdownMenuItem(value: 'Kanal', child: Text('Kanal')),
                    ]),
              ),
              ListTile(
                title: Text("Total Price"),
                subtitle: TextField(
                  controller: priceController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      hintText: 'Enter Price', border: UnderlineInputBorder()),
                ),
                leading: Icon(Icons.tag),
              ),
              ListTile(
                title: Text("Property Title"),
                subtitle: TextField(
                  controller: titleController,
                  decoration: InputDecoration(
                      hintText: 'Enter a title',
                      border: UnderlineInputBorder()),
                ),
                leading: Icon(Icons.title),
              ),
              ListTile(
                title: Text("Property Description"),
                subtitle: TextField(
                  controller: descriptionController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      hintText: 'Describe your property in detail',
                      border: UnderlineInputBorder()),
                ),
                leading: Icon(Icons.description),
              ),
              ListTile(
                title: Text('Upload Pictures'),
                leading: Icon(Icons.image),
                trailing: ElevatedButton(
                    onPressed: pickImages, child: Text("Select Pictures")),
              ),
              Align(
                  alignment: Alignment.bottomCenter,
                  child: ElevatedButton(
                      onPressed: postAd, child: Text("Post an Ad"))),
            ],
          )
        ],
      ),
    );
  }

  postAd() async {
    final house_id = Uuid().v4();
    final currentUser = UserAuthentication.currentUser;
    try {
      HouseModel house = HouseModel(
          houseId: house_id,
          userId: currentUser.id,
          propertyType: propertyType,
          city: selectedCity,
          area: areaController.text,
          address: addressController.text,
          areaSize: "${areaSizeController.text} ${areaSize}",
          price: int.parse(priceController.text),
          title: titleController.text,
          description: descriptionController.text,
          creationTime: DateTime.now().toString());
      await FireStoreCollections().createHouseAd(currentPurpose, house);
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => MyHomePage(),
          ));
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> pickImages() async {
    images = await imagePicker.pickMultiImage();
  }
}
