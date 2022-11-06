import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:library_task/screens/signin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:library_task/realtime/managedb.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late DatabaseReference _dbref;
  String uid = (FirebaseAuth.instance.currentUser?.uid).toString();
  var bookslist = '';
  var favlist = '';
  late var fav;
  int length = 0;

  bool TwoTales = true;
  //List books = await retrieveFav(_dbref.child(Users/))

  @override
  void initState() {
    super.initState();
    print('hello');
    _dbref = FirebaseDatabase(
            databaseURL:
                "https://library-task-default-rtdb.asia-southeast1.firebasedatabase.app/")
        .ref();
    datafetch();
  }

  // void datafetch() async {
  //   fav = await retrieveFav(_dbref.child('Users/$uid'));
  //   print(fav);
  //   setState(() {
  //     length = fav.length;
  //   });
  // }

  void datafetch() async {
    fav = await retrieveFav(_dbref.child('Users/$uid'));
    print(fav);
    setState(() {
      length = fav.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    String uid = (FirebaseAuth.instance.currentUser?.uid).toString();
    //List fav = await retrieveFav(_dbref.child('Users/$uid'));
    // List fav = await retrieveFav(_dbref.child('Users/$uid'));
    // int length = fav.length;
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 180, 149, 139),
        appBar: AppBar(
          title: Text('Library App CSI'),
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.search),
            ),
          ],
          leading: Icon(Icons.add_box_outlined),
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                // ignore: prefer_const_literals_to_create_immutables
                colors: [
                  Color.fromARGB(255, 147, 75, 49),
                  Color.fromARGB(255, 139, 91, 74),
                  Color.fromARGB(255, 149, 123, 114)
                ],
                begin: Alignment.bottomRight,
                end: Alignment.topRight,
              ),
            ),
          ),
          bottom: TabBar(
            indicatorColor: Colors.white,
            indicatorWeight: 2,
            // ignore: prefer_const_literals_to_create_immutables
            tabs: [
              Tab(icon: Icon(Icons.home), text: 'Home'),
              Tab(icon: Icon(Icons.bookmark), text: 'Bookmark'),
              Tab(icon: Icon(Icons.settings), text: 'Settings'),
            ],
          ),
          elevation: 10,
        ),
        body: TabBarView(
          children: [
            ListView.builder(
              itemCount: length,
              itemBuilder: (context, index) {
                return Card(
                  color: Colors.brown,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        height: 100,
                        width: 100,
                        child: Image.network(
                            fit: BoxFit.scaleDown,
                            'https://img.freepik.com/premium-photo/opened-book-bible-background_112554-164.jpg?w=360'),
                      ),
                      Text(fav[index] ?? 0),
                      ElevatedButton(
                        child: Text("List Favs"),
                        onPressed: () async {
                          addData(_dbref.child('Users/$uid'), 'test1', true);

                          setState(() {
                            datafetch();
                            var stringList = fav.join(", ");
                            fav = stringList;
                          });
                          print(fav.length);
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
            //BookmarkPage
            ListView.builder(
              itemCount: length,
              itemBuilder: (context, index) {
                return Card(
                  color: Colors.brown,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        height: 100,
                        width: 100,
                        child: Image.network(
                            fit: BoxFit.scaleDown,
                            'https://img.freepik.com/premium-photo/opened-book-bible-background_112554-164.jpg?w=360'),
                      ),
                      Text(fav[index] ?? 0),
                      ElevatedButton(
                        child: Text("List Favs"),
                        onPressed: () async {
                          addData(_dbref.child('Users/$uid'), 'test1', true);
                          List fav =
                              await retrieveFav(_dbref.child('Users/$uid'));
                          var stringList = fav.join(", ");
                          print(fav.length);
                          setState(() => favlist = stringList);
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
            //settings
            Column(
              children: [
                Container(
                  margin: EdgeInsets.all(20),
                  height: 50,
                  width: 100,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(fixedSize: Size.square(20)),
                    child: Text("Logout"),
                    onPressed: () {
                      FirebaseAuth.instance.signOut().then((value) {
                        print("Signed out");
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (builder) => SignInScreen()));
                      });
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
//dnsdbhwehjfgbdshbyegewfgdsigfgsefgdksjfhiefgisdghgbdisgfig