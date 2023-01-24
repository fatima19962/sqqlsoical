import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sqqlsoical/screens/FeedScreen/FeedPost.dart';
import 'package:sqqlsoical/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../HomeScreen/homescreen.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({Key? key}) : super(key: key);

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor:
          width > webScreenSize ? webBackgroundColor : mobileBackgroundColor,
      appBar: width > webScreenSize
          ? null
          : AppBar(
              backgroundColor: mobileBackgroundColor,
              centerTitle: false,
              title: Text(
                'eql.social',
                style: TextStyle(fontSize: 22.0),
              ),
              actions: [
                IconButton(
                  icon: const Icon(
                    Icons.messenger_outline,
                    color: primaryColor,
                  ),
                  onPressed: () {},
                ),
              ],
            ),
      // body: FutureBuilder(
      //     future: FirebaseFirestore.instance.collection('posts').get(),
      //     // builder: (context,
      //     // AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
      //     builder: (BuildContext context, AsyncSnapshot snapshot) {
      //       if (snapshot.connectionState == ConnectionState.none) {
      //         return Column(
      //           mainAxisAlignment: MainAxisAlignment.center,
      //           crossAxisAlignment: CrossAxisAlignment.center,
      //           children: [
      //             Container(
      //               height: MediaQuery.of(context).size.height * 0.5,
      //               width: MediaQuery.of(context).size.width * 0.5,
      //               child: Center(
      //                   child:
      //                       Lottie.asset('lib/assets/animations/error.json')),
      //             ),
      //           ],
      //         );
      //       }
      //       if (snapshot.connectionState == ConnectionState.waiting) {
      //         return Column(
      //           mainAxisAlignment: MainAxisAlignment.center,
      //           crossAxisAlignment: CrossAxisAlignment.center,
      //           children: [
      //             Container(
      //               height: MediaQuery.of(context).size.height * 0.5,
      //               width: MediaQuery.of(context).size.width * 0.5,
      //               child: Center(
      //                   child: Lottie.asset(
      //                       'lib/assets/animations/loading.json')),
      //             ),
      //           ],
      //         );
      //       } else if (snapshot.connectionState == ConnectionState.done) {
      //         if (snapshot.hasError) {
      //           return Column(
      //             mainAxisAlignment: MainAxisAlignment.center,
      //             crossAxisAlignment: CrossAxisAlignment.center,
      //             children: [
      //               Container(
      //                 height: MediaQuery.of(context).size.height * 0.5,
      //                 width: MediaQuery.of(context).size.width * 0.5,
      //                 child: Center(
      //                     child: Lottie.asset(
      //                         'lib/assets/animations/error.json')),
      //               ),
      //             ],
      //           );
      //         } else if (snapshot.hasData) {
      //           return ListView.builder(
      //               itemCount: snapshot.data!.docs.length,
      //               itemBuilder: (BuildContext context, index) {
      //                 return Container(
      //                     decoration: BoxDecoration(
      //                       borderRadius: BorderRadius.circular(20.0),
      //                     ),
      //                     margin: EdgeInsets.symmetric(
      //                       horizontal:
      //                           width > webScreenSize ? width * 0.3 : 0,
      //                       vertical: width > webScreenSize ? 15 : 0,
      //                     ),
      //                     child: PostCard(
      //                       snap: snapshot.data!.docs[index]!.data()!,
      //                     ));
      //               });
      //         }
      //         return ListView.builder(
      //           itemCount: snapshot.data!.docs.length,
      //           itemBuilder: (ctx, index) => Container(
      //             margin: EdgeInsets.symmetric(
      //               horizontal: width > webScreenSize ? width * 0.3 : 0,
      //               vertical: width > webScreenSize ? 15 : 0,
      //             ),
      //             child: PostCard(
      //               snap: snapshot.data!.docs[index]!.data()!,
      //             ),
      //           ),
      //         );
      //       }
      //       return ListView.builder(
      //         itemCount: snapshot.data!.docs.length,
      //         itemBuilder: (ctx, index) => Container(
      //           margin: EdgeInsets.symmetric(
      //             horizontal: width > webScreenSize ? width * 0.3 : 0,
      //             vertical: width > webScreenSize ? 15 : 0,
      //           ),
      //           child: PostCard(
      //             snap: snapshot.data!.docs[index]!.data()!,
      //           ),
      //         ),
      //       );
      //     })
      body: FutureBuilder(
          future: FirebaseFirestore.instance.collection('posts').get(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting)
              return Center(child: CircularProgressIndicator());
            else if (snapshot.hasData)
              return Text("DATA: ${snapshot.data}");
            else if (snapshot.hasError)
              return Text("ERROR: ${snapshot.error}");
            else
              return Text('None');
          }),
    );
  }
}
