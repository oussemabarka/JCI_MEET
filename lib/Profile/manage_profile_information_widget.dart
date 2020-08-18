import 'package:jci_meet/Profile/locator.dart';
import 'package:jci_meet/models/user_model.dart';
import 'package:jci_meet/Profile/user_controller.dart';
import 'package:flutter/material.dart';

class ManageProfileInformationWidget extends StatefulWidget {
  final UserModel currentUser;

  ManageProfileInformationWidget({this.currentUser});

  @override
  _ManageProfileInformationWidgetState createState() =>
      _ManageProfileInformationWidgetState();
}

class _ManageProfileInformationWidgetState
    extends State<ManageProfileInformationWidget> {
  var _displayNameController = TextEditingController();
  var _passwordController = TextEditingController();
  var _newPasswordController = TextEditingController();
  var _repeatPasswordController = TextEditingController();

  var _formKey = GlobalKey<FormState>();

  bool checkCurrentPasswordValid = true;

  @override
  void initState() {
    _displayNameController.text = widget.currentUser.displayName;
    super.initState();
  }

  @override
  void dispose() {
    _displayNameController.dispose();
    _passwordController.dispose();
    _newPasswordController.dispose();
    _repeatPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20.0), //all widgets scroll
        child: Column(
          mainAxisSize: MainAxisSize.min, //minimiser l'espace scrollbal widgets
          children: <Widget>[
            TextFormField(
              style: TextStyle(fontSize: 15.0),
              decoration: buildSignUpInputDecoration ( "Username"),
              controller: _displayNameController,
            ),
            SizedBox(height: 20.0),
            Flexible( //minimiser l'espace pour le barre jaune au lien expanded
                child: Form(
                  key: _formKey,
              child: Column(
                children: <Widget>[
                  Text(
                    "Manage Password",
                    style: TextStyle(fontSize: 15, color: Colors.white),
                  ),
                //  TextFormField(
                   // decoration: InputDecoration(
                   //   hintText: "Password",
                   //   errorText: checkCurrentPasswordValid
                    //      ? null
                      //    : "Please double check your current password",
                 //   ),
                  //  controller: _passwordController,
                  //),
                  TextFormField(
                    style: TextStyle(fontSize: 15.0),
                    decoration: buildSignUpInputDecoration ( "New Password"),
                    controller: _newPasswordController,
                    obscureText: true,
                  ),
                  TextFormField(
                    style: TextStyle(fontSize: 15.0),
                    decoration: buildSignUpInputDecoration ( "Repeat Password"),
                    controller: _repeatPasswordController,
                    obscureText: true,
                    validator: (value) {
                      return _newPasswordController.text == value
                          ? null
                          : "Please validate your entered password";
                    },
                  )
                ],
              ),
            )
            ),
            RaisedButton(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0)),
              onPressed: ()async  {
                var userController = locator.get<UserController>();

                if (widget.currentUser.displayName !=
                    _displayNameController.text) {
                  var displayName = _displayNameController.text;
                  userController
                      .updateDisplayName(displayName);
                }
                checkCurrentPasswordValid =
                    await userController.validateCurrentPassword(
                    _passwordController.text);

                setState(() {});
                if (_formKey.currentState.validate() ) {
                  userController.updateUserPassword(
                      _newPasswordController.text);
                  Navigator.pop(context);
                //&&checkCurrentPasswordValid
                }
              },
              child: Text("Save Profile",
                style: TextStyle(
                  color: Color(0xFF75A2EA),
                  fontSize: 15,
                  fontWeight: FontWeight.w300,
                ),),
            )
          ],
        ),
      ),
    );
  }
  InputDecoration buildSignUpInputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      filled: true,
      fillColor: Colors.white,
      focusColor: Colors.white,
      enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white, width: 0.0)),
      contentPadding:
      const EdgeInsets.only(left: 14.0, bottom: 10.0, top: 10.0),
    );
  }

}