import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_udeny/api/controller/logout_controller.dart';
import 'package:shop_udeny/api/controller/profile_controller.dart';


class Settingscreen extends StatefulWidget {
  const Settingscreen({Key? key}) : super(key: key);

  @override
  State<Settingscreen> createState() => _SettingscreenState();
}

class _SettingscreenState extends State<Settingscreen> {
  var emailTextController=TextEditingController();
  var nameTextController=TextEditingController();
  var phoneTextController=TextEditingController();
  String? _emailError;
  String? _nameError;
  String? _phoneError;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<ProfileController>(
        global: true,
          builder: ((controller){
        return Column(
          children: [
            SizedBox(
              height: 20,
            ),
            TextField(
              controller: emailTextController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                  errorText: _emailError,
                  hintText: controller.profileModels!.data!.email!,


                  prefixIcon: Icon(Icons.email_outlined),

                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.blue)),
                  errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.red))),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              controller: nameTextController,
              keyboardType: TextInputType.name,
              decoration: InputDecoration(
                hintText: controller.profileModels!.data!.name!,
                  errorText: _nameError,
                  prefixIcon: Icon(Icons.person),

                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.blue)),
                  errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.red))),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              controller: phoneTextController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  errorText: _phoneError,
                  hintText: controller.profileModels!.data!.phone!,
                  prefixIcon: Icon(Icons.phone),

                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.blue)),
                  errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.red))),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () =>perform(),
                child: Text(
                  'Logout',
                  style: TextStyle(fontWeight: FontWeight.w600),
                )),


          ],
        );
      })),
    );
  }

  void perform() {
    if (checkData()) {
      logout();
    }
  }
  bool checkData() {
    if (emailTextController.text.isNotEmpty && nameTextController.text.isNotEmpty&& phoneTextController.text.isNotEmpty) {
      updateErrorsState();
      return true;
    }

    // ScaffoldMessenger.of(context).showSnackBar(
    //   SnackBar(
    //     content: const Text(' successfully'),
    //     behavior: SnackBarBehavior.floating,
    //     backgroundColor: Colors.blue.shade300,
    //     duration: const Duration(seconds: 3),
    //     dismissDirection: DismissDirection.horizontal,
    //   ),
    // );

    updateErrorsState();
    return false;
  }

  void updateErrorsState() {
    setState(() {
      _emailError = emailTextController.text.isEmpty ? 'Enter email address' : null;
      _nameError =
      nameTextController.text.isEmpty ? 'Enter name' : null;
      _phoneError =
      phoneTextController.text.isEmpty ? 'Enter Phone' : null;
    });
  }
  void logout()async{
    await LogoutController().logout(Get.find<ProfileController>().profileModels!.data!.id!);

    Navigator.pushReplacementNamed(context, '/loginScreen');



  }
}
