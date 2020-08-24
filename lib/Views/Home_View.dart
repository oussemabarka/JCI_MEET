import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jci_meet/Views/ListeProfile.dart';
class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:StreamBuilder(
        stream: Firestore.instance.collection("Category").snapshots(),
             builder: (context  , snapshot){
              return ListView.builder(
                itemCount: snapshot.data.documents.length,
                  itemBuilder:(context,index){
                DocumentSnapshot cat = snapshot.data.documents[index];
                    return ListTile(
                    leading:Image.network(cat['image']),
                    title: Text(cat['name']),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ListeProfile(),),
                          );
                        }
                    );
                  },
              );



},
      )
    );
  }
}