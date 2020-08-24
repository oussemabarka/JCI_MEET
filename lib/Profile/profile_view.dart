import 'package:jci_meet/Profile/locator.dart';
import 'package:jci_meet/models/user_model.dart';
import 'package:jci_meet/Profile/user_controller.dart';
import 'package:jci_meet/profile/avatar.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:jci_meet/Profile/manage_profile_information_widget.dart';
class ProfileView extends StatefulWidget {


  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final primaryColor = const Color(0xFF75A2EA);

  UserModel _currentUser = locator.get<UserController>().currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20.0),
                  bottomRight: Radius.circular(20.0),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Avatar(
                    avatarUrl: _currentUser?.avatarUrl,
                    onTap: () async {
                      File image = await ImagePicker.pickImage(
                          source: ImageSource.gallery);

                      await locator
                          .get<UserController>()
                          .uploadProfilePicture(image);

                      setState(() {});
                    },
                  ),
                  Text(

                      "Hi ${_currentUser?.displayName ?? 'nice to see you here.'}",
                    style: TextStyle(fontSize: 15, color: Colors.white),
                  ),

                ],
              ),
            ),
          ),
          Expanded(
    flex: 2,
    child: ManageProfileInformationWidget(
    currentUser: _currentUser,
              )),
        ],
      ),
    );
  }

}
