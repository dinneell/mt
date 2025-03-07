import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pinput/pinput.dart';

import 'order_screen.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController otpController = TextEditingController();
  String verificationId = '';

  Future<void> verifyPhoneNumber() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phoneController.text,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await FirebaseAuth.instance.signInWithCredential(credential);
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => OrderScreen()));
      },
      verificationFailed: (FirebaseAuthException e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.message!)));
      },
      codeSent: (String id, int? resendToken) {
        setState(() {
          verificationId = id;
        });
      },
      codeAutoRetrievalTimeout: (String id) {},
    );
  }

  Future<void> signInWithOTP() async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: verificationId,
      smsCode: otpController.text,
    );
    await FirebaseAuth.instance.signInWithCredential(credential);
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => OrderScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Вход")),
      body: Column(
        children: [
          TextField(
            controller: phoneController,
            decoration: InputDecoration(labelText: "Введите номер телефона"),
            keyboardType: TextInputType.phone,
          ),
          ElevatedButton(
            onPressed: verifyPhoneNumber,
            child: Text("Получить код"),
          ),
          Pinput(
            controller: otpController,
            length: 6,
          ),
          ElevatedButton(
            onPressed: signInWithOTP,
            child: Text("Подтвердить"),
          ),
        ],
      ),
    );
  }
}

