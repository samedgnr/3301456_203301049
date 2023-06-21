import 'package:chatapp/helper/helper_function.dart';
import 'package:chatapp/pages/settings%20page/settings_list.dart';
import 'package:chatapp/services/auth_service.dart';
import 'package:chatapp/shared/local_parameters.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../profile page/profile_page.dart';

class SettingsListView extends StatefulWidget {
  const SettingsListView({super.key});

  @override
  State<SettingsListView> createState() => _SettingsListViewState();
}

class _SettingsListViewState extends State<SettingsListView> {
  final user = FirebaseAuth.instance.currentUser!;
  String userName = "";
  String email = "";
  String number = "";
  String durum = "";
  AuthService authService = AuthService();

  @override
  void initState() {
    super.initState();
    gettingUserData();
  }

  gettingUserData() async {
    await HelperFunctions.getUserEmailFromSF().then((value) {
      setState(() {
        email = value!;
      });
    });
    await HelperFunctions.getUserNameFromSF().then((val) {
      setState(() {
        userName = val!;
      });
    });
    await HelperFunctions.getUserDurumFromSF().then((val) {
      setState(() {
        durum = val!;
      });
    });
    await HelperFunctions.getUserNumberFromSF().then((val) {
      setState(() {
        number = val!;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //Profil bolumu
        GestureDetector(
          child: Padding(
            padding: const EdgeInsets.only(top: 15.0),
            child: SizedBox(
              height: 180,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(10.0),
                        child: CircleAvatar(
                          radius: 50,
                          backgroundImage: AssetImage("lib/images/Kedy.jpg"),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        userName,
                        style: const TextStyle(fontSize: 25),
                      ),
                      Text(durum, style: const TextStyle(fontSize: 12)),
                    ],
                  ),
                ],
              ),
            ),
          ),
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return const ProfilePage();
            }));
          },
        ),
        //secenekler bolumu
        const Padding(
          padding: EdgeInsets.only(top: 15.0),
          child: SizedBox(
            height: 320,
            child: SettingsList(),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Text(
          upToDateStatus(),
          textAlign: TextAlign.center,
        )
      ],
    );
  }
}

upToDateStatus() {
  int databesedengelen = 1;
  if (Parameters().version == databesedengelen) {
    String update = "No updates available!";
    return update;
  } else {
    String update = "Update is available!\nPlease contact with developers.";
    return update;
  }
}
