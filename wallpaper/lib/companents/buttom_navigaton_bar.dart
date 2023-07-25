import 'package:flutter/material.dart';
import 'package:wallpaper/screens/home_page.dart';
import 'package:wallpaper/screens/login_page.dart';
class MyBottomNavigationBar extends StatefulWidget {
  const MyBottomNavigationBar({super.key});


  @override
  State<MyBottomNavigationBar> createState() => _MyBottomNavigationBarState();
}

class _MyBottomNavigationBarState extends State<MyBottomNavigationBar> {
  int _currentindex = 0 ;

 

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(colors: Colors.accents)
        ),
        child: BottomNavigationBar(
          unselectedItemColor: Colors.black87,
          selectedItemColor: Colors.black87,
          onTap: (int newIndex ) {
            setState(() {
              _currentindex = newIndex;
            });
            
            switch (newIndex) {
      case 0:
        Navigator.push(context, MaterialPageRoute(builder: (context) => const HomePage()));
        break;
      case 1:
        Navigator.push(context, MaterialPageRoute(builder: (context) => const HomePage()));
        break;
      case 2:
        Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginPage()));
        break;
        
    }
  },   
          backgroundColor: Colors.white,
          unselectedLabelStyle: const TextStyle(fontSize: 15,),
          selectedLabelStyle: const TextStyle(fontSize: 15),
          items: const [
            BottomNavigationBarItem(
              
              icon: Icon(Icons.home),
              label: 'Home',
              
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: 'Favorites',
            ),           
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Login',
              
            ),
              
            
          ],
        ),
      );
    
  }
}
