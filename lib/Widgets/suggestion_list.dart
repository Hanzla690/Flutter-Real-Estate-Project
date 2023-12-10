import 'package:flutter/material.dart';
import 'package:flutter_project/Models/HouseModel.dart';

import 'house_card.dart';

class SuggestionList extends StatefulWidget {
  SuggestionList(this.title, this.houses, {Key? key}) : super(key: key);

  final String title;
  final List<HouseModel> houses;

  @override
  State<SuggestionList> createState() => _SuggestionListState();
}

class _SuggestionListState extends State<SuggestionList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400, // Set a fixed height or adjust as needed
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                ),
              ),
              TextButton(onPressed: () {}, child: const Text("See All")),
              const SizedBox(width: 12),
            ],
          ),
          Expanded(
            child: Container(
              height: 340,
              width: double.maxFinite,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: widget.houses.length,
                itemBuilder: (context, index) =>
                    HouseCard(widget.houses[index], () {
                    //  Navigator.push(context, MaterialPageRoute(builder: (context)=> DetailsScreen(widget.houses[index])));
                    }),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
