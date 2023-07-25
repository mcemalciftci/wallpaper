import 'package:flutter/material.dart';
import 'package:wallpaper/companents/buttom_navigaton_bar.dart';
import 'package:wallpaper/companents/custom_button.dart';
import 'package:wallpaper/firebase/auth_service.dart';
import 'package:wallpaper/firebase/locator.dart';
import 'package:wallpaper/screens/home_page.dart';
import 'package:wallpaper/screens/signup_page.dart';
import '../companents/custom_textfield.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
 final _tEmail = TextEditingController();
 final _tPassword = TextEditingController();
   
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset:false,
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
                      child: Text( " Tekrar\n Hosgeldin", style: TextStyle(fontSize: 60,fontWeight: FontWeight.bold,color: Colors.white),),
                    ),
            ),
           
            Padding(
              padding: const EdgeInsets.only(top:50),
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
                        
                      ],
                    ),
                    CustomTextField(icon: Icons.email, hintText: "E-mail",controller: _tEmail,isPasswordType: false),
                    CustomTextField(icon: Icons.lock, hintText: "Password",controller: _tPassword,isPasswordType: true,),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        "Forgot Password ?",
                        style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w800),
                      ),
                    ),
                    actionButton("Login " ,onTap: () =>locator.get<AuthService>().login(context, email: _tEmail.text, password: _tPassword.text) ),
                   
                  ],
                ),
                
              ),
            ),
             Padding(
               padding: const EdgeInsets.symmetric(vertical: 17),
               child: Align(
                alignment: Alignment.bottomCenter,
                 child: Row(
                   mainAxisAlignment: MainAxisAlignment.center,
                   
                   children: [
                     Text("Don't have an account",style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w800),),
                      TextButton(onPressed: () {
                          Navigator.push(
                        context,
                       MaterialPageRoute(builder: (context) => SignUpPage()),
                     );
                      }, child: const Text("Sign Up", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 30),)),
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


