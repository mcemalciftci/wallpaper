import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wallpaper/firebase/auth_service.dart';
import 'package:wallpaper/screens/login_page.dart';
import 'package:wallpaper/service/api_service.dart';

import '../firebase/user_model.dart';

class NavBar extends StatefulWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  
 UserModel? _user;
   AuthService loginuser = AuthService();
  final apiService = UnsplashApiService();
  late Future<List<String>> categoryNamesFuture;

  @override
  void initState() {
    super.initState();
    categoryNamesFuture = apiService.getCategoryNames();
    _loadCurrentUser();
  }
void _loadCurrentUser() async {
    final authService = AuthService();
    final user = await authService.getCurrentUser();
    setState(() {
      _user = user;
    });
  }
  

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.75,
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              onDetailsPressed: () => const LoginPage(),
              accountName: Text(_user!= null ? "${_user!.name}" : "example" , style: text(),),
              accountEmail:  Text(_user!= null ? "${_user!.email}" : "example@gmail.com", style: text(),),
              currentAccountPicture: CircleAvatar(
                radius: 100,
                child: ClipOval(
                  child: Image.asset(
                    "assets/images/person.jpg",
                    width: 120,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Colors.blue,
                Colors.red,
              ],
            ),
        ),
            ),
            const Align(
              alignment: Alignment.center,
              child: Text(
                "Kategoriler",
                style: TextStyle(fontSize: 50),
              ),
            ),
            FutureBuilder<List<String>>(
              future: categoryNamesFuture,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final categoryNames = snapshot.data!;
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: categoryNames.length,
                    itemBuilder: (context, index) {
                      final categoryName = categoryNames[index];
                      return ListTile(
                        onTap: () {},
                        title: Text(
                          categoryName,
                          style: const TextStyle(fontSize: 25),
                        ),
                      );
                    },
                  );
                } else if (snapshot.hasError) {
                  return Text('Hata: ${snapshot.error}');
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
          ],
        ),
      ),
    );


  }


}
 text() {
  return TextStyle(
fontSize: 20,
fontWeight: FontWeight.w800,
fontFamily: AutofillHints.name
  );
}