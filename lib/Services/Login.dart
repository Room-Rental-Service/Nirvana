import 'dart:convert';
import 'package:Nirvana/Screens/HomeScreen.dart';
import 'package:Nirvana/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginFunctions{
  String verificationId;
  FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> verifyPhone(String mobileNo, BuildContext context) async {
    final PhoneCodeSent smsOTPSent = (String verId, [int forceCodeResend]) {
      this.verificationId = verId;
    };
    try {
      await _auth.verifyPhoneNumber(
          phoneNumber: mobileNo,
          codeAutoRetrievalTimeout: (String verId) {
            this.verificationId = verId;
          },
          codeSent: smsOTPSent, 
          timeout: const Duration(seconds: 20),
          verificationCompleted: (AuthCredential phoneAuthCredential) async {
            onVerify(context);
          },
          verificationFailed: (AuthException exceptio) {
            print('${exceptio.message}');
          });
    } catch (error) {
      handleError(error, context);
    }
  }

  Future<void> verifyOTP(String status, BuildContext context, String smsOTP, String mobileNo, String mode) async {
      _auth.currentUser().then((user) {
        if (user != null && mode == 'Login'){
          Fluttertoast.showToast(
            msg: "Seems you are new here, please register",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM, 
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.grey[200],
            textColor: primaryColor,
            fontSize: 12.0
        );
        }
        else if (user != null && mode == 'Register') {
          createRecord(mobileNo);
          onVerify(context);
        } else {
          status = signIn(context,smsOTP,mobileNo).toString();
        }
      });
  }

  void createRecord(String mobileNo) async {
    print(mobileNo);
    try {
      final newUser = await _auth.createUserWithEmailAndPassword(
          email: mobileNo, password: "abc123");
          print(newUser);
    } catch (e) {
      print(e);
    }
  }

  signIn(BuildContext context, String smsOTP, String mobileNo) async {
    String status = 'OK!';
    try {
      final AuthCredential credential = PhoneAuthProvider.getCredential(
        verificationId: verificationId,
        smsCode: smsOTP,
      );
      final AuthResult user = await _auth.signInWithCredential(credential);
      final FirebaseUser currentUser = await _auth.currentUser();
      assert(user.user.uid == currentUser.uid);
      createRecord(mobileNo);
    } catch (error) {
      status = handleError(error,context);
    }
    return status;
  }

  handleError(PlatformException error, BuildContext context) {
    print(error);
    String errorMessage;
    switch (error.code) {
      case 'ERROR_INVALID_VERIFICATION_CODE':
        FocusScope.of(context).requestFocus(new FocusNode());
        errorMessage = 'Invalid Code';
        break;
      default:
        errorMessage = error.message;
        break;
    }
    return errorMessage;
  }
  onVerify(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    
    final FirebaseUser currentUser = await _auth.currentUser();
    FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

    var tokenId;
    await _firebaseMessaging.getToken().then((token) {
      print(token);
      tokenId = token;
    });
    var firstName = prefs.getString("firstName");
    var lastName = prefs.getString("lastName");

    final customer = {
      "first_name": firstName,
      "last_name": lastName,
      "mobile": currentUser.phoneNumber,
      'firebase_id': currentUser.uid,
      'fcm_token': tokenId
    };
    
    await prefs.setString("firebase_id", currentUser.uid);
    // final url = (server+"/customer");
    
    // Response response = await post(Uri.encodeFull(url), body: json.encode(customer), headers: {"Content-Type": "application/json"},);
    // print(response.body);
    // bool status = jsonDecode(response.body)["status"];
    bool status = true;
    if (status == true){
      await prefs.setBool('login', true);
      Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
    }
  }
}
