import 'package:flutter/material.dart';
import 'package:water_tech/view/tools/MyTextStyle.dart';
import 'package:water_tech/view/tools/my_button.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            Text('Edit Profile', style: subHeadingStyleBlue),
            const Divider(),
            Stack(
              children: [
                const CircleAvatar(
                  backgroundImage: AssetImage('assets/logo/pro.webp'),
                  radius: 60,
                ),
                Positioned(
                  bottom: 10,
                  left: 80,
                  child: IconButton(
                      onPressed: () {}, icon: const Icon(Icons.add_a_photo)),
                )
              ],
            ),
            Text(
              'Set new photo',
              style: blacksmalltext,
            ),
            CustomTextField(
                controller: _nameController,
                labeltxt: ' name',
                icon: Icons.person),
            CustomTextField(
                controller: _emailController,
                labeltxt: 'email',
                icon: Icons.email),
            CustomTextField(
                controller: _addressController,
                labeltxt: 'full address',
                icon: Icons.location_pin),
            const SizedBox(
              height: 10,
            ),
            MyButton(
              txt: 'save',
              ontap: () {},
            ),
            const SizedBox(
              height: 70,
            ),
            const SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }

  void signOutPopup() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Sign out', style: subHeadingStyleBlue),
            content:
                Text('Are you sure want to Sign Out?', style: blacksmalltext),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('NO')),
              TextButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, 'loginScreen');
                  },
                  child: const Text('YES')),
            ],
          );
        });
  }
}

class CustomTextField extends StatelessWidget {
  String labeltxt;

  IconData icon;
  TextEditingController controller;
  IconData? suffxicon;

  CustomTextField(
      {super.key,
      required this.controller,
      required this.labeltxt,
      this.suffxicon,
      required this.icon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextField(
            style: const TextStyle(fontSize: 12),
            cursorColor: Colors.black54,
            controller: controller,
            keyboardType: TextInputType.text,
            enabled: true,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              prefixIcon: Icon(
                icon,
                color: Colors.blueGrey,
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.white,
                  width: 2,
                ),
                borderRadius: const BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.blue,
                  width: 1,
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
              labelText: labeltxt,
              labelStyle: const TextStyle(
                color: Colors.blueGrey,
                fontSize: 10,
              ),
              suffixIcon: Icon(
                suffxicon,
                size: 20,
                color: Colors.black54,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
