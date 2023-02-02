import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tdvp/models/users_model.dart';


class FindUser {
  final String uid;
  FindUser({
    required this.uid,
  });

  Future<UserModel> findUserModel() async {
    var result =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();
    UserModel userModel = UserModel.fromMap(result.data()!);
    return userModel;
  }
}