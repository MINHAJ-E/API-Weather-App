import 'package:flutter/material.dart';

class HaiPicture extends StatelessWidget {
  const HaiPicture({super.key, required this.picture});
  final String picture;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      width: 30,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(picture),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class HaiText extends StatelessWidget {
 const  HaiText({super.key, required this.textt, required this.sizze});
  final String textt;
  final double sizze;
  @override
  Widget build(BuildContext context) {
    return Text(
      textt,
      style:  TextStyle(color: Colors.white, fontWeight: FontWeight.bold,fontSize: sizze),
    );
  }
}
class AppText extends StatelessWidget {
  String? data;
  double? size;
  Color? color;
  FontWeight? fw;
  TextAlign? align;
  AppText({Key? key, required this.data, this.size, this.color, this.fw,this.align=TextAlign.left})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(

      data.toString(),
      textAlign: align,
      style: TextStyle(fontSize: size, color: color,fontWeight: fw,fontFamily: "Roboto"),
    );
  }
}

