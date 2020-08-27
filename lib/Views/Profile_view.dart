import 'package:flutter/material.dart';
import 'package:jci_meet/widgets/provider_widget.dart';
import 'package:intl/intl.dart';
import 'package:jci_meet/models/user.dart';
import 'package:jci_meet/Services/auth_service.dart';
class PofileView1 extends StatefulWidget {
  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<PofileView1> {
  User user = User(" "," ");

  TextEditingController _userCountryController = TextEditingController();
  TextEditingController _userCountryController1 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: <Widget>[
            FutureBuilder(
              future: Provider.of(context).auth.getCurrentUser(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return displayUserInformation(context, snapshot);
                } else {
                  return CircularProgressIndicator();
                }
              },
            )
          ],
        ),
      ),
    );
  }

  Widget displayUserInformation(context, snapshot) {
    final authData = snapshot.data;

    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundImage: NetworkImage(
              authData.photoUrl,
            ),
            radius: 40,
            backgroundColor: Colors.transparent,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Name: ${authData.displayName }",
            style: TextStyle(fontSize: 20),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Email: ${authData.email }",
            style: TextStyle(fontSize: 20),
          ),
        ),

        FutureBuilder(
            future: _getProfileData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                _userCountryController.text = user.Categorie;
                _userCountryController1.text = user.phoneNumber;

              }
              return Container(
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "CATEGORIE: ${_userCountryController.text}",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "phoneNumber: ${_userCountryController1.text}",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ],
                ),
              );
            }
        ),
        showSignOut(context, authData.isAnonymous),
        RaisedButton(
          child: Text("Edit User"),
          onPressed: () {
            _userEditBottomSheet(context);
          },
        )
      ],
    );
  }

  _getProfileData() async {
    final uid = await Provider.of(context).auth.getCurrentUID();
    await Provider.of(context)
        .db
        .collection('cat')
        .document(uid)
        .get().then((result) {
      user.Categorie = result.data['categorie'];
      user.phoneNumber = result.data['phoneNumber'];

    });
  }

  Widget showSignOut(context, bool isAnonymous) {
    if (isAnonymous == true) {
      return RaisedButton(
        child: Text("Sign In To Save Your Data"),
        onPressed: () {
          Navigator.of(context).pushNamed('/convertUser');
        },
      );
    } else {
      return RaisedButton(
        child: Text("Sign Out"),
        onPressed: () async {
          try {
            await Provider.of(context).auth.signOut();
          } catch (e) {
            print(e);
          }
        },
      );
    }
  }



  void _userEditBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return Container(
          height: MediaQuery.of(context).size.height * .60,
          child: Padding(
            padding: const EdgeInsets.only(left: 15.0, top: 15.0),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text("Update Profile"),
                    Spacer(),
                    IconButton(
                      icon: Icon(Icons.cancel),
                      color: Colors.orange,
                      iconSize: 25,
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 15.0),
                        child: TextField(
                          controller: _userCountryController,
                          decoration: InputDecoration(
                            helperText: "Categorie",
                              icon: Icon(Icons.category)

                          ),

                        ),


                      ),

                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 15.0),

                        child: TextFormField(
                          controller: _userCountryController1,
                          keyboardType: TextInputType.number,
                          autocorrect: true,
                          validator: (String value) {
                            if (value.isEmpty) {
                              return 'Phone number (xx-xxx-xxx)';
                            }if (value.length != 8) {
                              return "PhoneNumber must be 8 numbers long";
                            }{

                            }
                            return null;
                          },

                          decoration: InputDecoration(
                            helperText: "phone",
                              icon: Icon(Icons.phone_iphone)

                          ),
                        ),


                      ),

                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    RaisedButton(
                      child: Text('Save'),
                      color: Colors.green,
                      textColor: Colors.white,
                      onPressed: () async {
                        user.Categorie = _userCountryController.text;
                        user.phoneNumber = _userCountryController1.text;

                        setState(() {
                          _userCountryController.text = user.Categorie;
                          _userCountryController1.text = user.phoneNumber;

                        });
                        final uid =
                        await Provider.of(context).auth.getCurrentUID();
                        await Provider.of(context)
                            .db
                            .collection('cat')
                            .document(uid)
                            .setData(user.toJson());
                        Navigator.of(context).pop();
                      },
                    )
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}