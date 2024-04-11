import 'package:flutter/material.dart';
import 'package:water_tech/view/tools/MyTextStyle.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(top: 60, left: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Settings', style: BlueheadingStyle),
          const SizedBox(
            height: 30,
          ),
          CustomListTile(
            action: () {},
            text: 'Account settings',
            subtxt: 'account informations',
            icon: Icons.settings,
          ),
          CustomListTile(
            action: () {},
            text: 'Cookies',
            subtxt: 'cookies and policy',
            icon: Icons.cookie,
          ),
          CustomListTile(
            action: () {},
            text: 'Privacy',
            subtxt: 'Privacy settings',
            icon: Icons.lock,
          ),
          CustomListTile(
            action: () {},
            text: 'Help Center',
            subtxt: 'Help center',
            icon: Icons.help_center,
          ),
          CustomListTile(
            action: () {},
            text: 'About us',
            subtxt: 'about us informations',
            icon: Icons.group,
          ),
          CustomListTile(
            action: () {},
            text: 'Terms',
            subtxt: 'terms and conditions of Mr clean application ;',
            icon: Icons.rule_rounded,
          ),
          CustomListTile(
            action: () {
              signOutPopup();
            },
            text: 'Sign Out',
            subtxt: 'exit to app',
            icon: Icons.exit_to_app,
          ),
          const SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }

  void signOutPopup() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              'Sign out',
              style: subHeadingStyleBlue,
            ),
            content:
                Text('Are you sure want to Sign Out?', style: greySmalltext),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'NO',
                    style: subHeadingStyleBlue,
                  )),
              TextButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, 'loginScreen');
                  },
                  child: Text(
                    'YES',
                    style: subHeadingStyleBlue,
                  )),
            ],
          );
        });
  }
}

class CustomListTile extends StatelessWidget {
  Function() action;
  String text;
  String? subtxt;
  IconData? icon;

  CustomListTile(
      {super.key,
      required this.action,
      required this.text,
      this.subtxt,
      this.icon});

  @override
  Widget build(BuildContext context) {
    return ListTile(
        onTap: action,
        title: Text(text, style: subHeadingStyleBlue),
        subtitle: Text(
          subtxt!,
          style: greySmalltext,
        ),
        leading: Icon(icon),
        trailing: const Icon(Icons.arrow_forward_ios));
  }
}
