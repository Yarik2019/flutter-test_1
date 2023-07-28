import 'dart:convert';
import 'dart:html';
import 'dart:js';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
// import 'package:home_flutter_api/screen/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: SendMg(),
    );
  }
}

class SendMg extends StatefulWidget {
  const SendMg({super.key});

  @override
  State<SendMg> createState() => _SendMg();
}

class _SendMg extends State<SendMg> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("REST API POST"),
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          TextField(
            controller: nameController,
            decoration: InputDecoration(hintText: 'Name'),
          ),
          TextField(
            controller: emailController,
            decoration: InputDecoration(hintText: 'Email'),
          ),
          TextField(
            controller: messageController,
            decoration: InputDecoration(hintText: 'Message'),
            keyboardType: TextInputType.multiline,
            minLines: 5,
            maxLines: 8,
          ),
          SizedBox(height: 20),
          ElevatedButton(
              onPressed: () {
                submitData(nameController, emailController, messageController);
              },
              child: Text('Submit'))
        ],
      ),
    );
  }
}

Future<void> submitData(nameController, emailController, messageController) async {
  final name = nameController.text;
  final email = emailController.text;
  final message = messageController.text;

  final body = {
    "name": name,
    "email": email,
    "message": message,
  };
  final url = 'https://api.byteplex.info/api/test/contact/';
  final uri = Uri.parse(url);
  final response = await http.post(
    uri,
    body: jsonEncode(body),
    headers: {
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );

 // show success or fail message based on status
  if (response.statusCode == 201) {
    nameController.text = '';
    emailController.text = '';
    messageController.text = '';
    print('Send Success');
    // showSuccessMessage('Send Success');
  } else {
    // showErrorMessage('Send Failed');
    print('Send Failed');
    print(response.body);
  }
}

// void showSuccessMessage(String message) {
//   final snackBar = SnackBar(content: Text(message));
//   ScaffoldMessenger.of(context).showSnackBar(snackBar);
// }

// void showErrorMessage(String message) {
//   final snackBar = SnackBar(
//     content: Text(
//       message,
//       style: TextStyle(color: Colors.white),
//     ),
//     backgroundColor: Colors.red,
//   );
//   ScaffoldMessenger.of(context).showSnackBar(snackBar);
// }
