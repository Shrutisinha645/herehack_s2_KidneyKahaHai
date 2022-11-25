import 'package:flutter/material.dart';
import 'package:yana/pages/explore.dart';
import 'package:yana/widgets/card.dart';
import 'package:yana/widgets/navigator.dart';
import 'package:yana/widgets/tags.dart';

class HomePage extends StatelessWidget {
  static const List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    Text(
      'Index 1: Saved',
    ),
    Text(
      'Index 2: Explore',
    ),
    Text(
      'Index 3: Forum',
    ),
    Text(
      'Index 4: Profile',
    ),
  ];
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(top: 30),
          child: Image.asset(
            'assets/logo.png',
            fit: BoxFit.cover,
            height: 120,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: const Icon(Icons.menu, color: Colors.black),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 12.0),
            child: Icon(
              Icons.notifications,
              color: Colors.black,
            ),
          )
        ],
      ),
      // body: Center(
      //   child: _widgetOptions.elementAt(_selectedIndex),
      // ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: const [
                      Tags(title: 'Beach'),
                      Tags(title: 'Monuments'),
                      Tags(title: 'Mountains'),
                      Tags(title: 'Mountains'),
                      Tags(title: 'Mountains')
                    ],
                  ),
                ),
                const Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: EdgeInsets.only(top: 14, left: 14, right: 14),
                    child: Text(
                      'Top Picks For You',
                      style: TextStyle(fontSize: 25),
                    ),
                  ),
                ),
                const CustomCard(
                  city: 'Delhi',
                  img: AssetImage('assets/delhi.png'),
                ),
                const CustomCard(
                  city: 'Assam',
                  img: AssetImage('assets/assam.png'),
                ),
                const CustomCard(
                  city: 'Karnataka',
                  img: AssetImage('assets/karnataka.png'),
                ),
                const CustomCard(
                  city: 'Bangalore',
                  img: AssetImage('assets/delhi.png'),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.search),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ExplorePage()),
            );
          }),
      bottomNavigationBar: const CustomNav(),
    );
  }
}
