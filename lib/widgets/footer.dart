import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  _launchURL() async {
    print('Click');
    const url =
        'https://docs.google.com/forms/d/e/1FAIpQLSekPhYKaREo9vzxXcVzux0Ej-loEzLSWI9LGU2tow9vLce1Tg/viewform';
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    var shortestSide = MediaQuery.of(context).size.shortestSide;

    final bool useMobileLayout = shortestSide < 600;

    if (useMobileLayout) {
      return Container();
    }
    return Container(
      height: 50,
      color: Colors.grey.shade200,
      child: Center(
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('About'),
              Text('Careers'),
              Text('Docs'),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Facebook'),
              Text('LinkedIn'),
              Text('Contact Us'),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  _launchURL();
                },
                child: const Text('Help'),
              ),
              GestureDetector(
                onTap: () {
                  _launchURL();
                },
                child: const Text('Request'),
              ),
              GestureDetector(
                onTap: () {
                  _launchURL();
                },
                child: const Text('Bug Report'),
              ),
            ],
          ),
        ]),
      ),
    );
  }
}
