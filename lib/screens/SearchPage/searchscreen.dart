import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sqqlsoical/screens/FeedScreen/FeedPost.dart';
import 'package:sqqlsoical/screens/HomeScreen/homescreen.dart';
import 'package:sqqlsoical/screens/ProfilePage/profilescreen.dart';
import 'package:sqqlsoical/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:lottie/lottie.dart';


class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController searchController = TextEditingController();
  bool isShowUsers = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        title: Form(
          child: TextFormField(
            controller: searchController,
            style: TextStyle(
                color: Colors.white,
                fontSize: 20
            ),
            decoration:
             InputDecoration(labelText: 'Search',
               labelStyle: TextStyle(
                 color: Colors.white,
                 fontSize: 20,

               ),
              fillColor: Colors.white,
              suffixIcon: Icon(
                Icons.search,
                color: Colors.white,
                size: 25.0,
              ),
              enabledBorder: new OutlineInputBorder(
                borderRadius: new BorderRadius.circular(15.0),
                borderSide:  BorderSide(color: Colors.white ),

              ),

            ),
            onFieldSubmitted: (String _) {

            setState(() {

              isShowUsers = true;
            });
              print(_);
            },
          ),
        ),
      ),
      body: isShowUsers
          ? PageView(
            children:[
              FutureBuilder(
        future: FirebaseFirestore.instance
              .collection('users')
              .where(
            'username',
            isGreaterThanOrEqualTo: searchController.text,
        )
              .get(),
      //  initialData: CircularProgressIndicator(),
        builder: (context, snapshot) {
            if(snapshot.connectionState == ConnectionState.waiting){
              if (!snapshot.hasData) {
                return Center(
                  child: Lottie.asset('lib/assets/animations/loading.json'),
                );
              }
              if(snapshot.hasError){
                return Center(
                  child: Lottie.asset('lib/assets/animations/error.json'),
                );
              }
            }
            if(snapshot.connectionState == ConnectionState.active){
              if(snapshot.hasError){
                return Center(
                  child: Lottie.asset('lib/assets/animations/error.json'),
                );
              }
            }

            if(snapshot.hasError){
              return Center(
                child: Lottie.asset('lib/assets/animations/error.json'),
              );
            }
            if (!snapshot.hasData) {
              return Center(
                child: Lottie.asset('lib/assets/animations/loading.json'),
              );
            }
            return ListView.builder(
              itemCount: (snapshot.data! as dynamic).docs.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ProfileScreen(
                        uid: (snapshot.data! as dynamic).docs[index]['uid'],
                      ),
                    ),
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(
                        (snapshot.data! as dynamic).docs[index]['photoUrl'],
                      ),
                      radius: 16,
                    ),
                    title: Text(
                      (snapshot.data! as dynamic).docs[index]['username'],
                    ),
                  ),
                );
              },
            );
        },
      ),
          ])
          : FutureBuilder(
        future: FirebaseFirestore.instance
            .collection('posts')
            .orderBy('datePublished')
            .get(),
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting){
            return  Center(
              child: Lottie.asset('lib/assets/animations/loading.json'),
            );
          }
          if(snapshot.hasError){
            return Center(
              child: Lottie.asset('lib/assets/animations/error.json'),
            );
          }
          if (!snapshot.hasData) {
            return  Center(
              child: Lottie.asset('lib/assets/animations/loading.json'),
            );
          }

          return StaggeredGridView.countBuilder(
            crossAxisCount: 3,
            itemCount: (snapshot.data! as dynamic).docs.length,
            itemBuilder: (context, index) => InkWell(
              onTap: () {

              }

              ,child: Image.network(
                (snapshot.data! as dynamic).docs[index]['postUrl'],
                fit: BoxFit.cover,
              ),
            ),
            staggeredTileBuilder: (index) => MediaQuery.of(context)
                .size
                .width >
                webScreenSize
                ? StaggeredTile.count(
                (index % 7 == 0) ? 1 : 1, (index % 7 == 0) ? 1 : 1)
                : StaggeredTile.count(
                (index % 7 == 0) ? 2 : 1, (index % 7 == 0) ? 2 : 1),
            mainAxisSpacing: 8.0,
            crossAxisSpacing: 8.0,
          );
        },
      ),
    );
  }
}
