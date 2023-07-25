import 'package:flutter/material.dart';

Widget actionButton(String title, {Function()? onTap}) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: ElevatedButton(
        onPressed: () {
         if (onTap != null) {
           onTap();
         }
        },
        child: Text(
          title,
          style: const TextStyle(color: Colors.black87, fontSize: 30, fontWeight: FontWeight.bold),
        ),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Colors.grey.shade200),
          minimumSize: MaterialStateProperty.all(const Size(250, 50)),
        ),
                  
                   ),
    );
  }