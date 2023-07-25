import 'package:flutter/material.dart';
import 'package:wallpaper/companents/custom_button.dart';
import 'package:wallpaper/firebase/auth_service.dart';
import 'package:wallpaper/firebase/locator.dart';
import '../companents/custom_textfield.dart';
import 'home_page.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage>   {
 final _tName = TextEditingController();
 final _tEmail = TextEditingController();
 final _tPassword = TextEditingController();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Colors.blue,
                Colors.red,
              ],
            ),
        ),
        child: Stack(
          children: [
            
            SafeArea(
              child: Padding(
                      padding: const EdgeInsets.only(top:30 , right:40 ),
                      child: Text( " Hesap\n Olustur", style: TextStyle(fontSize: 70,fontWeight: FontWeight.bold,color: Colors.white),),
                    ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 70),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    
                    Stack(
                      children: [
                        
                        CircleAvatar(
                          radius: 60,
                          backgroundImage: AssetImage("assets/images/person.jpg"),
                        ),
                        Positioned(
                          bottom: 1,
                          right: 1,
                          child: CircleAvatar(
                            radius: 15,
                            backgroundColor: Colors.white,
                            child: Icon(
                              Icons.add_a_photo,
                              size: 15,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                    CustomTextField(isPasswordType: false,icon: Icons.person, hintText: "Name & Surname", controller: _tName ),
                    CustomTextField(icon: Icons.email, hintText: "E-mail",isPasswordType: false,controller: _tEmail,),
                   // CustomTextField(icon: Icons.phone, hintText: "Phone Number",isPasswordType: false,controller: _emailTextController,),
                    CustomTextField(icon: Icons.lock, hintText: "Password",isPasswordType: true,controller: _tPassword,),
                    
                    actionButton("Sign Up",onTap: () =>locator.get<AuthService>().signUp(context,name: _tName.text, email: _tEmail.text, password: _tPassword.text)),
                   
                  
                  ],
                ),
              ),
            ),
             
          ],
        ),
      ),
    );
  }
}


 

