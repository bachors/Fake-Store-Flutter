import 'package:fakestore/views/pages/dashboard.dart';
import 'package:flutter/material.dart';

class OnboradingPage extends StatefulWidget {
  const OnboradingPage({super.key});

  @override
  State<OnboradingPage> createState() => _OnboradingPageState();
}

class _OnboradingPageState extends State<OnboradingPage>
    with TickerProviderStateMixin {
  final String imagetransition = 'chairHero';

  double _textOpacity = 0.0;
  double _imageOpacity = 0.0;
  double _buttonOpacity = 0.0;

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(milliseconds: 200), () {
      setState(() => _textOpacity = 1.0);
    });

    Future.delayed(const Duration(milliseconds: 700), () {
      setState(() => _imageOpacity = 1.0);
    });

    Future.delayed(const Duration(milliseconds: 1000), () {
      setState(() => _buttonOpacity = 1.0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff1e282d),
      body: SafeArea(
        child: Stack(
          children: [
            // Background heading text
            Positioned(
              top: 50,
              left: 20,
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 600),
                curve: Curves.easeInOut,
                opacity: _textOpacity,
                child: const Text(
                  " EXPLORE \n AND GET \n INSPIRED",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 46,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'ShareTech',
                  ),
                ),
              ),
            ),

            // Bottom-right circle
            Positioned(
              bottom: -40,
              left: 10,
              child: Container(
                height: 550,
                width: 600,
                decoration: const BoxDecoration(
                  color: Color(0xff181c1f),
                  shape: BoxShape.circle,
                ),
              ),
            ),

            // Image overlaying the circle with Hero & fade
            Positioned(
              bottom: 50,
              left: 10,
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 800),
                curve: Curves.easeInOut,
                opacity: _imageOpacity,
              ),
            ),

            // Button at the bottom center with fade
            Positioned(
              bottom: 0,
              left: 160,
              right: 0,
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 800),
                curve: Curves.easeInOut,
                opacity: _buttonOpacity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const DashboardPage(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff1e282d),
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(
                        vertical: 40,
                        horizontal: 40
                    ),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                      ),
                    ),
                  ),
                  child: const Text(
                    "GET STARTED",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      fontFamily: 'ShareTech',
                      color: Colors.white,
                    ),
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


//0xff5e0b04 ,0xff4a0803 , 0xff330602