// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_database/firebase_database.dart';
// import 'package:flutter/material.dart';
// import 'package:library_task/realtime/managedb.dart';
// import 'package:library_task/screens/home1.dart';

// class BookmarkPage extends StatefulWidget {
//   const BookmarkPage({super.key});

//   @override
//   State<BookmarkPage> createState() => BookmarkPageState();
// }

// class BookmarkPageState extends State<BookmarkPage> {
//   late DatabaseReference _dbref;
//   String uid = (FirebaseAuth.instance.currentUser?.uid).toString();
//   var bookslist = '';
//   var favlist = '';
//   bool fav1 = true;

//   @override
//   void initState() {
//     super.initState();
//     _dbref = FirebaseDatabase(
//             databaseURL:
//                 "https://library-task-default-rtdb.asia-southeast1.firebasedatabase.app/")
//         .ref();
//   }

//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Center(
//           child: fav1
//               ? Card(
//                   color: Colors.red,
//                   child: Container(
//                     child: Text('$fav1'),
//                   ),
//                 )
//               : buildPage(),
//         ),
//         ElevatedButton(
//           onPressed: () async {
//             List fav = await retrieveFav(_dbref.child('Users/$uid'));
//             var stringList = fav.join(", ");
//             setState(() => favlist = stringList);
//           },
//           child: Text(
//             'Show favs',
//           ),
//           style: ElevatedButton.styleFrom(primary: Colors.brown),
//         ),
//       ],
//     );
//   }
// }
