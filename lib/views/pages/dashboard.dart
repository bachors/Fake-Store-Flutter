import 'dart:ui';

import 'package:flutter/material.dart';

import '../../controllers/store_controller.dart';
import '../../models/store_model.dart';
import '../widgets/gird.dart';
import '../widgets/tab.dart';

class DashboardPage extends StatefulWidget {

  const DashboardPage({
    super.key,
  });

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage>
    with TickerProviderStateMixin {
  int _selectedTabIndex = 0;
  bool _showGrid = false;
  final List<Store> _stores = <Store>[];
  List<Store> _storesDisplay = <Store>[];

  late AnimationController _textAnimController;
  late AnimationController _profileAnimController;
  late AnimationController _searchAnimController;
  late AnimationController _fadeContainerController;
  late AnimationController _tabAnimController;
  late Animation<Offset> _textOffsetAnim;
  late Animation<double> _searchScaleAnim;
  late Animation<double> _containerFadeAnim;
  late Animation<double> _tabScaleAnim;
  late AnimationController _gridSlideController;
  late Animation<Offset> _gridSlideAnimation;

  @override
  void initState() {
    super.initState();

    fetchStores().then((value) {
      setState(() {
        _stores.addAll(value);
        _storesDisplay = _stores;
      });
    });

    _textAnimController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 600));
    _profileAnimController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 600));
    _searchAnimController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 600));
    _fadeContainerController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 800));
    _tabAnimController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 600));

    _textOffsetAnim =
        Tween<Offset>(begin: const Offset(-1.5, 0), end: Offset.zero).animate(
          CurvedAnimation(parent: _textAnimController, curve: Curves.easeIn),
        );
    _gridSlideController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _gridSlideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _gridSlideController,
      curve: Curves.easeOut,
    ));


    _searchScaleAnim =
        Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
          parent: _searchAnimController,
          curve: Curves.easeOutBack,
        ));

    _containerFadeAnim =
        Tween<double>(begin: 0.0, end: 1.0).animate(_fadeContainerController);

    _containerFadeAnim = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _fadeContainerController,
        curve: Curves.easeIn,
      ),
    );

    _tabScaleAnim = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: _tabAnimController,
      curve: Curves.easeOutBack,
    ));

    _startAnimations();
  }

  void _startAnimations() async {
    _textAnimController.forward(); // Text slides in immediately
    await Future.delayed(const Duration(milliseconds: 100));

    _profileAnimController.forward(); // Profile slides in shortly after text
    await Future.delayed(const Duration(milliseconds: 100));

    _searchAnimController.forward(); // Search scales in shortly after profile

    await Future.delayed(const Duration(milliseconds: 200));
    _fadeContainerController
        .forward(); // Fade container (profile image) fades in with delay

    await Future.delayed(const Duration(milliseconds: 100));
    _tabAnimController.forward(); // Tabs scale in after container fade

    setState(() {
      _showGrid = true;
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _gridSlideController.forward(); // Grid slides in after tabs
    });
  }

  @override
  void dispose() {
    _gridSlideController.dispose();
    _textAnimController.dispose();
    _profileAnimController.dispose();
    _searchAnimController.dispose();
    _fadeContainerController.dispose();
    _tabAnimController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xff1e282d),
        body: Stack(
          clipBehavior: Clip.none,
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 25.0, left: 15),
                    child: Row(
                      children: [
                        Expanded(
                          child: SlideTransition(
                            position: _textOffsetAnim,
                            child: const Text(
                              'FAKE STORE',
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'ShareTech',
                                fontWeight: FontWeight.bold,
                                fontSize: 35,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: FadeTransition(
                            opacity: _containerFadeAnim,
                            child: const CircleAvatar(
                              radius: 30,
                              backgroundImage:
                              NetworkImage('https://avatars.githubusercontent.com/u/4948333'),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  ScaleTransition(
                    scale: _searchScaleAnim,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                          child: Container(
                            height: 50,
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            decoration: BoxDecoration(
                              color: Colors.black12.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              children: [
                                const Icon(Icons.search, color: Colors.white54),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: TextFormField(
                                    onChanged: (searchText) {
                                      searchText = searchText.toLowerCase();
                                      setState(() {
                                        _storesDisplay = _stores.where((u) {
                                          var nameLowerCase = u.title.toLowerCase();
                                          return nameLowerCase.contains(searchText);
                                        }).toList();
                                      });
                                    },
                                    style: const TextStyle(color: Colors.white),
                                    decoration: const InputDecoration(
                                      hintText: 'What are you looking for?',
                                      hintStyle: TextStyle(color: Colors.white54),
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ScaleTransition(
                    scale: _tabScaleAnim,
                    child: DefaultTabController(
                      length: 5,
                      initialIndex: _selectedTabIndex,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: TabBar(
                          onTap: (index) {
                            setState(() => _selectedTabIndex = index);
                          },
                          isScrollable: true,
                          indicator: const BoxDecoration(),
                          dividerColor: Colors.transparent,
                          tabs: [
                            buildTab('All', _selectedTabIndex == 0),
                            buildTab('Men\'s Clothing', _selectedTabIndex == 1),
                            buildTab('Women\'s Clothing', _selectedTabIndex == 2),
                            buildTab('Electronics', _selectedTabIndex == 3),
                            buildTab('Jewelery', _selectedTabIndex == 4),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  AnimatedOpacity(
                    duration: const Duration(milliseconds: 600),
                    opacity: _showGrid ? 1.0 : 0.0,
                    child: SlideTransition(
                      position: _gridSlideAnimation,
                      child: SizedBox(
                        height: 600,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30.0),
                          child: StaggeredGridPage(
                            allItems: _storesDisplay,
                            selectedCategoryIndex: _selectedTabIndex,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}