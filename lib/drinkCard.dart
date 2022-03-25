import 'package:flutter/material.dart';
import 'package:starbucks_challenge/colors.dart';
import 'drink.dart';
import 'dart:math' as math;

class DrinkCard extends StatelessWidget {
  Drink drink;
  double offset;
  int index;

  DrinkCard(
      {Key? key, required this.drink, this.offset = 0.0, required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double cardWidth = size.width - 60;
    double cardHeight = size.height * 0.5;
    double count = 0;
    double rotate = index - offset;
    /* print('rotate $rotate');
    print('off $offset');*/

    double animate = 0;
    double page;
    for (page = offset; page > 1;) {
      //print(offset);
      page--;
      count++;
    }

    double animation = Curves.easeOutBack.transform(page);

    animate = 100 * (count + animation);
    for (int i = 0; i < index; i++) {
      animate -= 100;
    }

    Widget buildText() {
      return Row(
        children: [
          Text(
            drink.name,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 50,
              color: drink.lightColor,
            ),
          ),
          Text(
            drink.conName,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 50,
              color: drink.darkColor,
            ),
          ),
        ],
      );
    }

    buildBackgroundImage() {
      return Positioned(
          top: size.height * 0.1,
          width: cardWidth,
          height: cardHeight,
          child: Container(
            height: cardHeight,
            width: cardWidth,
            margin: const EdgeInsets.symmetric(horizontal: 30),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(28),
              child: Image.asset(
                drink.backgroundImage,
                fit: BoxFit.cover,
              ),
            ),
          ));
    }

    Widget buildAboveCard() {
      return Positioned(
        top: size.height * 0.1,
        width: cardWidth,
        height: cardHeight,
        child: Container(
          width: cardWidth,
          height: cardHeight,
          padding: const EdgeInsets.all(20),
          margin: const EdgeInsets.symmetric(horizontal: 30),
          decoration: BoxDecoration(
            color: drink.darkColor.withOpacity(0.4),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                drink.name,
                style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                drink.description,
                style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Colors.white54),
              ),
              const Spacer(),
              Row(
                children: [
                  Image.asset('images/cup_s.png'),
                  const SizedBox(
                    width: 5,
                  ),
                  Image.asset('images/cup_M.png'),
                  const SizedBox(
                    width: 5,
                  ),
                  Image.asset('images/cup_L.png'),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Container(
                height: 40,
                decoration: BoxDecoration(
                  color: mAppGreen,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: const [
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      '\$',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      '4.',
                      style: TextStyle(color: Colors.white, fontSize: 19),
                    ),
                    Text(
                      '70',
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }

    Widget buildCupImg() {
      return Positioned(
        bottom: cardHeight / 3,
        right: 0,
        child: Transform.rotate(
          angle: -math.pi * rotate * 0.2,
          child: AnimatedContainer(
            duration: Duration(milliseconds: 300),
            height: size.height * .5,
            child: Image.asset(
              drink.cupImage,
            ),
          ),
        ),
      );
    }

    Widget buildBlurImage() {
      return Positioned(
        left: cardWidth / 2 - 60 - animate,
        bottom: size.height * .25,
        child: Image.asset(
          drink.imageBlur,
        ),
      );
    }

    Widget buildSmallImage() {
      return Positioned(
        right: -5 + animate,
        top: size.height * .3,
        child: Image.asset(drink.imageSmall),
      );
    }

    Widget buildTopImage() {
      return Positioned(
        left: cardWidth / 4 - cardHeight * .2 - animate,
        top: -cardHeight * .15,
        bottom: size.height * .15 + cardHeight - 25,
        child: Image.asset(drink.imageTop),
      );
    }

    return Stack(
      children: [
        buildText(),
        buildBackgroundImage(),
        buildAboveCard(),
        buildCupImg(),
        buildBlurImage(),
        buildSmallImage(),
        buildTopImage(),
      ],
    );
  }
}
