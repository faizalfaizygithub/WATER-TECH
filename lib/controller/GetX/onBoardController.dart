import 'package:get/get.dart';
import 'package:water_tech/model/on_board.dart';

class OnBoardController extends GetxController {
  var loading = false.obs;

  final List<OnBoard> _onboardList = [
    OnBoard(
        imagePath: 'assets/onboard/page1.jpg',
        title: 'Select from Our Best Plans',
        caption: 'Pick your plans from our best 5 plans'),
    OnBoard(
        imagePath: 'assets/onboard/page22.png',
        title: 'Easy and Online Payment',
        caption: 'You can pay cash on delivery and any UPI apps or Card'),
    OnBoard(
        imagePath: 'assets/onboard/page3.jpg',
        title: 'Quick Service at Your Doorstep',
        caption: 'Quick Services and Best solutions for your problems'),
  ];

  List<OnBoard> get onboardList => _onboardList;
}
