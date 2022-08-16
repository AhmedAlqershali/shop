import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatefulWidget {
  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var boaredController = PageController();

  bool islast = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/loginScreen');
              },
              child: Text(
                'SKIP',
                style: TextStyle(color: Colors.deepOrange),
              ))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView(
                scrollDirection: Axis.horizontal,
                controller: boaredController,
                onPageChanged: (index) {
                  if (index == 3 - 1) {
                    setState(() {
                      islast = true;
                    });
                  } else {
                    setState(() {
                      islast = false;
                    });
                  }
                },
                physics: BouncingScrollPhysics(),
                children: [
                  buildBoardingIteam(
                      img:
                          'https://upload.wikimedia.org/wikipedia/commons/thumb/8/8e/Shop.svg/1200px-Shop.svg.png',
                      title: 'title',
                      body: 'body'),
                  buildBoardingIteam(
                      img:
                          'https://upload.wikimedia.org/wikipedia/commons/thumb/8/8e/Shop.svg/1200px-Shop.svg.png',
                      title: 'title',
                      body: 'body'),
                  buildBoardingIteam(
                      img:
                          'https://upload.wikimedia.org/wikipedia/commons/thumb/8/8e/Shop.svg/1200px-Shop.svg.png',
                      title: 'title',
                      body: 'body'),
                ],
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Row(
              children: [
                Spacer(),
                FloatingActionButton(
                  onPressed: () {
                    if (islast) {
                      Navigator.pushReplacementNamed(context, '/loginScreen');
                    } else {
                      boaredController.nextPage(
                          duration: Duration(milliseconds: 750),
                          curve: Curves.fastLinearToSlowEaseIn);
                    }
                  },
                  child: Icon(Icons.arrow_forward_ios),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class buildBoardingIteam extends StatelessWidget {
  buildBoardingIteam(
      {Key? key, required this.img, required this.title, required this.body})
      : super(key: key);
  late String img;
  late String title;
  late String body;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Image.network('$img'),
        ),
        SizedBox(
          height: 20,
        ),
        Text(
          '$title',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: 15,
        ),
        Text(
          '$body',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),

      ],
    );
  }
}
