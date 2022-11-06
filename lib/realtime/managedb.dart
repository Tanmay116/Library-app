import 'package:firebase_database/firebase_database.dart';

void createDB(DatabaseReference _dbref) {
  Map<String, dynamic> data = {
    'books': [
      'Harry Potter 1',
      'Kumbhojkar',
      'Wimpy Kid',
    ],
    'fav': [
      'Wimpy Kid',
    ],
  };
  _dbref.set(data);
}

Future<List> retrieveBooks(DatabaseReference _dbref) async {
  DatabaseEvent event = await _dbref.once();
  Map data = event.snapshot.value as Map;
  return (data['books']);
}

Future<List> retrieveFav(DatabaseReference _dbref) async {
  DatabaseEvent event = await _dbref.once();
  Map data = event.snapshot.value as Map;
  return (data['fav']);
}

void addData(DatabaseReference _dbref, String newBook, bool isFav) async {
  DatabaseEvent event = await _dbref.once();
  Map data = event.snapshot.value as Map;
  if (isFav) {
    List fav = data['fav'];
    fav = fav.toList();
    fav.add(newBook);
    await _dbref.update({
      'fav': fav,
    });
  } else {
    List books = data['books'];
    books = books.toList();
    books.add(newBook);
    await _dbref.update({
      'books': books,
    });
  }
}

void delData(DatabaseReference _dbref, String oldBook, bool isFav) async {
  DatabaseEvent event = await _dbref.once();
  Map data = event.snapshot.value as Map;
  if (isFav) {
    List fav = data['fav'];
    fav = fav.toList();
    fav.remove(oldBook);
    await _dbref.update({
      'fav': fav,
    });
  } else {
    List books = data['books'];
    books = books.toList();
    books.remove(oldBook);
    await _dbref.update({
      'books': books,
    });
  }
}

void delNode(DatabaseReference _dbref) async {
  await _dbref.remove();
}
