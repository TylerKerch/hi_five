import 'dart:ui';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


// PLACEHOLDER VARIABLES

//Users streak counter
int streak = 69;

// Users name
String usersName = 'Alan Turing';

// Either member or administrator. Allows for different access
String usersType = 'Administrator';

// App version
String version = "X.XX.XX";

/* ADMINISTRATOR STUFF */
// BALANCE ON ACCOUNT
double balance = 5000.00;
// STREAK NEEDED
int minStreak = 5;
// REWARD AMOUNT
double reward = 5.00;




class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  ProfileScreenState createState() => ProfileScreenState();
}

enum PopupMenu {
  item1,
  item2,
  item3, // ADMINISTRATOR ONLY
}


class ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Colors.white,

        // extendBodyBehindAppBar: true,
        appBar: AppBar(

          title: Text('Profile'),
          actions: [
            PopupMenuButton(
              onSelected: (value) {
                if(value == PopupMenu.item1) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AboutPage()),
                  );
                }
                else if (value == PopupMenu.item2){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SettingsPage()),
                  );
                }
                else if(value == PopupMenu.item3) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AdminPage()),
                  );
                }
              },
              itemBuilder: (context) => [
              const PopupMenuItem(
                  value: PopupMenu.item1,
                  child: Text("About")
              ),
              const PopupMenuItem(
                  value: PopupMenu.item2,
                  child: Text("Settings")
              ),
                const PopupMenuItem(
                    value: PopupMenu.item3,
                    child: Text("Administrator Settings")
                )
            ],
            ),
            
          ],
          centerTitle: true,
          backgroundColor: Colors.black,
          elevation: 0,
          toolbarOpacity: 1,
        ),


        body: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: Center(
            child: Column(
                children: [
                  const SizedBox(height: 30),
                  Image.asset('assets/images/alan_turing_new.png'),
                  Container(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                    child: Text(
                      "${usersName}",
                      style: const TextStyle(fontSize: 40, color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height:35),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: Image.asset('assets/images/hifive_logo.png'),
                        iconSize: 100,
                          onPressed: ()  {
                          final player = AudioPlayer();
                          player.play(AssetSource('audio/highfivesound.mp3'));
                          }
                          //=> AudioPlayer().setSource(AssetSource('audio/clapnoise.mp3'))
                      ),
                      Container(
                        child: Text(
                          "${streak}",
                          style: TextStyle(fontSize: 50, color: Colors.black),
                        ),
                      ),

                    ]
                  ),
                  //SizedBox(height: 20),
                  const TextButton(onPressed: null,
                    child: Text(
                      "Log out",
                      style: TextStyle(fontSize: 20, color: Color(0xFF9ed4ff)),
                    ),
                  ),
                ],


            ),
        ),
        ),

      floatingActionButton: FloatingActionButton(
        heroTag: 'img',
        backgroundColor: Colors.black,
        //color: Color(0xFF7fb1ff),
        child: const Icon(
            Icons.qr_code,
          ),

        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ProfileQR()),
          );
        },
      ),
    );

  }

}


class ProfileQR extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: Center(
        child: Column(
          children: [
            SizedBox(height: 250),
            ElevatedButton(
              style: const ButtonStyle(
                backgroundColor: MaterialStatePropertyAll<Color>(Colors.white),

              ),
              child: Hero(
                tag: 'img',
                child: Image.asset('assets/images/Rickrolling_QR_code.png'),
              ),
              onPressed: () {
                Navigator.pop(context);
              },

            ),
            Container(
              child: Text(
                "@${usersName}",
                style: TextStyle(fontSize: 50, color: Color(0xFF7fb1ff)),
              ),
            )
        ]
        ),


        ),
          floatingActionButton: FloatingActionButton(
          heroTag: 'img',
          backgroundColor: Colors.black,
          child: const Icon(Icons.close),

          onPressed: () {
            Navigator.pop(context);
          },
        ),
      );

  }

}

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: Center(
        child: Column(
          children: [
            SizedBox(height: 400),
            Text('Role: ${usersType}'),
            Text('Version: ${version}'),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        heroTag: 'img',
        backgroundColor: Colors.black,
        child: const Icon(Icons.close),

        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );

  }
}

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      floatingActionButton: FloatingActionButton(
        heroTag: 'img',
        backgroundColor: Colors.black,
        child: const Icon(Icons.close),

        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );

  }

}

class AdminPage extends StatelessWidget {
  const AdminPage({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,


      appBar: AppBar(
        title: Text('Administrative Settings'),
        backgroundColor: Colors.black,
      ),

      body: ListView(
          children: [
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center, //Center Row contents horizontally,
              children: [
                const Icon(
                    Icons.lock_person_outlined,
                  size: 50,

                ),
                Text(
                  "Wallet",
                  style: TextStyle(fontSize: 50, color: Colors.black, fontWeight: FontWeight.bold),
                ),
              ],
            ),

            SizedBox(height: 50),
            Container(
              alignment: Alignment.center,
              child: const Text(
                "Balance",
                style: TextStyle(fontSize: 20, color: Colors.grey),
              ),
            ),
            Container(
              alignment: Alignment.center,
              child: Text(
                "\$${balance}",
                style: TextStyle(fontSize: 75, color: Colors.black, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 50),
            Text(
              "Payment methods",
              style: TextStyle(fontSize: 15, color: Colors.grey),
            ),

            TextFormField(
              autofocus:true,
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  // for below version 2 use this
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                  FilteringTextInputFormatter.digitsOnly

                ],

                decoration: InputDecoration(
                    labelText: "Visa ending in XXXX",
                    hintText: "Enter amount to deposit",
                    icon: Icon(Icons.payment)
                )
            ),

            SizedBox(height: 75),

            Text(
              "Reward control",
              style: TextStyle(fontSize: 15, color: Colors.grey),
            ),

            TextFormField(
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  // for below version 2 use this
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                  FilteringTextInputFormatter.digitsOnly

                ],
                decoration: InputDecoration(
                    labelText: "Streak required for reward: (Current: ${minStreak})",
                    hintText: "Change value: ",
                    icon: Icon(Icons.group)
                )
            ),

            TextFormField(
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  // for below version 2 use this
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                  FilteringTextInputFormatter.digitsOnly

                ],
                decoration: InputDecoration(
                    labelText: "Reward amount (Current: \$${reward})",
                    hintText: "Change value: ",
                    icon: const Icon(Icons.celebration)
                )
            ),


          ],
        )

    );

  }

}