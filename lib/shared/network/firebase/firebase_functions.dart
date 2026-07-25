import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo/models/task_model.dart';
import 'package:todo/models/user_model.dart';

class FirebaseFunctions {
  static CollectionReference<TaskModel> getTasksCollection() {
    return FirebaseFirestore.instance
        .collection("Tasks")
        .withConverter<TaskModel>(
          fromFirestore: (snapshot, options) =>
              TaskModel.fromJson(snapshot.data()!),
          toFirestore: (task, options) => task.toJson(),
        );
  }

  static Future<void> addTasksToFireStore(TaskModel task) {
    var collection = getTasksCollection();
    var docRef = collection.doc();
    task.id = docRef.id;
    return docRef.set(task);
  }

  static Stream<QuerySnapshot<TaskModel>> getTasksFromFireStore(DateTime date) {
    var collection = getTasksCollection();
    return collection
        .where(
          "date",
          isEqualTo: DateUtils.dateOnly(date).millisecondsSinceEpoch,
        )
        .snapshots();
  }

  static Future<void> deleteTask(String id) {
    return getTasksCollection().doc(id).delete();
  }

  static Future<void> updateTask(String id, TaskModel task) {
    return getTasksCollection().doc(id).update(task.toJson());
  }

  static Future<UserModel?> createAccount(
    String name,
    int age,
    String email,
    String password,
    Function created,
  ) async {
    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      UserModel userModel = UserModel(
        id: credential.user!.uid,
        name: name,
        age: age,
        email: email,
      );
      addUsersToFireStore(userModel).then((value) {
        created(userModel);
        return userModel;
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print(e.message);
      } else if (e.code == 'email-already-in-use') {
        print(e.message);
      }
    } catch (e) {
      print(e);
    }
    return null;
  }

  static CollectionReference<UserModel> getUsersCollection() {
    return FirebaseFirestore.instance
        .collection("Users")
        .withConverter<UserModel>(
          fromFirestore: (snapshot, options) =>
              UserModel.fromJson(snapshot.data()!),
          toFirestore: (user, options) => user.toJson(),
        );
  }

  static Future<UserModel?> readUser(String id) async {
    DocumentSnapshot<UserModel> userSnapshot = await getUsersCollection()
        .doc(id)
        .get();
    return userSnapshot.data();
  }

  static Future<void> addUsersToFireStore(UserModel user) {
    var collection = getUsersCollection();
    var docRef = collection.doc(user.id);
    return docRef.set(user);
  }

  static Future<UserModel?> login(
    String email,
    String password,
    Function logged,
    Function onError,
  ) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (credential.user != null) {
        print("User Logged In Successfully! UID: ${credential.user!.uid}");
        UserModel? user = await readUser(credential.user!.uid);
        // await SharedPrefs.setLogin("logged");
        logged(user);
        return user;
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-credential' ||
          e.code == 'user-not-found' ||
          e.code == 'wrong-password') {
        onError("Incorrect email or password. Please try again.");
      } else if (e.code == 'invalid-email') {
        onError("The email address is badly formatted.");
      } else if (e.code == 'network-request-failed') {
        onError("Network error. Please check your internet connection.");
      } else {
        onError(e.message ?? "An unknown error occurred.");
      }
    } catch (e) {
      onError("Something went wrong. Please try again later.");
    }
    return null;
  }

  static Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}
