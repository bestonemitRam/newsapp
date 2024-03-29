import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class AuthController extends GetxController {
  TextEditingController mobileController = TextEditingController();

  var isLoading = false.obs;
  @override
  void onInit() {
    super.onInit();
  }

  Future<void> signUpWithPhoneNumber() async {
    // bool result = await InternetConnectionChecker().hasConnection;

    FirebaseAuth auth = FirebaseAuth.instance;
    try {
      await auth.verifyPhoneNumber(
        phoneNumber: "+91 " + mobileController.text.trim(),
        verificationCompleted: (PhoneAuthCredential credential) async {
          // Auto-retrieval of SMS code completed.
          // Sign the user in (or link) with the auto-retrieved credential.
          isLoading.value = false;
          await auth.signInWithCredential(credential);
        },
        verificationFailed: (FirebaseAuthException e) 
        {
          isLoading.value = false;
          // Handle verification failure.
          Fluttertoast.showToast(msg: e.toString());
          print(e.message);
        },
        codeSent: (String verificationId, int? resendToken) async {
          // Show a dialog to let the user enter the SMS code.
          String smsCode = ''; // Get SMS code from user input
          PhoneAuthCredential credential = PhoneAuthProvider.credential(
            verificationId: verificationId,
            smsCode: smsCode,
          );
          // Sign the user in (or link) with the credential
          await auth.signInWithCredential(credential);
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          // Auto-resolution timed out...
        },
      );
    } catch (e) {
      // Handle other errors
      print(e.toString());
    }
  }

  // Future<void> loginWithMobile() async {
  //   isLoading(true);
  //   try {
  //     bool result = await InternetConnection().hasInternetAccess;
  //     if (result) {
  //       final otpModel = await LoginApiServices()
  //           .loginWithMobile(emailController.value.text);
  //       print(otpModel.status);
  //       if (otpModel.status == 'success') {
  //         Get.offAllNamed(ApplicationPages.verificationScreen,
  //             // arguments: {'user_id':'123','otp':'1234','mobile':countryCode + mobileController.value.text});
  //             arguments: {
  //               'user_id': otpModel.userId,
  //               'otp': otpModel.otp,
  //               'mobile': countryCode + mobileController.value.text,
  //               'email': emailController.value.text
  //             });
  //       }
  //     } else {
  //       Fluttertoast.showToast(msg: 'No internet connection!');
  //     }
  //   } catch (e) {
  //     isLoading(false);
  //   } finally {
  //     isLoading(false);
  //   }
  // }

  bool validation() {
    if (mobileController.text.isEmpty) {
      Fluttertoast.showToast(msg: 'Enter Phone Number');
      return false;
    }
    return true;
  }
}
