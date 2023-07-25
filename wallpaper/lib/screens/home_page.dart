import 'package:wallpaper/companents/buttom_navigaton_bar.dart';
import 'package:wallpaper/companents/nav_bar.dart';
import 'package:wallpaper/service/api_service.dart';
import 'package:wallpaper/companents/custom_card.dart';
import 'package:flutter/material.dart';
import 'details_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String searchQuery = '';
  List<String> searchResults = [];
  final apiService = UnsplashApiService();
  late Future<List<String>> randomImagesFuture;
  late Future<List<String>> randomSearch;
  String? imageUrl;

  @override
  void initState() {
    super.initState();
    randomImagesFuture = apiService.getRandomImages(15, imageUrl);
    randomImagesFuture.then((randomImages) {
      setState(() {
        imageUrl = randomImages[0];
      });
    });
  }

  void performSearch() {
    if (searchQuery.isNotEmpty) {
      apiService.searchImages(searchQuery, 20).then((searchResults) {
        setState(() {
          randomImagesFuture = Future.value(searchResults);
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          drawer: const NavBar(),
          backgroundColor: const Color.fromRGBO(243, 243, 243, 1),
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
          ),
          body: Stack(
            children: [
              ListView(
                children: [
                  SafeArea(
                      child: Column(
                    children: <Widget>[
                      Container(
                        width: double.infinity, //tüm satırı yapmak için
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
                          color: Colors.white,
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Align(
                              alignment: Alignment.center,
                              child: const Text(
                                "~ Tarzini Kesfet ~",
                                style: TextStyle(color: Colors.black, fontSize: 40),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                color: const Color.fromRGBO(244, 243, 243, 1),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: TextField(
                                      onChanged: (value) {
                                        setState(() {
                                          searchQuery = value;
                                        });
                                      },
                                      decoration: const InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "Kendini Kesfetmek Için Ara",
                                        hintStyle: TextStyle(color: Colors.grey, fontSize: 15),
                                        contentPadding: EdgeInsets.only(left: 10),
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                      onPressed: () {
                                        performSearch();
                                      },
                                      icon: const Icon(Icons.search))
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Populer Resimler",
                              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                              ),

                              // height: 400,

                              child: FutureBuilder<List<String>>(
                                  future: randomImagesFuture,
                                  builder: (context, snapshot) {
                                    return SizedBox(
                                      height: MediaQuery.of(context).size.height -
                                          kToolbarHeight -
                                          kBottomNavigationBarHeight,
                                      child: GridView.builder(
                                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          crossAxisSpacing: 10,
                                          mainAxisSpacing: 30,
                                          mainAxisExtent: 300,
                                        ),
                                        itemBuilder: (context, index) {
                                          if (snapshot.connectionState == ConnectionState.waiting) {
                                            return const Center(
                                                child: CircularProgressIndicator(
                                              color: Colors.grey,
                                            ));
                                          } else if (snapshot.hasError) {
                                            return Text('Hata: ${snapshot.error}');
                                          } else {
                                            final imageUrls = snapshot.data;
                                            final imageUrl = imageUrls![index % imageUrls.length];
                                            return GestureDetector(
                                              onTap: () {
                                                Navigator.push(context, MaterialPageRoute(
                                                  builder: (context) {
                                                    return DetailPage(imageUrl: imageUrl);
                                                  },
                                                ));
                                              },
                                              child: Hero(
                                                tag: 'image$index',
                                                child: CatBlock(imageUrl: imageUrl),
                                              ),
                                            );
                                          }
                                        },
                                        itemCount: snapshot.hasData ? snapshot.data!.length * 2 : 0,
                                        physics: const BouncingScrollPhysics(),
                                      ),
                                    );
                                  }),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )),
                ],
              ),
              Positioned(
                bottom: MediaQuery.of(context).padding.bottom + 10,
                left: 20,
                right: 20,
                child: SizedBox(
                  width: 50,
                  child: ClipRRect(borderRadius: BorderRadius.circular(20), child: const MyBottomNavigationBar())),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
