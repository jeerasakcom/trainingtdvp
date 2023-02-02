import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:tdvp/models/users_model.dart';

class ConfigProcess {
  Future<UserModel> findUserModel({required String uid}) async {
    var result =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();
    UserModel userModel = UserModel.fromMap(result.data()!);
    return userModel;
  }

  Future<void> sentNotification(
      {required String title,
      required String body,
      required String token}) async {
    String path =
        'https://www.androidthai.in.th/eye/frongNotification.php?isAdd=true&token=$token&title=$title&body=$body';
    await Dio().get(path).then((value) {
      print('Success Sent Noti');
    });
  }

  Future<void> updateToken(
      {required String docIdUser, required String token}) async {
    Map<String, dynamic> map = {};
    map['token'] = token;
    await FirebaseFirestore.instance
        .collection('users')
        .doc(docIdUser)
        .update(map)
        .then((value) {
      print('Success Update Token');
    });
  }
}
