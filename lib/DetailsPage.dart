import 'package:flutter/material.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({super.key});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 3,
        backgroundColor: Colors.grey.shade100,
        toolbarHeight: 80,
        title: Row(
          children: [
            Icon(
              Icons.other_houses_outlined,
              color: Colors.green.shade500,
            ),
            const Text("Property Description",
              style: TextStyle(
                  color: Colors.black
              ),),
          ],
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            Image.asset("assets/zameen.jpeg",
            width: 300,
            height: 300),
            Expanded(
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(16),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30)
                    )
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Expanded(
                                child: Text("Jordan",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold
                                ),)),
                            SizedBox(width: 30),
                            Container(
                              padding: EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Colors.green.shade200,
                                borderRadius: BorderRadius.circular(8)
                              ),
                              child: const Text("Rs.10000",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20,),
                        Text("Description",
                            style: TextStyle(
                                color: Colors.grey.shade500,
                                fontSize: 15
                            ))
                      ],
                    ),

                  ),
                )
            )
          ],
        ),
      ),
    );
  }
}
