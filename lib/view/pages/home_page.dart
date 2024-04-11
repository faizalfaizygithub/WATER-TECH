import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:water_tech/controller/home_provider_controller.dart';
import 'package:water_tech/view/tools/MyTextStyle.dart';
import 'package:water_tech/view/tools/assets.dart';
import 'package:water_tech/view/tools/carousel.dart';
import 'package:water_tech/view/tools/my_servicelist_tile.dart';

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

    final serviceData = context.watch<HomeProviderController>().serviceList;
    return ListView(
        padding: EdgeInsets.only(left: 10, right: 10, bottom: 20),
        children: [
          const SizedBox(
            height: 50,
          ),
          appBarSection(user),
          searchBarSec(),
          Text('Latest Services', style: subHeadingStyleBlue),
          Container(
            height: 250,
            width: double.infinity,
            child: CarouselScreen(
              photos: banners,
            ),
          ),
          Text('Select Category', style: subHeadingStyleBlue),
          SizedBox(
            height: 650,
            width: size.width,
            child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: serviceData.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 1 / 1.8, crossAxisCount: 2),
                itemBuilder: (context, index) {
                  final data = serviceData[index];
                  return MyServiceListTile(service: data);
                }),
          ),
          SizedBox(
            height: 10,
          ),
          capsuleTankSec(),
        ]);
  }

  appBarSection(user) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.menu),
          ),
          Text(
            "Hi, ${user!.email!}",
            style: subHeadingStyleBlue,
          ),
          trailingsEC()
        ],
      ),
    );
  }

  trailingsEC() {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.blue),
          borderRadius: BorderRadius.circular(100),
          color: Theme.of(context).colorScheme.primary),
      height: 40,
      width: 40,
      child: IconButton(
        onPressed: () {},
        icon: const Icon(Icons.person_2),
      ),
    );
  }

  searchBarSec() {
    return Container(
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
          labelStyle: greySmalltext,
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
    );
  }

  capsuleTankSec() {
    return ListTile(
      tileColor: Colors.grey.shade300,
      isThreeLine: true,
      leading: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.asset('assets/photo/capsule.png')),
      title: Text('CAPSULE TANK', style: subHeadingStyleBlue),
      subtitle: Text('Just 100+ extra', style: greySmalltext),
      trailing: IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.arrow_forward_ios,
            color: Colors.blue,
          )),
    );
  }
}
