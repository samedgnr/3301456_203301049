import 'package:chatapp/services/file_utils.dart';
import 'package:chatapp/shared/local_parameters.dart';
import 'package:flutter/material.dart';

class StarredMessagePage extends StatefulWidget {
  const StarredMessagePage({super.key});

  @override
  State<StarredMessagePage> createState() => _StarredMessagePage();
}

class _StarredMessagePage extends State<StarredMessagePage> {
  String starredMessage = "No Starred Message";

  @override
  void initState() {
    super.initState();
    getStarredMessage();
  }

  getStarredMessage() async {
    await FileUtils.readFromFile().then((value) {
      setState(() {
        starredMessage = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Starred Message",
          ),
          centerTitle: false,
          backgroundColor: Parameters().appbar_BColor,
        ),
        body: Column(
          children: [
            SizedBox(
              height: 250,
              child: Text(starredMessage),
            )
          ],
        ));
  }
}
