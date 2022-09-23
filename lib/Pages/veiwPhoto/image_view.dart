import 'package:flutter/material.dart';

class ImageViewScreen extends StatefulWidget {
  final String? image;
  final String? body;

  const ImageViewScreen({Key? key, required this.image, required this.body})
      : super(key: key);

  @override
  _ImageViewScreenState createState() => _ImageViewScreenState();
}

class _ImageViewScreenState extends State<ImageViewScreen> {
  bool showText = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: InkWell(
          onTap: () {
            setState(() {
              showText = !showText;
            });
          },
          child: Stack(
            alignment: AlignmentDirectional.bottomCenter,
            children: [
              Image.network(
                "${widget.image}",
                height: double.infinity,
                width: double.infinity,
                alignment: Alignment.center,
              ),
              if (showText == true && widget.body != '')
                Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Colors.black,
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        '${widget.body}',
                        style: const TextStyle(fontSize: 15),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
