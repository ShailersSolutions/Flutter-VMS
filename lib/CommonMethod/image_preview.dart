import 'package:flutter/material.dart';

class ImagePreview extends StatefulWidget {
  String imageUrl;
  ImagePreview({this.imageUrl});

  @override
  _ImagePreviewState createState() => _ImagePreviewState();
}

class _ImagePreviewState extends State<ImagePreview> {

  var height,width;

  @override
  Widget build(BuildContext context) {

    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    print(widget.imageUrl);

    return Scaffold(
      body: Center(
        child: Container(
          height: height*0.5,
          width: width,
          color: Colors.blue,
          child: Image.network(widget.imageUrl,fit: BoxFit.cover,),
        ),
      ),
    );
  }
}
