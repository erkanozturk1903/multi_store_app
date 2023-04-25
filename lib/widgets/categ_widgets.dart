import 'package:flutter/material.dart';
import 'package:multi_store_app/minor_screens/subcateg_products.dart';

class SliderBar extends StatelessWidget {
  final String mainCategName;
  const SliderBar({
    required this.mainCategName,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.8,
      width: MediaQuery.of(context).size.width * 0.05,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.brown.withOpacity(0.2),
              borderRadius: BorderRadius.circular(50)),
          child: RotatedBox(
            quarterTurns: 3,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                mainCategName == 'Makyaj'
                    ? const Text('')
                    : const Text(
                        ' << ',
                        style: style,
                      ),
                Text(mainCategName.toUpperCase(), style: style),
                mainCategName == 'Erkek'
                    ? const Text('')
                    : const Text(
                        ' >> ',
                        style: style,
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

const style = TextStyle(
  color: Colors.brown,
  fontSize: 16,
  fontWeight: FontWeight.w600,
  letterSpacing: 10,
);

class SubCategModel extends StatelessWidget {
  final String mainCategName;
  final String subCategName;
  final String assetName;
  final String subCategLabel;

  const SubCategModel({
    required this.mainCategName,
    required this.subCategName,
    required this.assetName,
    required this.subCategLabel,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SubCategProducts(
              subCategName: subCategName,
              mainCategName: mainCategName,
            ),
          ),
        );
      },
      child: Column(
        children: [
          SizedBox(
            height: 70,
            width: 70,
            child: Image(
              image: AssetImage(
                assetName,
              ),
            ),
          ),
          Expanded(
            child: Text(
              subCategLabel,
            ),
          ),
        ],
      ),
    );
  }
}

class CategHeaderLabel extends StatelessWidget {
  final String headerLabel;
  const CategHeaderLabel({
    super.key,
    required this.headerLabel,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        headerLabel,
        style: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.5,
        ),
      ),
    );
  }
}
