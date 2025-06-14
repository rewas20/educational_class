import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Get current user
  User? get currentUser => _auth.currentUser;

  // Auth state changes stream
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  // Sign in with email and password
  Future<UserCredential> signInWithEmailAndPassword(String email, String password) async {
    try {
      return await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      String message = 'حدث خطأ في تسجيل الدخول';
      switch (e.code) {
        case 'user-not-found':
          message = 'لم يتم العثور على المستخدم';
          break;
        case 'wrong-password':
          message = 'كلمة المرور غير صحيحة';
          break;
        case 'invalid-email':
          message = 'البريد الإلكتروني غير صالح';
          break;
        case 'user-disabled':
          message = 'تم تعطيل هذا المستخدم';
          break;
      }
      Fluttertoast.showToast(
        msg: message,
        backgroundColor: Colors.red,
      );
      throw e;
    } catch (e) {
      Fluttertoast.showToast(
        msg: 'حدث خطأ غير متوقع',
        backgroundColor: Colors.red,
      );
      throw e;
    }
  }

  // Register with email and password
  Future<UserCredential> registerWithEmailAndPassword(String email, String password) async {
    try {
      return await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      String message = 'حدث خطأ في إنشاء الحساب';
      switch (e.code) {
        case 'weak-password':
          message = 'كلمة المرور ضعيفة جداً';
          break;
        case 'email-already-in-use':
          message = 'البريد الإلكتروني مستخدم بالفعل';
          break;
        case 'invalid-email':
          message = 'البريد الإلكتروني غير صالح';
          break;
      }
      Fluttertoast.showToast(
        msg: message,
        backgroundColor: Colors.red,
      );
      throw e;
    } catch (e) {
      Fluttertoast.showToast(
        msg: 'حدث خطأ غير متوقع',
        backgroundColor: Colors.red,
      );
      throw e;
    }
  }

  // Sign out
  Future<void> signOut() async {
    try {
      await _auth.signOut();
      Fluttertoast.showToast(
        msg: 'تم تسجيل الخروج بنجاح',
        backgroundColor: Colors.green,
      );
    } catch (e) {
      Fluttertoast.showToast(
        msg: 'حدث خطأ أثناء تسجيل الخروج',
        backgroundColor: Colors.red,
      );
      throw e;
    }
  }

  // Reset password
  Future<void> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      Fluttertoast.showToast(
        msg: 'تم إرسال رابط إعادة تعيين كلمة المرور',
        backgroundColor: Colors.green,
      );
    } on FirebaseAuthException catch (e) {
      String message = 'حدث خطأ في إعادة تعيين كلمة المرور';
      switch (e.code) {
        case 'user-not-found':
          message = 'لم يتم العثور على المستخدم';
          break;
        case 'invalid-email':
          message = 'البريد الإلكتروني غير صالح';
          break;
      }
      Fluttertoast.showToast(
        msg: message,
        backgroundColor: Colors.red,
      );
      throw e;
    } catch (e) {
      Fluttertoast.showToast(
        msg: 'حدث خطأ غير متوقع',
        backgroundColor: Colors.red,
      );
      throw e;
    }
  }
} 