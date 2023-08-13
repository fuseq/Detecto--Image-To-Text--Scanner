import 'package:flutter/material.dart';

import '../widgets/profile/profile_body.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text("Profile",style: TextStyle(color: Colors.black),),
      ),
      body: ProfileBody(),
    );
  }
}