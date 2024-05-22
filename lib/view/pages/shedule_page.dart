import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:water_tech/controller/GetX/onBoardController.dart';
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
  final controller = Get.put(OnBoardController());

  TextEditingController timeController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  TextEditingController get _dateController => dateController;
  final TextEditingController addressController = TextEditingController();
  final TextEditingController amtController = TextEditingController();

  //

  //to DB

  final CollectionReference work =
      FirebaseFirestore.instance.collection('work');

  void addToDb() {
    final data = {
      'servicename': "WaterTank ${widget.service!.name}",
      'price': widget.service!.price.toString(),
      'time': timeController.text,
      'date': dateController.text,
      'placeandcity': _currentAddress,
      'locationvalue': _currentLocation.toString(),
      'address': addressController.text,
    };
    work.add(data);
  }

  Position? _currentLocation;
  late bool servicePermission = false;
  late LocationPermission permission;

  String _currentAddress = '';

  Future<Position> _getCurrentLocation() async {
    servicePermission = await Geolocator.isLocationServiceEnabled();
    if (!servicePermission) {
      print('service disabled');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    return await Geolocator.getCurrentPosition();
  }

  _getAddressFromCoordinates() async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
          _currentLocation!.latitude, _currentLocation!.longitude);
      Placemark place = placemarks[0];
      setState(() {
        _currentAddress = "${place.locality},${place.country}";
      });
    } catch (e) {
      print(e);
    }
  }

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

  final DateTime _selectedDate = DateTime.now();

  @override
  Widget build(
    BuildContext context,
  ) {
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
                onTap: () async {
                  _currentLocation = await _getCurrentLocation();
                  await _getAddressFromCoordinates();
                  print("${_currentLocation}");
                  print("${_currentAddress}");
                },
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
                _currentAddress,
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
                "Latitude =${_currentLocation?.latitude}; Longitude=${_currentLocation?.longitude}",
                style: greySmalltext,
              ),
              const SizedBox(
                height: 20,
              ),
              payButton(),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const SizedBox(),
                  SizedBox(
                      width: 150,
                      height: 50,
                      child: MyButton(
                          color: Colors.black87,
                          txt: 'Book Now',
                          ontap: () {
                            bottomBar(context);
                          })),
                  const SizedBox(
                    width: 15,
                  )
                ],
              ),
            ],
          ),
        ),
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
      height: 80,
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: Container(
                    height: 40,
                    width: 120,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.inversePrimary,
                      boxShadow: const [
                        BoxShadow(
                            color: Colors.white,
                            offset: Offset(2, 2),
                            blurRadius: 2)
                      ],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text('Pay Now', style: buttonStyle),
                  ),
                ),
              ),
            ]),
            Text("WaterTank ${widget.service!.name}", style: blacksmalltext),
          ],
        ),
      ),
    );
  }

  void bottomBar(BuildContext context) {
    showModalBottomSheet(
        backgroundColor: Colors.grey.shade200,
        context: context,
        builder: (builder) {
          return Padding(
            padding: const EdgeInsets.all(20),
            child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 3.0,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Text('Please Confirm Your Booking', style: greySmalltext),
                    Lottie.asset('assets/json/hand.json',
                        height: 100, width: 100),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: MyButton(
                              txt: 'Cancel',
                              color: Colors.black87,
                              ontap: () {
                                Navigator.pop(context);
                              }),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: Obx(
                            () => InkWell(
                              onTap: controller.loading.value
                                  ? null
                                  : () async {
                                      controller.loading.value = true;
                                      await Future.delayed(
                                          const Duration(seconds: 2));
                                      controller.loading.value = false;
                                      if (dateController.text.isNotEmpty) {
                                        addToDb();
                                        Get.to(OrderConfirmedPage(
                                            service: Service(
                                          name: widget.service!.name,
                                          imagePath: widget.service!.imagePath,
                                          price: widget.service!.price,
                                        )));
                                      } else {
                                        incompleateData();
                                      }
                                    },
                              child: Container(
                                  decoration: BoxDecoration(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .inversePrimary,
                                      borderRadius: BorderRadius.circular(15)),
                                  height: 50,
                                  width: 250,
                                  child: Center(
                                      child: controller.loading.value
                                          ? const CircularProgressIndicator(
                                              color: Colors.white,
                                            )
                                          : Text('Confirm',
                                              style: buttonStyle))),
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                )),
          );
        });
  }

  void incompleateData() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            icon: const Icon(Icons.dangerous_rounded),
            iconColor: Colors.red,
            title: Text(
              'Please fill up your full details',
              style: greySmalltext,
            ),
          );
        });
  }
}
