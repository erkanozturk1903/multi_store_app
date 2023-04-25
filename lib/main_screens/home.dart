import 'package:flutter/material.dart';
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
            Center(
              child: Text('Erkek Ekran'),
            ),
            Center(
              child: Text('Kadın Ekran'),
            ),
            Center(
              child: Text('Ayakkabı Ekran'),
            ),
            Center(
              child: Text('Çanta Ekran'),
            ),
            Center(
              child: Text('Elektronik Ekran'),
            ),
            Center(
              child: Text('Aksesuar Ekran'),
            ),
            Center(
              child: Text('Ev&Bahçe Ekran'),
            ),
            Center(
              child: Text('Çocuk Ekran'),
            ),
            Center(
              child: Text('Makyaj Ekran'),
            )
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
