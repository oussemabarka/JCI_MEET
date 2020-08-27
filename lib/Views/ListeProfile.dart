
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class ListeProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
          title: Text("Liste Profile "),
        ),

        body:


        StreamBuilder(

          stream: Firestore.instance.collection("users").snapshots(),


          builder: (context  , snapshot){
            return ListView.builder(
              itemCount: snapshot.data.documents.length,
              itemBuilder:(context,index){
                DocumentSnapshot cat = snapshot.data.documents[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(
                        cat['photoURL']
                    ),
                    radius: 25,
                    backgroundColor: Colors.transparent,
                  ),


                  title: Text(cat['email']),
                  subtitle: Text(cat['displayName']),
                );
              },
            );



          },
        ));

  }
}

