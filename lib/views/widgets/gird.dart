import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../models/store_model.dart';
import '../pages/detail.dart';

class StaggeredGridPage extends StatelessWidget {
  final List<Store> allItems;
  final int selectedCategoryIndex;

  const StaggeredGridPage({
    super.key,
    required this.allItems,
    required this.selectedCategoryIndex
  });

  @override
  Widget build(BuildContext context) {

    final items = selectedCategoryIndex == 0
        ? allItems
        : allItems
        .where((item) => int.parse(item.category_id) == selectedCategoryIndex)
        .toList();

    return MasonryGridView.count(
      crossAxisCount: 2,
      mainAxisSpacing: 16,
      crossAxisSpacing: 16,
      shrinkWrap: true,
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        final isOdd = index % 2 != 0;
        return _CardItem(
          key: ValueKey(index),
          image: item.image,
          price: item.price,
          title: item.title,
          description: item.description,
          category_name: item.category_name,
          isOdd: isOdd,
          heroTag: '${item.image}_$index',
          delay: Duration(milliseconds: 100 * index),
        );
      },
    );
  }
}

class _CardItem extends StatefulWidget {
  final String image;
  final String price;
  final String title;
  final String description;
  final String category_name;
  final bool isOdd;
  final String heroTag;
  final Duration delay;

  const _CardItem({
    super.key,
    required this.image,
    required this.price,
    required this.title,
    required this.description,
    required this.category_name,
    required this.isOdd,
    required this.heroTag,
    required this.delay,
  });

  @override
  State<_CardItem> createState() => _CardItemState();
}

class _CardItemState extends State<_CardItem>
    with SingleTickerProviderStateMixin {
  bool isLiked = false;
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _offsetAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));

    _opacityAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    ));

    Future.delayed(widget.delay, () {
      if (mounted) {
        _controller.forward();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _offsetAnimation,
      child: FadeTransition(
        opacity: _opacityAnimation,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailPage(
                          image: widget.image,
                          title: widget.title,
                          price: widget.price,
                          description: widget.description,
                          category_name: widget.category_name,
                          heroTag: widget.heroTag,
                        ),
                      ),
                    );
                  },
                  child: Container(
                    height: widget.isOdd ? 250 : 180,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    alignment: Alignment.center,
                    child: Hero(
                      tag: widget.heroTag,
                      child: Image.network(
                        widget.image,
                        height: widget.isOdd ? 200 : 150,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 10,
                  right: 10,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        isLiked = !isLiked;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: Colors.black26,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Icon(
                        isLiked ? Icons.favorite : Icons.favorite_border,
                        color: isLiked ? Colors.red : Colors.white,
                        size: 18,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Text(
                '\$${widget.price}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontFamily: 'ShareTech',
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Text(
                widget.title,
                style: const TextStyle(
                  color: Colors.white60,
                  fontSize: 15,
                  fontFamily: 'ShareTech',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}