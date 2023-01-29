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
    Random random = new Random();
    var streaks = List<int>.generate(
      entries.length,
      (index) {
        int num = random.nextInt(70);
        return num;
      },
    );
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF9ed4ff),
        title: const Center(
          child: Text('hiFive'),
        ),
      ),
      body: ListView.separated(
        itemCount: entries.length,
        separatorBuilder: (context, index) {
          return const Divider();
        },
        itemBuilder: (name, index) {
          return ListTile(
            leading: Icon(Icons.account_circle_sharp),
            title: Text(entries[index]),
            trailing: Text(streaks[index].toString() + " days"),
          );
        },
      ),
    );
  }
}
