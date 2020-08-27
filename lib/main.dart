import 'package:flutter/material.dart';
import 'home_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:jci_meet/Views/First_pages.dart';
import 'package:jci_meet/Services/auth_service.dart';
import 'package:jci_meet/widgets/provider_widget.dart';
import 'package:jci_meet/Views/Sign_up_View.dart';
import 'package:jci_meet/Profile/profile_view.dart';
import 'package:jci_meet/Profile/locator.dart';
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupServices();
  runApp(MyApp());


}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider(
      auth: AuthService(),
      db: Firestore.instance,

      child: MaterialApp(
        title: "JCI Meet",
        theme: ThemeData(
          primaryColor: Colors.blue,
          primarySwatch: Colors.blue,

          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: HomeController(),
        routes: <String, WidgetBuilder>{
          '/signUp': (BuildContext context) => SignUpView(authFormType: AuthFormType.signUp),
          '/signIn': (BuildContext context) => SignUpView(authFormType: AuthFormType.signIn),
          '/PofileView': (BuildContext context) =>  ProfileView(),
          '/home': (BuildContext context) => HomeController(),

        },

      ),
    );
  }
}


class HomeController extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final AuthService auth = Provider.of(context).auth;
    return StreamBuilder<String>(
      stream: auth.onAuthStateChanged,
      builder: (context, AsyncSnapshot<String> snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final bool signedIn = snapshot.hasData;
          return signedIn ? Home() : FirstView();
        }
        return CircularProgressIndicator();
      },
    );
  }
}



