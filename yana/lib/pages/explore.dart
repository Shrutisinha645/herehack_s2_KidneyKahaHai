import 'package:flutter/material.dart';
import 'package:yana/widgets/categories.dart';
import 'package:yana/widgets/navigator.dart';
import 'package:yana/widgets/ogsearch.dart';

import '../widgets/tags.dart';

class ExplorePage extends StatelessWidget {
  const ExplorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(
          Icons.arrow_back,
          color: Colors.black,
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Explore,',
                    style: TextStyle(fontSize: 40),
                  ),
                ),
              ),
              const CustomSearch(),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: const [
                    Tags(
                      title: 'Recommended',
                    ),
                    Tags(
                      title: 'Popular',
                    ),
                    Tags(
                      title: 'Recents',
                    ),
                    Tags(
                      title: 'Hidden',
                    ),
                  ],
                ),
              ),
              Card(
                clipBehavior: Clip.antiAlias,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Ink.image(
                      image: const AssetImage('assets/map.png'),
                      height: 180,
                      width: 320,
                      fit: BoxFit.cover,
                      // colorFilter: ColorFilers.greyscale,
                    ),
                    Column(
                      children: [
                        const Text(
                          textAlign: TextAlign.center,
                          'See whats good \nnear by',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 24),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blueGrey,
                          ),
                          child: const Text(
                            'Turn on location settings',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 15),
                          ),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: const [
                    Categories(
                      city: 'Beach',
                      img: AssetImage('assets/beach.png'),
                    ),
                    Categories(
                      city: 'Mountain',
                      img: AssetImage('assets/mountain.png'),
                    ),
                    Categories(
                      city: 'Temples',
                      img: AssetImage('assets/temple.png'),
                    ),
                    Categories(
                      city: 'Beach',
                      img: AssetImage('assets/beach.png'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const CustomNav(),
    );
  }
}
