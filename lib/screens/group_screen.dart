import 'package:flutter/material.dart';
import 'dart:math';

class GroupScreen extends StatefulWidget {
  const GroupScreen({Key? key}) : super(key: key);

  @override
  GroupScreenState createState() => GroupScreenState();
}

class GroupScreenState extends State<GroupScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // 14 entries
    List<String> entries = <String>[
      'Caleb',
      'Aaron',
      'Erik',
      'Tyler',
      'Nathan',
      'Sean',
      'Koki',
      'Emily',
      'Keisha',
      'Cameron',
      'Alexander',
      'Austin',
      'Kevin',
      'Andrew'
    ];
    List<String> positions = <String>[
      'Chief marketing officer',
      'Manager',
      'Product Manager',
      'Business analyst',
      'Business analyst',
      'Sales representative',
      'Software Engineer',
      'Software Engineer',
      'Applications Engineer',
      'Digital Marketing Manager',
      'Information Architect',
      'UX Designer',
      'UI Designer',
      'Front-End Designer'
    ];

    Random random = new Random();
    var streaks = List<int>.generate(
      entries.length,
      (index) {
        int num = random.nextInt(70);
        return num;
      },
    );
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Center(
          child: Text('Group'),
        ),
      ),
      body: ListView.builder(
        itemCount: entries.length,
        itemBuilder: (name, index) {
          // return ListTile(
          //   leading: const Icon(Icons.account_circle_sharp),
          //   title: Text(entries[index]),
          //   trailing: Text("${streaks[index]} days"),
          // );
          return Container(
              padding: EdgeInsets.all(2),
              decoration: new BoxDecoration(boxShadow: [
                new BoxShadow(color: Colors.black26, blurRadius: 10)
              ]),
              child: Card(
                  color: Color(0xFFf5f7f9),
                  child: SizedBox(
                      width: 300,
                      height: 80,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ListTile(
                            leading: Icon(Icons.account_circle_sharp,
                                size: 35, color: Color(0xFFb1ddf1)),
                            title: Center(
                                child: Text(
                              entries[index],
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            )),
                            subtitle: Center(child: Text(positions[index])),
                            trailing: Text('${streaks[index]}  days'),
                          ),
                        ],
                      ))));
        },
      ),
    );
  }
}
