import 'package:flutter/material.dart';

List<String> userImages = <String>[
  'assets/images/testpost.jpg',
  'assets/images/testpost2.jpg',
  'assets/images/testpost3.jpg',
];

class FeedScreen extends StatefulWidget {
  const FeedScreen({Key? key}) : super(key: key);

  @override
  FeedScreenState createState() => FeedScreenState();
}

class FeedScreenState extends State<FeedScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Center(
          child: Text('hiFive!'),
        ),
      ),
      body: ListView.builder(
        itemCount: userImages.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            child: Image.asset(userImages[index]),
          );
        },
      )
    );
  }
}