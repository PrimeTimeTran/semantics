import 'package:firebase_database/firebase_database.dart';
import 'package:semantic/utils/firebase.dart';

updateDailyChallenge() {
  if (FB.auth.currentUser != null) {
    var u = FB.auth.currentUser;
    var id = u?.uid;
    DatabaseReference ref = FB.db.ref('dailies/$id');
    var go = ref.push();
    go.set({'didid': 'dddi'});
  }
}
