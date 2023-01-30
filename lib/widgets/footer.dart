import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:semantic/utils/layout.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  _launchURL() async {
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
    final bool isMobile = useMobileLayout(context);


    if (isMobile) {
      return Container();
    }
    return Container(
      height: 50,
      color: Colors.grey.shade200,
      child: Center(
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text('About'),
              Text('Careers'),
              Text('Docs'),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
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
