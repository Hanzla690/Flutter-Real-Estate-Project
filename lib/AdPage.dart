import 'dart:html';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdPage extends StatefulWidget {
  const AdPage({super.key});

  @override
  State<AdPage> createState() => _AdPageState();
}

class _AdPageState extends State<AdPage> {

  late InterstitialAd interstitialAd;
  bool isAdLoaded =  false;
  String adUnit = "ca-app-pub-3940256099942544/1033173712";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initIntersstitialAd();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ad Page"),
        centerTitle: true,
      ),

      body: Center(
        child: ElevatedButton(
            onPressed: (){
              if(isAdLoaded){
                interstitialAd.show();
              }
            },
            child: const Text("Task completed")),
      ),
    );
  }

  initIntersstitialAd(){
    InterstitialAd.load(
        adUnitId: adUnit,
        request: AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
            onAdLoaded: (ad){
              interstitialAd = ad;
              setState(() {
                isAdLoaded = true;
              });
            },
            onAdFailedToLoad: (error){
              interstitialAd.dispose();
            }));
  }
}
