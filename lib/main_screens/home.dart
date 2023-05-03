import 'package:flutter/material.dart';
import 'package:multi_store_app/galleries/acces_gallery.dart';
import 'package:multi_store_app/galleries/bags_gallery.dart';
import 'package:multi_store_app/galleries/beauty_gallery.dart';
import 'package:multi_store_app/galleries/electronics_dallery.dart';
import 'package:multi_store_app/galleries/homegarden_gallery.dart';
import 'package:multi_store_app/galleries/kids_gallery.dart';
import 'package:multi_store_app/galleries/men_gallery.dart';
import 'package:multi_store_app/galleries/shoes_gallery.dart';
import 'package:multi_store_app/galleries/women_gallery.dart';
import 'package:multi_store_app/widgets/fake_search.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 9,
      child: Scaffold(
        backgroundColor: Colors.grey.shade100.withOpacity(0.5),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          title: const FakeSearch(),
          bottom: const TabBar(
            isScrollable: true,
            indicatorColor: Colors.yellow,
            indicatorWeight: 8,
            tabs: [
              RepeatedTab(
                label: 'Erkek',
              ),
              RepeatedTab(
                label: 'Kadın',
              ),
              RepeatedTab(
                label: 'Ayakkabı',
              ),
              RepeatedTab(
                label: 'Çanta',
              ),
              RepeatedTab(
                label: 'Elektronik',
              ),
              RepeatedTab(
                label: 'Aksesuar',
              ),
              RepeatedTab(
                label: 'Ev&Bahçe',
              ),
              RepeatedTab(
                label: 'Çocuk',
              ),
              RepeatedTab(
                label: 'Makyaj',
              ),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            MenGalleryScreen(),
            WomenGalleryScreen(),
            ShoesGalleryScreen(),
            BagsGalleryScreen(),
            ElectronicsGalleryScreen(),
            AccessoriesGalleryScreen(),
            HomeGardenGalleryScreen(),
            KidsGalleryScreen(),
            BeautyGalleryScreen()
          ],
        ),
      ),
    );
  }
}

class RepeatedTab extends StatelessWidget {
  final String label;
  const RepeatedTab({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Tab(
      child: Text(
        label,
        style: TextStyle(
          color: Colors.grey.shade600,
        ),
      ),
    );
  }
}
