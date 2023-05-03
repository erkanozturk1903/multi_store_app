import 'package:flutter/material.dart';
import 'package:multi_store_app/widgets/appbar_widgets.dart';

class FullScreenView extends StatefulWidget {
  final List<dynamic> imageList;
  const FullScreenView({
    super.key,
    required this.imageList,
  });

  @override
  State<FullScreenView> createState() => _FullScreenViewState();
}

class _FullScreenViewState extends State<FullScreenView> {
  final PageController _controller = PageController();
  int index = 0;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: const AppBarBackButton(),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Center(
              child: Text(
                ('${index + 1}') + ('/') + (widget.imageList.length.toString()),
                style: const TextStyle(fontSize: 24, letterSpacing: 8),
              ),
            ),
            SizedBox(
              height: size.height * 0.45,
              child: PageView(
                onPageChanged: (value) {
                  setState(() {
                    index = value;
                  });
                },
                controller: _controller,
                children: images(),
              ),
            ),
            SizedBox(
              height: size.height * 0.2,
              child: imageView(),
            )
          ],
        ),
      ),
    );
  }

  Widget imageView() {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: widget.imageList.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            _controller.jumpToPage(index);
          },
          child: Container(
            margin: const EdgeInsets.all(8),
            width: 120,
            decoration: BoxDecoration(
                border: Border.all(width: 4, color: Colors.yellow),
                borderRadius: BorderRadius.circular(15)),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                widget.imageList[index],
                fit: BoxFit.cover,
              ),
            ),
          ),
        );
      },
    );
  }

  List<Widget> images() {
    return List.generate(
      widget.imageList.length,
      (index) {
        return InteractiveViewer(
          transformationController: TransformationController(),
          child: Image.network(
            widget.imageList[index].toString(),
          ),
        );
      },
    );
  }
}
