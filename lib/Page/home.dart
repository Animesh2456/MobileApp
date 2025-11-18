import 'package:first_login/RestaurantPage/pizza1.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final TextEditingController _controller = TextEditingController();

  final List<String> imagePaths = [
    'assets/images/avatar.jpg',
    'assets/images/avatar.jpg',
    'assets/images/avatar.jpg',
  ];

  final List<String> categories = ['Pizza', 'Biryani', 'Dessert', 'Burger', 'Chinese'];
  final List<Map<String, String>> restaurantList = [
    {
      "name": "Biryani Hyd.",
      "image": "https://i.pinimg.com/originals/6e/f7/1b/6ef71b1ef983e91603530c5cbe164975.jpg",
      "cuisine": "Biryani, North Indian",
      "rating": "4.3",
    },
    {
      "name": "Pizza Palace",
      "image": "https://www.plazacaracol.mx/uploads/business/domino-s-image_banner.jpg",
      "cuisine": "Domino's",
      "rating": "4.1",
    },
    {
      "name": "Burger Point",
      "image": "https://cmx.weightwatchers.com/assets-proxy/weight-watchers/image/upload/v1594406683/visitor-site/prod/ca/burgers_mobile_my18jv",
      "cuisine": "Fast Food, Burgers",
      "rating": "4.0",
    },
    {
      "name": "Sweet Treats",
      "image": "https://media-cdn.tripadvisor.com/media/photo-s/13/a1/34/fd/rock-slide-brownie.jpg",
      "cuisine": "Desserts",
      "rating": "4.6",
    },
  ];
  final List<Map<String, String>> FirstLineList = [
    {
      "name": "Biryani Hyd.",
      "image": "https://th.bing.com/th/id/OIP.i2lawZLOpq2PVsiYYt5pEgAAAA?r=0&rs=1&pid=ImgDetMain&cb=idpwebp2&o=7&rm=3",
      "cuisine": "Biryani, North Indian",
      "rating": "4.3",
      "location":"Kalyan Nagar",
      "distance":"1 km"
    },
    {
      "name": "Pizza Palace",
      "image": "https://cdn.pixabay.com/photo/2024/03/15/16/25/pizza-8635314_1280.jpg",
      "cuisine": "Domino's",
      "rating": "4.1",
      "location":"Manjunath Nagar",
      "distance":"2 km"
    },
    {
      "name": "Burger Point",
      "image": "https://cmx.weightwatchers.com/assets-proxy/weight-watchers/image/upload/v1594406683/visitor-site/prod/ca/burgers_mobile_my18jv",
      "cuisine": "Fast Food, Burgers",
      "rating": "4.0",
      "location":"Kalyan Nagar",
      "distance":"3 km"
    },
    {
      "name": "Sweet Treats",
      "image": "https://media-cdn.tripadvisor.com/media/photo-s/13/a1/34/fd/rock-slide-brownie.jpg",
      "cuisine": "Desserts",
      "rating": "4.6",
      "location":"Kalyan Nagar",
      "distance":"4 km"
    },
  ];
  final List<Map<String, String>> SecondLineList = [
    {
      "name": "IceCream",
      "image": "https://static.vecteezy.com/system/resources/thumbnails/046/303/096/small_2x/strawberry-ice-cream-scoops-in-a-bowl-free-png.png",
      "cuisine": "IceCream",
      "rating": "4.6",
    },
    {
      "name": "Coke",
      "image": "https://ceoworld.biz/wp-content/uploads/2024/09/Coca-cola.jpg",
      "cuisine": "Fast Food, Burgers",
      "rating": "4.0",
    },
    {
      "name": "Biryani",
      "image": "https://www.wikihow.com/images/a/a8/Make-Hyderabadi-Vegetable-Biryani-Step-15.jpg",
      "cuisine": "Biryani, North Indian",
      "rating": "4.3",
    },
    {
      "name": "Pizza Palace",
      "image": "https://s3-media0.fl.yelpcdn.com/bphoto/4iyTjCbkwYtqiRdSMuo3Aw/o.jpg",
      "cuisine": "Domino's",
      "rating": "4.1",
    },


  ];

  List<Map<String, String>> filteredItems = [];
  //final TextEditingController _controller = TextEditingController();

  void _search(String query) {

    // After Searching when it is empty then also it was showing filteredItems value to overcome that we will use this method
    if (query.trim().isEmpty) {
      setState(() {
        filteredItems = [];  //doing it empty, so all the values get normall back as it was earlier
      });
      return;
    }

    final allItems = [
      ...FirstLineList,
      ...SecondLineList,
      ...restaurantList,
    ];

    final results = allItems.where((item) =>
    item['name']!.toLowerCase().contains(query.toLowerCase()) ||
        item['cuisine']!.toLowerCase().contains(query.toLowerCase())
    ).toList();

    setState(() {
      filteredItems = results;
    });
  }
  //final displayList = _controller.text.isEmpty ? FirstLineList : filteredItems;

  @override
  Widget build(BuildContext context) {

    List<Map<String, String>> displayList =
    _controller.text.isEmpty ? FirstLineList : filteredItems;

    final List<Map<String, String>> currentList =
    filteredItems.isEmpty && _controller.text.isEmpty
        ? restaurantList
        : filteredItems;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 🔍 Search bar
                  Padding(
                    padding: EdgeInsets.all(16),
                    child: TextField(

                      controller: _controller,
                      onChanged: _search,
                      decoration: InputDecoration(
                        hintText: "Search",
                        prefixIcon: Icon(Icons.search),
                        filled: true,
                        fillColor: Colors.grey[150],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
            
                  // 🗂️ Category list
                  Container(
                    height: 60,

                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: categories.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: GestureDetector(
                            onTap: () {
                              _controller.text = categories[index];
                              _search(categories[index]); // call your search function
                            },
                            child: Chip(
                              label: Text(categories[index]),
                              backgroundColor: Colors.orange[100],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
            
                  SizedBox(height: 16),

                  SizedBox(
                    height: 180, // Control height of each horizontal item

                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: displayList.length,
                      //itemCount: restaurantList.length,

                      itemBuilder: (context, index) {
                       // final item = FirstLineList[index];
                        final displayList = _controller.text.isEmpty ? FirstLineList : filteredItems;
                        final item = displayList[index];
                        return GestureDetector(
                          onTap: () {     //on taping on this particular container it should open restaurant page with images
                            Navigator.pushNamed(
                              context,
                              'restaurant', // 🔸 this is the route name (must match with your route setup)
                              arguments: item, // ✅ pass your restaurant item here
                            );
                          },
                          child: Container(
                            width: 155, // Width of each item
                            margin: EdgeInsets.only(left: 16, right: index == restaurantList.length - 1 ? 16 : 0),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              elevation: 4,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // 🖼 Image on top
                                  ClipRRect(
                                    borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                                    child: Image.network(
                                      item['image']!,
                                      height: 90,
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                      errorBuilder: (context, error, stackTrace) => Container(
                                        height: 100,
                                        color: Colors.grey,
                                        child: Center(child: Icon(Icons.error)),
                                      ),
                                    ),
                                  ),

                                  // 📋 Details below image
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                    child: ListTile(
                                      contentPadding: EdgeInsets.zero,
                                      title: Text(
                                        item['name']!,
                                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                                      ),
                                      subtitle: Text(
                                        item['cuisine']!,
                                        style: TextStyle(fontSize: 12),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      trailing: Text(
                                        '⭐ ${item['rating']}',
                                        style: TextStyle(color: Colors.orange),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  SizedBox(height: 10),

                  SizedBox(
                    height: 180, // Control height of each horizontal item

                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: displayList.length,
                      itemBuilder: (context, index) {
                        final displayList = _controller.text.isEmpty ? SecondLineList : filteredItems;
                        final item = displayList[index];

                        return Container(
                          width: 155, // Width of each item
                          margin: EdgeInsets.only(left: 16, right: index == restaurantList.length - 1 ? 16 : 0),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                'restaurant', // 🔸 this is the route name (must match with your route setup)
                                arguments: item, // ✅ pass your restaurant item here
                              );
                            },
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              elevation: 4,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // 🖼 Image on top
                                  ClipRRect(
                                    borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                                    child: Image.network(
                                      item['image']!,
                                      height: 90,
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                      errorBuilder: (context, error, stackTrace) => Container(
                                        height: 100,
                                        color: Colors.grey,
                                        child: Center(child: Icon(Icons.error)),
                                      ),
                                    ),
                                  ),

                                  // 📋 Details below image
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                    child: ListTile(
                                      contentPadding: EdgeInsets.zero,
                                      title: Text(
                                        item['name']!,
                                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                                      ),
                                      subtitle: Text(
                                        item['cuisine']!,
                                        style: TextStyle(fontSize: 12),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      trailing: Text(
                                        '⭐ ${item['rating']}',
                                        style: TextStyle(color: Colors.orange),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  SizedBox(height: 16),
                  // Zomato Banner
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                       'https://asset.inc42.com/2024/03/zomato-PT-social-.png',
                        height: 275,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
            
                  SizedBox(height: 16),
            
                  //  Restaurant list
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      'Popular Restaurants',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),

                  // The below ListView is for Popular Restaurants in Vertical Way
                  ListView.builder(
                    itemCount: currentList.length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),  // Already SingleScroll is there
                    itemBuilder: (context, index) {
                      //final restaurant = restaurantList[index];
                      final restaurant = currentList[index];

                      return Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Card(
                          margin: EdgeInsets.only(bottom: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 4,
                          child: Column(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                                child: Image.network(
                                  restaurant['image']!,
                                  height: 150,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) => Container(
                                    height: 150,
                                    color: Colors.grey,
                                    child: Center(child: Icon(Icons.error)),
                                  ),
                                ),
                              ),
                              ListTile(
                                title: Text(restaurant['name']!),
                                subtitle: Text(restaurant['cuisine']!),
                                trailing: Text('⭐ ${restaurant['rating']}'),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  )
                ],
            ),
          ),
        ),
      ),
    );
  }
}
