import 'dart:async';

import 'package:flutter/material.dart';

class CarouselScreen extends StatefulWidget {
  final dynamic photos;
  bool isActive;

  CarouselScreen({super.key, this.photos, this.isActive = false});
  @override
  State<CarouselScreen> createState() => _CarouselScreenState();
}

class _CarouselScreenState extends State<CarouselScreen> {
  late PageController _pageController;
  num activePage = 0;
  @override
  void initState() {
    _pageController = PageController(initialPage: 0, viewportFraction: 0.8);
    autoScroll();
    super.initState();
  }

  void autoScroll() {
    Timer.periodic(Duration(seconds: 3), (timer) {
      if (mounted) {
        _pageController.nextPage(
            duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 200,
          width: MediaQuery.of(context).size.width,
          child: PageView.builder(
              scrollDirection: Axis.horizontal,
              controller: _pageController,
              itemCount: widget.photos.length * 1000,
              onPageChanged: (page) {
                num currentPage = page % widget.photos.length * 1000;
                print(currentPage);

                setState(() {
                  activePage = currentPage;
                });
              },
              itemBuilder: (context, pageposition) {
                num index = pageposition % widget.photos.length * 1000;
                bool active = index == activePage;
                return slider(widget.photos, pageposition, active);
              }),
        ),
        SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: imageIndicator(widget.photos.length, activePage),
        ),
      ],
    );
  }
}

AnimatedContainer slider(photos, pageposition, active) {
  int indexx = pageposition % photos.length;
  double margin = active ? 10 : 20;
  return AnimatedContainer(
    duration: const Duration(
      microseconds: 500,
    ),
    curve: Curves.bounceInOut,
    margin: EdgeInsets.all(margin),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(15),
      image: DecorationImage(
        fit: BoxFit.cover,
        image: AssetImage(photos[indexx]),
      ),
    ),
  );
}

List<Widget> imageIndicator(imagesLength, currentIndex) {
  return List<Widget>.generate(imagesLength, (index) {
    return Container(
      height: 10,
      width: 10,
      margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: currentIndex == index * 1000
              ? Colors.blue
              : Colors.grey.shade400),
    );
  });
}
