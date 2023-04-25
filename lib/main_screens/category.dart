import 'package:flutter/material.dart';
import 'package:multi_store_app/categories/accessories_categ.dart';
import 'package:multi_store_app/categories/bags_categ.dart';
import 'package:multi_store_app/categories/beauty_categ.dart';
import 'package:multi_store_app/categories/electronics_categ.dart';
import 'package:multi_store_app/categories/homegarden.dart';
import 'package:multi_store_app/categories/kids-categ.dart';
import 'package:multi_store_app/categories/men_categ.dart';
import 'package:multi_store_app/categories/shoes_categ.dart';
import 'package:multi_store_app/categories/women_categ.dart';
import 'package:multi_store_app/widgets/fake_search.dart';

List<ItemsData> items = [
  ItemsData(label: 'Erkek'),
  ItemsData(label: 'Kadın'),
  ItemsData(label: 'Elektronik'),
  ItemsData(label: 'Aksesuar'),
  ItemsData(label: 'Ayakkabı'),
  ItemsData(label: 'Ev&Bahçe'),
  ItemsData(label: 'Makyaj'),
  ItemsData(label: 'Çocuk'),
  ItemsData(label: 'Çanta'),
];

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  final PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
    for (var element in items) {
      element.isSelected = false;
    }
    setState(() {
      items[0].isSelected = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const FakeSearch(),
      ),
      body: Stack(
        children: [
          Positioned(
            bottom: 0,
            left: 0,
            child: sideNavigator(size),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: categView(size),
          ),
        ],
      ),
    );
  }

  Widget sideNavigator(Size size) {
    return SizedBox(
      height: size.height * 0.8,
      width: size.width * 0.2,
      child: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              _pageController.animateToPage(
                index,
                duration: const Duration(
                  milliseconds: 100,
                ),
                curve: Curves.bounceInOut,
              );
            },
            child: Container(
              color: items[index].isSelected == true
                  ? Colors.white
                  : Colors.grey.shade300,
              height: 100,
              child: Center(
                child: Text(items[index].label),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget categView(Size size) {
    return Container(
      height: size.height * 0.8,
      width: size.width * 0.8,
      color: Colors.white,
      child: PageView(
        controller: _pageController,
        onPageChanged: (value) {
          for (var element in items) {
            element.isSelected = false;
          }
          setState(() {
            items[value].isSelected = true;
          });
        },
        scrollDirection: Axis.vertical,
        children: const [
          MenCategory(),
          WomenCategory(),
          ElectronicsCategory(),
          AccessoriesCategory(),
          ShoesCategory(),
          HomeGardenCategory(),
          BeautyCategory(),
          KidsCategory(),
          BagsCategory(),
        ],
      ),
    );
  }
}

class ItemsData {
  String label;
  bool isSelected;

  ItemsData({
    required this.label,
    this.isSelected = false,
  });
}
