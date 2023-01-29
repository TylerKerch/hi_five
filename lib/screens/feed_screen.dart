import 'package:flutter/material.dart';

// GET URL OF IMAGES FROM CLOUD STORAGE
List<String> userImages = <String>[
  'assets/images/testpost.jpg',
  'assets/images/testpost2.jpg',
  'assets/images/testpost3.jpg',
];

List<String> employeePair = <String>[
  'The boys',
  'Tyler and Sean',
  'Tyler and Koki'
];

class FeedScreen extends StatefulWidget {
  const FeedScreen({Key? key}) : super(key: key);

  @override
  FeedScreenState createState() => FeedScreenState();
}


class LikeWidget extends StatefulWidget {
  const LikeWidget({Key? key}) : super(key: key);

  @override
  State<LikeWidget> createState() => _LikeWidgetState();
}

class _LikeWidgetState extends State<LikeWidget> {
  bool isPressed = false;
  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          setState(() {
            isPressed = !isPressed;
          });
        },
        color: isPressed ? const Color(0xFFFDDA0D) : Colors.black,
        icon: const Icon(Icons.thumb_up_sharp));
  }
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
        physics: const BouncingScrollPhysics(),
        itemCount: userImages.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            shape: const RoundedRectangleBorder( borderRadius: BorderRadius.all(Radius.circular(20))),
            elevation: 30,
            margin: const EdgeInsets.all(15),
            shadowColor: const Color(0xFF7fb1ff),
            child: Column (
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // PROFILE PICTURE INSIDE CONTAINER
                    Container(padding: EdgeInsets.fromLTRB(10, 10, 10, 10),child: CircleAvatar(child: Icon(Icons.account_circle_sharp)),),
                    // USERNAME TO BE INSERTED
                    Text(employeePair[index]),
                    Expanded(child: Container (alignment: Alignment.centerRight, padding: EdgeInsets.fromLTRB(0, 0, 10, 0), child: LikeWidget()))
                  ],
                ),
                // DISPLAY IMAGE FROM ARRAY
                Image.asset(userImages[index])
              ],
            ),
          );
        },
      )
    );
  }
}