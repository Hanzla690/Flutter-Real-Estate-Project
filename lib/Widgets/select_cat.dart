import 'package:flutter/material.dart';

class SelectCategory extends StatefulWidget {
  const SelectCategory({super.key});

  @override
  State<SelectCategory> createState() => _SelectCategoryState();
}

class _SelectCategoryState extends State<SelectCategory> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130,
      width: double.infinity,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          CategoryButton(Icons.house_outlined, "Houses"),
          CategoryButton(Icons.landscape_outlined, "Plots"),
          CategoryButton(Icons.apartment_outlined, "Apartments"),
          CategoryButton(Icons.monetization_on_outlined, "Rent"),
          CategoryButton(Icons.shopping_bag_outlined, "Commercial"),
        ],
      ),
    );
  }
}

Widget CategoryButton(IconData icon, String? text){
  return Container(
    padding: const EdgeInsets.all(8),
    width: 80,
    height: 80,
    margin: EdgeInsets.all(18),
    decoration: BoxDecoration(
      border: Border.all(color: Colors.grey.shade100)
    ),
    child: InkWell(
      onTap: (){},
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(icon,
          size: 32,
          color: Colors.green.shade500),
          Text("$text")
        ],
      ),
    ),
  );
}
