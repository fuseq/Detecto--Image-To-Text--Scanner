
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:scan/widgets/profile/profile_pic.dart';

import '../../pages/settings.dart';
import '../../utils/colors.dart';

class ProfileBody extends StatelessWidget {
  const ProfileBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      ProfilePic(),
      const SizedBox(height: 20),
      Text(
        "John Doe",
        style: Theme.of(context).textTheme.titleLarge,
      ),
      const SizedBox(height: 80),
      ProfileMenu(
        text: 'My Account',
        press: () {},
        icon: FontAwesomeIcons.user,
      ),

      ProfileMenu(
        text: 'Settings',
        press: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SettingsScreen()),
          );
        },
        icon: FontAwesomeIcons.gear,
      ),

      ProfileMenu(
        text: 'Logout',
        press: () {},
        icon: FontAwesomeIcons.rightFromBracket,
      )
    ]);
  }
}

class ProfileMenu extends StatelessWidget {
  const ProfileMenu({
    Key? key,
    required this.text,
    required this.press,
    required this.icon,
  }) : super(key: key);

  final String text;
  final IconData icon;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 25),
        ),
        onPressed: press,
        child: Row(
          children: [
            FaIcon(icon, color: kOrangeColor),
            const SizedBox(width: 20),
            Text(
              text,
              style: TextStyle(color: Colors.grey.shade600),
            ),
            const Spacer(),
            const FaIcon(FontAwesomeIcons.chevronRight, color: Colors.black45),
          ],
        ),
      ),
    );
  }
}
