import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:water_tech/view/tools/MyTextStyle.dart';
import 'package:water_tech/view/tools/my_button.dart';

class OrderConfirmedPage extends StatefulWidget {
  const OrderConfirmedPage({super.key});

  @override
  State<OrderConfirmedPage> createState() => _OrderConfirmedPageState();
}

class _OrderConfirmedPageState extends State<OrderConfirmedPage> {
  @override
  Widget build(BuildContext context) {
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
        title: Text(' Order Booked', style: BlueheadingStyle),
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
                    'Dear customer , Thank you so much for your order . Very soon our professional will contact you. ',
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
                            ' Category:',
                            style: subHeadingStyleBlue,
                          ),
                        ),
                        SizedBox(
                          width: 110,
                        ),
                        Expanded(
                          child:
                              Text('WaterTank 750 LTR', style: greySmalltext),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total Amount:',
                          style: subHeadingStyleBlue,
                        ),
                        Text('650', style: blacktextStyle)
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
                    '12/4/2024',
                    style: greySmalltext,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        '12:00',
                        style: greySmalltext,
                      ),
                      Text(
                        ':',
                      ),
                      Text(
                        '12:59',
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
                      txt: 'Track Booking',
                      ontap: () {},
                    ),
                  ),
                  const SizedBox(
                    width: 30,
                  ),
                  Expanded(
                    child: MyButton(
                      txt: 'home',
                      ontap: () {},
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
