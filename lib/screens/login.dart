import 'package:flutter/material.dart';
import 'package:shop_udeny/api/controller/users_controller.dart';
import 'package:shop_udeny/models/api_response.dart';


import '../utils/helpers.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with Helpers{
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  String? _emailError;
  String? _passwordError;
  bool _showPassword = false;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Login',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500,color: Colors.black),
              ),
              Text(
                'Login now to browse our hot offers',
                style: TextStyle(
                    fontSize: 16, fontWeight: FontWeight.w500, color: Colors.grey),
              ),
              SizedBox(
                height: 30,
              ),
              TextField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                    errorText: _emailError,
                    label: Text('Email Address'),
                    prefixIcon: Icon(Icons.email_outlined),

                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.blue)),
                    errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.red))),
              ),
              SizedBox(
                height: 15,
              ),
              TextField(
                controller: passwordController,
                keyboardType: TextInputType.text,
                obscureText: !_showPassword,
                decoration: InputDecoration(
                    errorText: _passwordError,
                    label: Text('Password'),
                    prefixIcon: Icon(Icons.lock_outline),
                    suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _showPassword = !_showPassword;
                          });
                        },
                        icon: Icon(_showPassword
                            ? Icons.visibility_off
                            : Icons.visibility)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.blue)),
                    errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.red))),
              ),
              SizedBox(
                height: 15,
              ),
              ElevatedButton(
                  onPressed: () =>performLogin(),
                  child: Text(
                    'Login',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  )),
              SizedBox(
                height: 15,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Don\'t have an account'),
                  TextButton(onPressed: ()=>Navigator.pushReplacementNamed(context, '/rigesterScreen')
                      , child:Text('Rigester') )

                ],
              )
            ],
          ),
        ),
      ),
    );
  }
  void performLogin() {
    if (checkData()) {
      login();
    }
  }

  bool checkData() {
    if (emailController.text.isNotEmpty && passwordController.text.isNotEmpty) {
      updateErrorsState();
      return true;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Logged in successfully'),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.blue.shade300,
        duration: const Duration(seconds: 3),
        dismissDirection: DismissDirection.horizontal,
      ),
    );

    updateErrorsState();
    return false;
  }

  void updateErrorsState() {
    setState(() {
      _emailError = emailController.text.isEmpty ? 'Enter email address' : null;
      _passwordError =
          passwordController.text.isEmpty ? 'Enter password' : null;
    });
  }
  void login()async{
ApiResponse apiResponse=await UsersController().
login(email: emailController.text, password: passwordController.text);
showSnackBar(context,
    message: apiResponse.message, error: apiResponse.status);
if(apiResponse.status){
  Navigator.pushReplacementNamed(context, '/bnScreen');
}

  }
}
