import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:starbucks_challenge/colors.dart';
import 'package:starbucks_challenge/page_controller.dart';
import 'package:starbucks_challenge/page_controller.dart';
import 'package:starbucks_challenge/page_controller.dart';
import 'package:starbucks_challenge/page_controller.dart';

import 'data.dart';
import 'drinkCard.dart';

class Starbucks extends StatefulWidget {
  const Starbucks({Key? key}) : super(key: key);

  @override
  _StarbucksState createState() => _StarbucksState();
}

class _StarbucksState extends State<Starbucks>
    with SingleTickerProviderStateMixin {
  late PageController pageController;
  late AnimationController animationController;
  late Animation animation;

  @override
  void initState() {
    // TODO: implement initState

    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1200));
    animation =
        CurvedAnimation(parent: animationController, curve: Curves.easeOutBack);
    pageController = PageController(
        initialPage: 0,
        viewportFraction: animationController.isCompleted ?  1:0.8 );
    if (mounted) {
      pageController.addListener(() {
        Provider.of<OffsetController>(context, listen: false)
            .changeOffset(pageController.page);
        /*setState(() {
        pageOffset = pageController.page ?? 0;
        pageOffset = pageContropageOffset??0ller.page ?? 0;
      });*/
      });
    }
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    pageController.dispose();
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    double pageOffset = Provider.of<OffsetController>(context).pageOffset;
    Widget buildToolBar() {
      return Padding(
        padding: const EdgeInsets.only(top: 16.0),
        child: Row(
          children: [
            const SizedBox(
              width: 20,
            ),
            AnimatedBuilder(
                animation: animation,
                builder: (context, Widget? snapshot) {
                  return Transform.translate(
                    offset: Offset(-200.0 * (animation.value ?? 0), 0),
                    child: Image.asset(
                      'images/drawer.png',
                      height: 50,
                      width: 50,
                    ),
                  );
                }),
            const Spacer(),
            AnimatedBuilder(
                animation: animation,
                builder: (context, Widget? snapshot) {
                  return Transform.translate(
                    offset: Offset(
                        200.0 * (animation.value ?? 0) + (animation.value ?? 0),
                        0),
                    child: Image.asset(
                      'images/location.png',
                      height: 50,
                      width: 50,
                    ),
                  );
                }),
            const SizedBox(
              width: 20,
            ),
          ],
        ),
      );
    }

    Widget buildLogo(Size size) {
      return Positioned(
          left: size.width / 2 - 30,
          top: 16,
          child: AnimatedBuilder(
              animation: animation,
              builder: (context, Widget? snapshot) {
                return Transform(
                  transform: Matrix4.identity()
                    ..translate(0.0, size.height / 2 * (animation.value ?? 0))
                    ..scale(1 + (animation.value ?? 0)),
                  origin: const Offset(25, 25),
                  child: GestureDetector(
                    onTap: () {
                      animationController.isCompleted
                          ? animationController.reverse()
                          : animationController.forward();
                    },
                    child: Image.asset(
                      'images/logo.png',
                      height: 60,
                      width: 60,
                    ),
                  ),
                );
              }));
    }

    Widget buildPager(Size size) {
      return Positioned(
        top: 60,
        child: AnimatedBuilder(
            animation: animation,
            builder: (context, Widget? snapshot) {
              return Transform.translate(
                offset: Offset(400.0 * (animation.value ?? 0), 0.0),
                child: Container(
                  margin: const EdgeInsets.only(top: 30, bottom: 30),
                  height: size.height - 80,
                  width: size.width,
                  child: PageView.builder(
                      controller: pageController,
                      itemCount: listOfDrinks.length,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return DrinkCard(
                          drink: listOfDrinks[index],
                          offset: pageOffset,
                          index: index,
                        );
                      }),
                ),
              );
            }),
      );
    }

    Widget buildContainer(int index) {
      return AnimatedContainer(
        height: index == (pageOffset.floor()) && index <= pageOffset ? 20 : 10,
        width: index == (pageOffset.floor()) && index <= pageOffset ? 20 : 10,
        margin: const EdgeInsets.all(5),
        duration: const Duration(milliseconds: 300),
        decoration: BoxDecoration(
            color: index == (pageOffset.floor()) && index <= pageOffset
                ? mAppGreen
                : Colors.grey,
            borderRadius: BorderRadius.circular(20)),
      );
    }

    Widget buildPageIndecator() {
      return Positioned(
        bottom: 0,
        left: 10,
        height: 50,
        width: 200,
        child: AnimatedBuilder(
            animation: animation,
            builder: (context, snapshot) {
              return Opacity(
                opacity: (1.0 - (animation.value > 1 ? 1 : animation.value)),
                child: Row(
                  children: List.generate(3, (index) => buildContainer(index)),
                ),
              );
            }),
      );
    }

    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          height: size.height,
          child: Stack(
            children: [
              buildToolBar(),
              buildLogo(size),
              buildPager(size),
              buildPageIndecator(),
            ],
          ),
        ),
      ),
    );
  }
}
