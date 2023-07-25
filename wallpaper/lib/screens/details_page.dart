import 'package:flutter/material.dart';
class DetailPage extends StatelessWidget {
  final String imageUrl;

  const DetailPage({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          Navigator.pop(context); // Büyük resmi tıklandığında sayfayı kapatmak için 
        },
        child: Hero(
          tag: 'image${imageUrl.hashCode}', // Küçük resimdeki etiketle aynı olmalı
          child: Image.network(imageUrl, fit: BoxFit.cover,
            width: double.infinity, // Genişliği tam ekran yapmak için
            height: double.infinity),
        ),
      ),
    );
  }
}