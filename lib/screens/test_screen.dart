import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TestScreen extends StatelessWidget {
FirebaseFirestore _firebaseFirestore =FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),


      body:Container(
        child:StreamBuilder<QuerySnapshot>(
          stream: _firebaseFirestore.collection("products").snapshots(),
          builder: (context,snapshot){
            if(snapshot.hasData){
              var data = snapshot.data.docs;

              var number = data.length;
              return FutureBuilder<QuerySnapshot>(
                future: _firebaseFirestore.collection("products").doc(data[0]["id"]).collection("products").get(),
                builder: (context,snapshot){
                  if(snapshot.hasData){
                    var data2 = snapshot.data.docs;
                    var number2 = data2.length;
                    return ListView.builder(
                      itemCount: number,
                      itemBuilder: (context,index){
                        return Text(data[index]["name"]);
                      },);
                  }
                  return CircularProgressIndicator();
                },
              );
            }
            return Center(child: CircularProgressIndicator(),);
          },
        ),
      ),
    );
  }
}
