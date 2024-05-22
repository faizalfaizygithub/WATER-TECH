import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:water_tech/controller/Provider/home_provider_controller.dart';
import 'package:water_tech/model/Service.dart';
import 'package:water_tech/view/pages/mainPage.dart';
import 'package:water_tech/view/pages/shedule_page.dart';
import 'package:water_tech/view/tools/MyTextStyle.dart';
import 'package:water_tech/view/tools/my_button.dart';

class OrderConfirmedPage extends StatefulWidget {
  final SchedulePage? schedulePage;
  final Service? service;

  const OrderConfirmedPage({
    super.key,
    required this.service,
    this.schedulePage,
  });

  @override
  State<OrderConfirmedPage> createState() => _OrderConfirmedPageState();
}

class _OrderConfirmedPageState extends State<OrderConfirmedPage> {
  TextEditingController _dateController = TextEditingController();

  get date => date;

  @override
  Widget build(BuildContext context) {
    final data = context.watch<HomeProviderController>();
    // Ensure service is not null before accessing its properties
    // final serviceName = widget.service?.name ?? widget.service!.name;

    return Scaffold(
      appBar: AppBar(
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('Order Booked', style: BlueheadingStyle),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Lottie.asset('assets/json/tick.json', height: 200, width: 250),
              Text(
                'Booking Successful',
                style: BlueheadingStyle,
              ),
              Text('Order ID: 2701', style: greySmalltext),
              Card(
                color: Colors.white,
                elevation: 10,
                margin: const EdgeInsets.all(10),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Dear customer, Thank you so much for your order. Very soon our professional will contact you.',
                    style: blacksmalltext,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            'Service:',
                            style: subHeadingStyleBlue,
                          ),
                        ),
                        const SizedBox(
                          width: 100,
                        ),
                        Expanded(
                          child: Text(
                            "'WaterTank '${widget.service!.name}",
                            style: greySmalltext,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total Amount:',
                          style: subHeadingStyleBlue,
                        ),
                        Text(
                          "₹ ${widget.service!.price.toString()}",
                          style: blacktextStyle,
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Payment Status: ', style: greySmalltext),
                        Text(
                          'paid',
                          style: greySmalltext,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Divider(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Selected Date and Time', style: subHeadingStyleBlue),
                  Text(
                    '26/05/2024',
                    style: greySmalltext,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "10:00AM",
                        style: greySmalltext,
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  Expanded(
                    child: MyButton(
                      color: Colors.black87,
                      txt: 'Track Booking',
                      ontap: () {},
                    ),
                  ),
                  const SizedBox(
                    width: 30,
                  ),
                  Expanded(
                    child: MyButton(
                      color: Theme.of(context).colorScheme.inversePrimary,
                      txt: 'Home',
                      ontap: () {
                        Get.to(const MainPage());
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 50,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
