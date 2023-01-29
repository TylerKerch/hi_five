import 'package:flutter/material.dart';
import 'dart:math';

class Employee {
  String name = "";
  int streakCount = 0;
  String position = "";

  Employee(String n, int sCount, String p) {
    name = n;
    streakCount = sCount;
    position = p;
  }
}

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
    // 14 entries, Employee list and positions
    List<Employee> entries = <Employee>[
      Employee('Caleb', 5, 'CEO'),
      Employee('Aaron', 3, 'Manager'),
      Employee('Erik', 5, 'Product Manager'),
      Employee('Tyler', 21, 'Business analyst'),
      Employee('Nathan', 41, 'Business Analyst'),
      Employee('Sean', 21, 'Sales Engineer'),
      Employee('Koki', 31, 'Software Engineer'),
      Employee('Emily', 5, 'Software Engineer'),
      Employee('Keisha', 10, 'Intern'),
      Employee('Cameron', 3, 'Data Scientist'),
      Employee('Alexander', 0, 'UX Designer'),
      Employee('Austin', 12, 'UI Designer'),
      Employee('Kevin', 5, 'Front-End Designer'),
      Employee('Andrew', 54, 'Mobile Developer')
    ];
    bool fiveStreak(int sCount) {
      return (sCount % 5 == 0) && (sCount != 0);
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: AppBar(
            leadingWidth: 300,
            toolbarHeight: 100,
            centerTitle: true,
            title: const Text('hiFive!',
                style: TextStyle(color: Colors.black, fontSize: 35)),
            backgroundColor: Colors.white,
            leading: Padding(
                padding: EdgeInsets.only(left: 10),
                child: Image.asset(
                  "assets/images/hifive_logo.png",
                )),
            elevation: 0),
      ),
      body: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: entries.length,
        itemBuilder: (name, index) {
          return Container(
              padding: const EdgeInsets.all(2),
              decoration: const BoxDecoration(boxShadow: [
                BoxShadow(color: Colors.black26, blurRadius: 10)
              ]),
              child: Card(
                  color: const Color(0xFFf5f7f9),
                  child: SizedBox(
                      width: 300,
                      height: 80,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ListTile(
                              leading: Container(
                                padding: const EdgeInsets.fromLTRB(0, 0, 50, 0),
                                child: const Icon(Icons.account_circle_sharp,
                                    size: 35, color: Color(0xFFb1ddf1)),
                              ),
                              title: Center(
                                  child: Text(
                                entries[index].name,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              )),
                              subtitle:
                                  Center(child: Text(entries[index].position)),
                              trailing: SizedBox(
                                width: 100,
                                child: Center(
                                  child: Row(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.fromLTRB(
                                            50, 0, 0, 0),
                                        child: Text(
                                            '${entries[index].streakCount}'),
                                      ),
                                      if (fiveStreak(
                                          entries[index].streakCount))
                                        const Icon(
                                          Icons.local_fire_department,
                                          size: 25,
                                          color: Colors.red,
                                        )
                                    ],
                                  ),
                                ),
                              )),
                        ],
                      ))));
        },
      ),
    );
  }
}
