import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class LoadShimmer extends StatefulWidget {
  const LoadShimmer({super.key});

  @override
  State<LoadShimmer> createState() => _LoadShimmerState();
}

class _LoadShimmerState extends State<LoadShimmer> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: ShimmerWidget.circular(
        height: 64,
        width: 64,
      shapeBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12)
      )),
      title: ShimmerWidget.rectangular(height: 16),
      subtitle: ShimmerWidget.rectangular(height: 14),
    );
  }
}

class ShimmerWidget extends StatelessWidget{

  final double width;
  final double height;
  final ShapeBorder shapeBorder;

  const ShimmerWidget.rectangular({
    this.width = double.infinity,
    required this.height
}) : this.shapeBorder = const RoundedRectangleBorder();

  const ShimmerWidget.circular({
    this.width = double.infinity,
    required this.height,
    this.shapeBorder = const CircleBorder()
  });

  @override
  Widget build(BuildContext context) {

    return Shimmer.fromColors(
        baseColor: Colors.grey.shade400,
        highlightColor: Colors.grey.shade300,
        child: Container(
      width: width,
      height: height,
      decoration: ShapeDecoration(
          color: Colors.grey,
          shape: shapeBorder
      ),
    ));
  }
  
}
