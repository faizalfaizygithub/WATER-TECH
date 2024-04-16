import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:water_tech/controller/home_provider_controller.dart';
import 'package:water_tech/model/Service.dart';
import 'package:water_tech/view/pages/orderConfirmed.dart';
import 'package:water_tech/view/tools/MyTextStyle.dart';
import 'package:water_tech/view/tools/my_button.dart';

class SchedulePage extends StatefulWidget {
  final Service? service;
  const SchedulePage({
    super.key,
    required this.service,
  });

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  TextEditingController timeController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController amtController = TextEditingController();

//RAZORE PAY PAYMENT INTEGRATION METHOD

  late Razorpay _razorpay;

  void openCheckout(amount) async {
    amount = amount * 100;
    var options = {
      'key': 'rzp_test_1DP5mmOlF5G5ag',
      'amount': amount,
      'name': 'WaterTech Melattur',
      'prefill': {'contact': '9847959648', 'email': 'faizalfaizy648@gmail.com'},
      'external': {
        'wallets': ['paytm']
      }
    };
    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint('Error:e');
    }
  }

  void handlePaymentSuccess(PaymentSuccessResponse response) {
    Fluttertoast.showToast(
        msg: 'Payment Succesful${response.paymentId!}',
        toastLength: Toast.LENGTH_SHORT);
  }

  void handlePaymentError(PaymentFailureResponse response) {
    Fluttertoast.showToast(
        msg: 'Payment Fail${response.message!}',
        toastLength: Toast.LENGTH_SHORT);
  }

  void handleExternalWallet(ExternalWalletResponse response) {
    Fluttertoast.showToast(
        msg: 'External Wallet${response.walletName!}',
        toastLength: Toast.LENGTH_SHORT);
  }

  @override
  void dispose() {
    super.dispose();

    _razorpay.clear();
  }

  @override
  void initState() {
    super.initState();

    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handleExternalWallet);
  }

//END RAZORE PAY CODE

  @override
  Widget build(
    BuildContext context,
  ) {
    final serviceData = context.watch<HomeProviderController>().serviceList;

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
        title: Text(' Book Schedule', style: BlueheadingStyle),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Select Date & Time :',
                style: subHeadingStyleBlue,
              ),
              const SizedBox(
                height: 10,
              ),
              customTextForm(
                'Pick your date',
                () async {
                  final DateTime? _date = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2010),
                      lastDate: DateTime(2050));

                  setState(() {
                    dateController.text = _date.toString().split(" ")[0];
                  });
                },
                const Icon(Icons.calendar_month_outlined),
                1,
                true,
                dateController,
              ),
              const SizedBox(
                height: 10,
              ),
              customTextForm('Pick your time', () async {
                TimeOfDay? _time = await showTimePicker(
                    context: context, initialTime: TimeOfDay.now());
                setState(() {
                  timeController.text = _time!.format(context);
                });
              }, const Icon(Icons.punch_clock), 1, true, timeController),
              const SizedBox(
                height: 20,
              ),
              Text(
                'Address :',
                style: subHeadingStyleBlue,
              ),
              customTextForm('enter full address', () => null,
                  const Icon(Icons.location_pin), 3, false, addressController),
              const SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image.asset(
                      'assets/photo/googlemap.png',
                      height: 30,
                      width: 30,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Share Google Location',
                      style: subHeadingStyleBlue,
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'Place & City:',
                style: subHeadingStyleBlue,
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                'Malappuram',
                style: greySmalltext,
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                'Lattitude & Longittude Value:',
                style: subHeadingStyleBlue,
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                '133255421254',
                style: greySmalltext,
              ),
              const SizedBox(
                height: 20,
              ),
              payButton()
            ],
          ),
        ),
      ),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(),
          SizedBox(
              width: 120,
              height: 70,
              child: MyButton(
                  txt: 'Confirm Booking',
                  ontap: () {
                    Get.to(const OrderConfirmedPage());
                  })),
        ],
      ),
    );
  }

  customTextForm(
    String hintTxt,
    Function() buttonAction,
    Icon suffixIcon,
    int maxLine,
    bool readme,
    TextEditingController controller,
  ) {
    return TextFormField(
      maxLines: maxLine,
      style: blacktextStyle,
      readOnly: readme,
      controller: controller,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.grey.shade500)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.grey.shade500)),
        hintText: hintTxt,
        hintStyle: greySmalltext,
        filled: true,
        suffixIcon: IconButton(
            onPressed: buttonAction,
            icon: suffixIcon,
            color: Colors.grey.shade600),
      ),
    );
  }

  payButton() {
    return Container(
      color: Theme.of(context).colorScheme.primary,
      height: 70,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(
            "₹ ${widget.service!.price.toString()}",
            style: blacktextStyle,
          ),
          GestureDetector(
            onTap: () {
              if (widget.service!.price.toString().isNotEmpty) {
                setState(() {
                  double amount = double.parse(
                    widget.service!.price.toString(),
                  );
                  openCheckout(amount);
                });
              }
            },
            child: Container(
              alignment: Alignment.center,
              height: 40,
              width: 120,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.inversePrimary,
                boxShadow: const [
                  BoxShadow(
                      color: Colors.white, offset: Offset(2, 2), blurRadius: 2)
                ],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text('Pay Now', style: buttonStyle),
            ),
          ),
        ]),
      ),
    );
  }
}
