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

  List<String> cities = ['Karachi', 'Lahore', 'Faisalabad', 'Rawalpindi', 'Multan', 'Hyderabad',
    'Gujranwala', 'Peshawar', 'Islamabad', 'Bahawalpur', 'Sargodha', 'Sialkot', 'Quetta', 'Sukkur',
    'Jhang', 'Shekhupura', 'Mardan', 'Gujrat', 'Larkana', 'Kasur', 'Rahim Yar Khan', 'Sahiwal',
    'Okara', 'Wah Cantonment', 'Dera Ghazi Khan', 'Mingora', 'Mirpur Khas', 'Chiniot', 'Nawabshah',
    'Kāmoke', 'Burewala', 'Jhelum', 'Sadiqabad', 'Khanewal', 'Hafizabad', 'Kohat', 'Jacobabad', 'Shikarpur',
    'Muzaffargarh', 'Khanpur', 'Gojra', 'Bahawalnagar', 'Abbottabad', 'Muridke', 'Pakpattan', 'Khuzdar',
    'Jaranwala', 'Chishtian', 'Daska', 'Bhalwal', 'Mandi Bahauddin', 'Ahmadpur East', 'Kamalia', 'Tando Adam', 'Khairpur',
    'Dera Ismail Khan', 'Vehari', 'Nowshera', 'Dadu', 'Wazirabad', 'Khushab', 'Charsada', 'Swabi', 'Chakwal',
    'Mianwali', 'Tando Allahyar', 'Kot Adu', 'Turbat'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 3,
        backgroundColor: Colors.white,
        toolbarHeight: 60,
        title: Row(
          children: [
            Icon(
              Icons.add_circle,
              color: Colors.green.shade500,
            ),
            const Text("Post Ad",
              style: TextStyle(
                  color: Colors.black
              ),),
          ],
        ),
        centerTitle: true,
      ),

      body: ListView(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 250,
                width: double.infinity,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(18),
                      bottomRight: Radius.circular(18)),
                  image: DecorationImage(
                      image: AssetImage("assets/minimalHouse.jpg"),
                  fit: BoxFit.cover)
                ),
              ),
              const SizedBox(height: 12,),
              ListTile(
                title: const Text("Ad Title"),
                subtitle: TextField(
                    controller: titleController,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 2,
                            color: Colors.green.shade500),
                        borderRadius: BorderRadius.circular(40.0),
                      ),
                      hintText: 'Enter a title',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    )
                ),
                leading: Icon(Icons.title,
                  color: Colors.green.shade500,),
              ),
              SizedBox(height: 5,),
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
                                    prefixIcon: Icon(Icons.search,
                                      color: Colors.green.shade500,),
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
                                          top: 14, left: 14),
                                      child: InkWell(
                                        onTap: () {
                                          setState(() {
                                            selectedCity = cities[index];
                                          });
                                          Navigator.pop(context);
                                        },
                                        child: Text(
                                          cities[index],
                                          style: const TextStyle(fontSize: 16),
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
                  title: const Text("City"),
                  subtitle: Text(selectedCity),
                  leading: Icon(Icons.location_on,
                    color: Colors.green.shade500,),
                  trailing: Icon(Icons.arrow_right,
                    color: Colors.green.shade500,),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              TextField(
                controller: areaController,
                decoration: InputDecoration(
                  hintText: 'Area',
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        width: 2,
                        color: Colors.green.shade500),
                    borderRadius: BorderRadius.circular(40.0),
                  ),
                  prefixIcon: Icon(Icons.location_history,
                    color: Colors.green.shade500,),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              TextField(
                controller: addressController,
                decoration: InputDecoration(
                  hintText: 'Address',
                  prefixIcon: Icon(Icons.search,
                      color: Colors.green.shade500),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        width: 2,
                        color: Colors.green.shade500),
                    borderRadius: BorderRadius.circular(40.0),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
              ),
              const SizedBox(height: 5,),
              const Divider(thickness: 1,),
              RadioListTile(
                  title: const Text('Sell'),
                  value: 'Sell',
                  groupValue: currentPurpose,
                  hoverColor: Colors.green.shade200,
                  activeColor: Colors.green.shade500,
                  onChanged: (value) {
                    setState(() {
                      currentPurpose = value.toString();
                    });
                  }),
              RadioListTile(
                  title: const Text('Rent'),
                  value: 'Rent',
                  hoverColor: Colors.green.shade200,
                  activeColor: Colors.green.shade500,
                  groupValue: currentPurpose,
                  onChanged: (value) {
                    setState(() {
                      currentPurpose = value.toString();
                    });
                  }),
              const SizedBox(
                height: 5,
              ),
              const Divider(thickness: 1,),
              const Padding(
                padding: EdgeInsets.only(left: 10),
                child: Text(
                  "Property Type",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              RadioListTile(
                  title: const Text('House'),
                  value: 'House',
                  groupValue: propertyType,
                  hoverColor: Colors.green.shade200,
                  activeColor: Colors.green.shade500,
                  onChanged: (value) {
                    setState(() {
                      propertyType = value.toString();
                    });
                  }),
              RadioListTile(
                  title: const Text('Plot'),
                  value: 'Plot',
                  groupValue: propertyType,
                  hoverColor: Colors.green.shade200,
                  activeColor: Colors.green.shade500,
                  onChanged: (value) {
                    setState(() {
                      propertyType = value.toString();
                    });
                  }),
              RadioListTile(
                  title: const Text('Commercial'),
                  value: 'Commercial',
                  groupValue: propertyType,
                  hoverColor: Colors.green.shade200,
                  activeColor: Colors.green.shade500,
                  onChanged: (value) {
                    setState(() {
                      propertyType = value.toString();
                    });
                  }),
              const SizedBox(
                height: 5,
              ),
              const Divider(thickness: 1,),
              ListTile(
                title: const Text("Property's Area"),
                subtitle: TextField(
                  controller: areaSizeController,
                  decoration: const InputDecoration(
                      hintText: 'Enter area size',
                      border: UnderlineInputBorder()),
                ),
                leading: Icon(Icons.area_chart,
                color: Colors.green.shade500,),
                trailing: DropdownButton(
                    value: areaSize,
                    onChanged: (value) {
                      setState(() {
                        areaSize = value.toString();
                      });
                    },
                    items: const [
                      DropdownMenuItem(value: 'Marla', child: Text('Marla')),
                      DropdownMenuItem(value: 'Kanal', child: Text('Kanal')),
                    ]),
              ),
              ListTile(
                title: const Text("Price/Demand (PKR)"),
                subtitle: TextField(
                  controller: priceController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 2,
                            color: Colors.green.shade500),
                        borderRadius: BorderRadius.circular(40.0),
                      ),
                      hintText: 'Enter Price',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)
                      )),
                ),
                leading: Icon(Icons.money,
                color: Colors.green.shade500,),
              ),
              const SizedBox(height: 5,),
              const Divider(
                thickness: 1,
              indent: 5,
              endIndent: 5,),
              ListTile(
                title: const Text("Property Description"),
                subtitle: TextField(
                  keyboardType: TextInputType.multiline,
                  maxLines: 4,
                  controller: descriptionController,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 3,
                        color: Colors.green.shade500)
                    ),
                      hintText: 'Describe your property in detail',
                     // border: UnderlineInputBorder()
                  ),
                ),
                leading: Icon(Icons.description,
                color: Colors.green.shade500,),
              ),
              ListTile(
                title: const Text('Upload Pictures'),
                leading: Icon(Icons.image,
                color: Colors.green.shade500,),
                trailing: ElevatedButton(
                    onPressed: pickImages,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green.shade500
                  ),
                    child: const Text("Select Pictures",
                    style: TextStyle(
                      color: Colors.white
                    ),),
                ),
              ),
              const SizedBox(height: 12,),
              Align(
                  alignment: Alignment.bottomCenter,
                  child: ElevatedButton(
                      onPressed: postAd,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green.shade500
                    ),
                      child: const Text(
                        "Post this Ad",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.white),
                      ),
                  )
              ),
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
