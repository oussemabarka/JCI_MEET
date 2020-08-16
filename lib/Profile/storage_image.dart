import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:jci_meet/Profile/locator.dart';
import 'package:jci_meet/models/user_model.dart';
import 'package:jci_meet/Profile/auth_repo.dart';

class StorageRepo {
  FirebaseStorage _storage =
  FirebaseStorage(storageBucket: "gs://jcimeet.appspot.com");
  AuthRepo _authRepo = locator.get<AuthRepo>();

  Future<String> uploadFile(File file) async {
    UserModel user = await _authRepo.getUser();
    var userId = user.uid;

    var storageRef = _storage.ref().child("user/profile/$userId");
    var uploadTask = storageRef.putFile(file);
    var completedTask = await uploadTask.onComplete;
    String downloadUrl = await completedTask.ref.getDownloadURL();
    return downloadUrl;
  }

  Future<String> getUserProfileImage(String uid) async {
    return await _storage.ref().child("user/profile/$uid").getDownloadURL();
  }
}