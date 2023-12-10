import 'package:flutter/material.dart';
import 'package:flutter_project/Models/HouseModel.dart';

class HouseCard extends StatefulWidget {
   HouseCard(this.house, this.onTap, {super.key});
  HouseModel house;
  Function()? onTap;

  @override
  State<HouseCard> createState() => _HouseCardState();
}

class _HouseCardState extends State<HouseCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      margin: const EdgeInsets.only(right: 20),
      decoration: BoxDecoration(
        color: const Color(0xfffcf9f8),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade200)
      ),
      child: InkWell(
        onTap: widget.onTap,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                height: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.grey.shade200,
                  image: const DecorationImage(
                      image: NetworkImage("https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885_1280.jpg"),
                  fit: BoxFit.cover)
                ),
              ),
              const SizedBox(height: 12,),
              Text(widget.house.propertyType!,
              style: TextStyle(
                color: Colors.green.shade500,
                fontSize: 18,
                fontWeight: FontWeight.bold
              ),),
              const SizedBox(height: 8,),
              Text(widget.house.title!,
                style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                overflow: TextOverflow.ellipsis
              ),),
              const SizedBox(height: 8,),
              Row(
                children: [
                  Icon(Icons.location_on,
                      color: Colors.green.shade500,),
                  Text(widget.house.address!,
                  style: const TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 16,
                    color: Colors.grey
                  ),
                    overflow: TextOverflow.ellipsis,
                  )
                ],
              ),
              const SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("PKR.${widget.house.price}",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22
                      ),
                  overflow: TextOverflow.ellipsis),
                  IconButton(onPressed: (){}, icon: const Icon(Icons.favorite_outline))
                ],
              )
            ],
        ),
        ),
      ),
    );
  }
}
