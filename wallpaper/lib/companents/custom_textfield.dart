import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final IconData icon;
  final String hintText;
  
  final TextEditingController controller;
  final bool isPasswordType;
  const CustomTextField({
    Key? key,
    required this.icon,
    required this.hintText,
    required this.controller, required this.isPasswordType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        width: 250,
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(20),
        ),
        child: TextField(
         controller: controller,
          keyboardType: isPasswordType ? TextInputType.visiblePassword: TextInputType.emailAddress, 
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: hintText,
            prefixIcon: Icon(icon),
          ),
        ),
      ),
    );
  }
}
