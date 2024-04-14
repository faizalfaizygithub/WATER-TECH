import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:water_tech/model/Service.dart';
import 'package:water_tech/view/tools/MyTextStyle.dart';

class RazorPayPage extends StatefulWidget {
  final Service? service;
  const RazorPayPage({super.key, this.service});

  @override
  State<RazorPayPage> createState() => _RazorPayPageState();
}

class _RazorPayPageState extends State<RazorPayPage> {
  late Razorpay _razorpay;

  TextEditingController amtController = TextEditingController();

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          const SizedBox(
            height: 20,
          ),
          Text('Payment Method', style: subHeadingStyleBlue),
          const SizedBox(
            height: 130,
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextFormField(
              controller: amtController,
              cursorColor: Colors.white,
              autofocus: false,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'Enter amount to be paid',
                labelStyle: subHeadingStyleBlue,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: const BorderSide(color: Colors.white, width: 1),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: const BorderSide(color: Colors.white, width: 1),
                ),
                errorStyle:
                    const TextStyle(color: Colors.redAccent, fontSize: 15),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'please enter amount to be paid';
                }
                return null;
              },
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          ElevatedButton(
            onPressed: () {
              if (amtController.text.toString().isNotEmpty) {
                setState(() {
                  int amount = int.parse(amtController.text.toString());
                  openCheckout(amount);
                });
              }
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                'Make Payment',
                style: subHeadingStyleBlue,
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
