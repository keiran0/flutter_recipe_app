import 'package:flutter/material.dart';
import 'package:recipes_app/services/auth_service.dart';
import 'package:status_alert/status_alert.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage> {

  GlobalKey<FormState> _loginFormKey = GlobalKey();
  String? username, password; //optional string for the state because you may or may not have a username

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Login",
        ), //the titles defined in main.dart is being used here for the title.
        centerTitle: true,
      ),
      body: SafeArea(child: _buildUI()),
    );
  }

  Widget _buildUI() {
    return SizedBox(
      width:
          MediaQuery.sizeOf(
            context,
          ).width, //make the sized box the complete width of the device.
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [_title(), _loginForm()],
      ),
    );
  }

  Widget _title() {
    return const Text(
      "Recipe Book",
      style: TextStyle(fontSize: 35, fontWeight: FontWeight.w300),
    );
  }

  Widget _loginForm() { 
    return SizedBox(
      width: MediaQuery.sizeOf(context).width * 0.9,
      height: MediaQuery.sizeOf(context).height * 0.3,
      child: Form(
        key: _loginFormKey,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormField(
              initialValue: "emilys",
              onSaved: (value) {
                setState(() {
                  username = value;
                });
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "enter a username";
                }
              },
              decoration: InputDecoration(hintText: "Username"),
            ),
            TextFormField(
              initialValue: "emilyspass",
              onSaved: (value) {
                setState(() {
                  password = value;
                });
              },
              decoration: InputDecoration(hintText: "Password"),
              obscureText: true,
              validator: (value) {
                if (value == null || value.length < 5) {
                  return "enter a valid password";
                }
              },
            ),
            _loginButton(),
          ],
        ),
      ),
    );
  }

  Widget _loginButton() {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width * 0.6,
      child: ElevatedButton(
        onPressed: () async {
          //if the validate function returns a null value, then return false
          //otherwise, use the value returned by the validate function.
          if (_loginFormKey.currentState?.validate() ?? false) {
            _loginFormKey.currentState?.save();
            //print("$username - $password");
            bool result = await AuthService().login(username!, password!);
            //! used to indicate that you know that they have a value, not null 
            //you already checkjed for null checking in the validate function and if blocks in validator param.
            print(result);
            if (result) {
              Navigator.pushReplacementNamed(context, "/home"); //remove the current screen and replace it with the home screen.
              //also prevents users from going back to the previous page. 
            } else {
              StatusAlert.show(
                context, 
                duration: const Duration(seconds: 2),
                title: 'Login failed',
                subtitle: 'Please try again.',
                configuration: const IconConfiguration(icon: Icons.error),
                maxWidth: 260
              );
            }
          }
        },
        child: const Text('Login'),
      ),
    );
  }
}
