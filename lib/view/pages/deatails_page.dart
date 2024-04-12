import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:water_tech/model/Service.dart';
import 'package:water_tech/view/pages/shedule_page.dart';
import 'package:water_tech/view/tools/MyTextStyle.dart';
import 'package:water_tech/view/tools/assets.dart';

class DeatailsPage extends StatelessWidget {
  final Service? service;
  const DeatailsPage({super.key, required this.service});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_back_ios_new,
                    color: Colors.blue,
                  ),
                ),
                Text(
                  'Our Best Services ',
                  style: subHeadingStyleBlue,
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              height: 360,
              width: double.infinity,
              child: Swiper(
                itemBuilder: (context, index) {
                  final image = serviceImages[index];
                  return Image.asset(
                    image,
                    fit: BoxFit.cover,
                  );
                },
                indicatorLayout: PageIndicatorLayout.COLOR,
                autoplay: true,
                itemCount: serviceImages.length,
                pagination: const SwiperPagination(),
                control: const SwiperControl(),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Card(
              elevation: 7,
              child: ListTile(
                  tileColor: Theme.of(context).colorScheme.primary,
                  title: Text(
                      overflow: TextOverflow.ellipsis,
                      "Water Tank \n${service!.name}",
                      style: subHeadingStyleBlue),
                  subtitle:
                      Text("₹ ${service!.price}-/", style: blacktextStyle),
                  trailing: box(context, 'Book Now',
                      Theme.of(context).colorScheme.inversePrimary, () {})),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(captionHead, style: subHeadingStyleBlue),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 15),
              child: Text(quotes, style: blacksmalltext),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15.0, left: 15, right: 15),
              child: Text(titleOne, style: subHeadingStyleBlue),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 15, left: 15.0, right: 15, bottom: 20),
              child: Text(points, style: blacksmalltext),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        color: Theme.of(context).colorScheme.primary,
        height: 70,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("₹ ${service!.price}-/", style: blacktextStyle),
              box(context, 'Continue', Colors.black26, () {
                Get.to(SchedulePage(),
                    transition: Transition.fadeIn,
                    duration: Duration(seconds: 2));
              })
            ],
          ),
        ),
      ),
    );
  }

  box(BuildContext context, String txt, Color color, Function() ontap) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        alignment: Alignment.center,
        height: 40,
        width: 120,
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
              color: Colors.grey.shade500,
              offset: const Offset(4, 4),
              blurRadius: 3)
        ], borderRadius: BorderRadius.circular(10), color: color),
        child: Text(txt, style: buttonStyle),
      ),
    );
  }
}
