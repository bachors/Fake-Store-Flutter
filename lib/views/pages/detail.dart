import 'package:flutter/material.dart';

import '../widgets/button.dart';
import '../widgets/dot.dart';

class DetailPage extends StatefulWidget {
  final String image;
  final String title;
  final String price;
  final String description;
  final String category_name;
  final String heroTag;

  const DetailPage({
    super.key,
    required this.image,
    required this.title,
    required this.price,
    required this.description,
    required this.category_name,
    required this.heroTag,
  });

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage>
    with SingleTickerProviderStateMixin {
  Color? selectedColor;
  bool isLiked = false;

  final List<Color> colorOptions = [
    Colors.yellow,
    Colors.black,
    Colors.grey,
    Colors.blue,
  ];

  late AnimationController _slideController;
  late Animation<Offset> _containerSlideAnimation;
  late Animation<Offset> _textSlideAnimation;
  late Animation<double> _containerFadeAnimation;

  @override
  void initState() {
    super.initState();
    selectedColor = colorOptions.first;

    _slideController = AnimationController(
      vsync: this,
      duration:
      const Duration(milliseconds: 900), // Slightly longer for smoothness
    );

    _containerSlideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
    ));

    _containerFadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: const Interval(0.0, 0.6, curve: Curves.easeIn),
    ));

    _textSlideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.6),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: const Interval(0.5, 1.0, curve: Curves.easeOut),
    ));

    _slideController.forward();
  }

  @override
  void dispose() {
    _slideController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const mainColor = Color(0xff1e282d);
    const bgColor = Color(0xff181c1f);
    const tagStyle = TextStyle(
      fontFamily: 'ShareTech',
      fontWeight: FontWeight.bold,
      fontSize: 16,
      color: mainColor,
    );
    const whiteBold = TextStyle(
      color: Colors.white,
      fontSize: 25,
      fontWeight: FontWeight.bold,
      fontFamily: 'ShareTech',
    );

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: bgColor,
        leading: Padding(
          padding: const EdgeInsets.only(left: 15),
          child: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              height: 50,
              width: 50,
              decoration: const BoxDecoration(
                color: Colors.black26,
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: const Center(
                child: Icon(
                  Icons.arrow_back_ios_new,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ),
          ),
        ),
        actions: [
          iconButton(
            context,
            color: isLiked ? Colors.red : Colors.white,
            icon: isLiked ? Icons.favorite : Icons.favorite_border,
            onPressed: () {
              setState(() {
                isLiked = !isLiked;
              });
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Hero(
                tag: widget.heroTag,
                child: Image.network(
                  widget.image,
                  alignment: Alignment.center,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            FadeTransition(
              opacity: _containerFadeAnimation,
              child: SlideTransition(
                position: _containerSlideAnimation,
                child: Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: mainColor,
                    borderRadius:
                    BorderRadius.vertical(top: Radius.circular(50)),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 25),
                      Container(
                        height: 30,
                        width: 160,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child:
                        Center(child: Text(widget.category_name, style: tagStyle)),
                      ),
                      const SizedBox(height: 30),
                      SlideTransition(
                        position: _textSlideAnimation,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.title,
                              style: whiteBold,
                            ),
                            const SizedBox(height: 20),
                            SizedBox(
                              width: double.infinity,
                              child: Text(
                                '\$${widget.price}',
                                style: whiteBold,
                                textAlign: TextAlign.right,
                              ),
                            ),
                            const SizedBox(height: 20),
                            Text(
                              widget.description,
                              style: const TextStyle(
                                color: Colors.white60,
                                fontFamily: 'ShareTech',
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(height: 30),
                            const Text(
                              'VARIANTS',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'ShareTech',
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Row(
                          children: colorOptions
                              .map((color) => ColorDot(
                            color: color,
                            isSelected: selectedColor == color,
                            onTap: () {
                              setState(() {
                                selectedColor = color;
                              });
                            },
                          ))
                              .toList(),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        height: 50,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.black38,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.shopping_cart, color: Colors.white),
                            SizedBox(width: 20),
                            Text(
                              'Add to Cart',
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'ShareTech',
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}