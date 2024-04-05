import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:water_tech/view/tools/MyTextStyle.dart';
import 'package:water_tech/view/tools/assets.dart';
import 'package:water_tech/view/tools/carousel.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Water Tech ', style: subHeadingStyleBlue),
          actions: [
            Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.blue),
                  borderRadius: BorderRadius.circular(100),
                  color: Colors.white),
              height: 40,
              width: 40,
              child: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.person_2),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
          ],
          toolbarHeight: 100,
          foregroundColor: Colors.blue,
          backgroundColor: Colors.transparent,
          centerTitle: true,
        ),
        extendBodyBehindAppBar: true,
        drawer: const Drawer(),
        backgroundColor: Theme.of(context).colorScheme.background,
        body: Padding(
          padding: const EdgeInsets.only(top: 70.0, left: 15, right: 10),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            searchBarSec(),
            // Text("Hi: ${user!.email!}"),

            SizedBox(
              height: 20,
            ),
            Text(
              'Our Best Services',
              style: headingStyle,
            ),
            CarouselScreen(photos: banners),
          ]),
        ),
      ),
    );
  }

  searchBarSec() {
    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        height: 45,
        width: MediaQuery.of(context).size.width * 0.9,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.shade300,
                  offset: const Offset(4, 4),
                  blurRadius: 5),
            ]),
        child: TextField(
          decoration: InputDecoration(
            labelText: 'Search your service',
            labelStyle: smalltext,
            prefixIcon: const Icon(
              Icons.search,
              color: Colors.black54,
            ),
            border: const OutlineInputBorder(
              borderSide: BorderSide.none,
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          ),
        ),
      ),
    );
  }
}
