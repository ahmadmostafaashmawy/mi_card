import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() => runApp(MiCard());

class MiCard extends StatefulWidget {
  @override
  _MiCardState createState() => _MiCardState();
}

class _MiCardState extends State<MiCard> {
  Future<void> _launched;
  String _phone = '+201100411314';
  String _email = 'ahmad.mostafa.3939@gmail.com';
  String _github = 'https://github.com/ahmadmostafaashmawy';
  String _cv =
      'https://drive.google.com/file/d/1MUMv_sYaXr2QeeqBgQA5jLMvgWp-t2Sl/view?usp=sharing';

  Future<void> _launchInBrowser(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: false,
        forceWebView: false,
        headers: <String, String>{'my_header_key': 'my_header_value'},
      );
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<void> _makePhoneCall(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Widget _launchStatus(BuildContext context, AsyncSnapshot<void> snapshot) {
    if (snapshot.hasError) {
      return Text('Error: ${snapshot.error}');
    } else {
      return const Text('');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.teal,
        body: SafeArea(
          child: Container(
            child: Center(
              child: Column(
                children: <Widget>[
                  CircleAvatar(
                    radius: 70,
                    backgroundImage: AssetImage('images/a.jpg'),
                  ),
                  Text(
                    'Ahmed Mostafa',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 40.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Lobster'),
                  ),
                  Text(
                    'Futter Developer',
                    style: TextStyle(
                        color: Colors.teal.shade100,
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                        letterSpacing: 2.5,
                        fontFamily: 'Source Sans Pro'),
                  ),
                  SizedBox(
                    height: 40.0,
                    width: 150.0,
                    child: Divider(
                      color: Colors.teal.shade100,
                    ),
                  ),
                  Card(
                    margin: EdgeInsets.symmetric(
                      horizontal: 25.0,
                      vertical: 10.0,
                    ),
                    child: ListTile(
                      onTap: () => {
                        print('phone call is clicked'),
                        setState(() {
                          _launched = _makePhoneCall('tel:$_phone');
                        }),
                      },
                      leading: Icon(
                        Icons.phone,
                        color: Colors.teal,
                      ),
                      title: Text(
                        '+20 1100 411 314',
                        style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.teal.shade900,
                            fontFamily: 'Source Sans Pro'),
                      ),
                    ),
                  ),
                  Card(
                    margin: EdgeInsets.symmetric(
                      vertical: 10.0,
                      horizontal: 25.0,
                    ),
                    child: ListTile(
                      onTap: () => {
                        setState(() {
                          _launched = _makePhoneCall('mailto:$_email');
                        }),
                      },
                      leading: Icon(
                        Icons.email,
                        color: Colors.teal,
                      ),
                      title: Text(
                        _email,
                        style: TextStyle(
                          color: Colors.teal.shade900,
                          fontFamily: 'Source Sans Pro',
                          fontSize: 20.0,
                        ),
                      ),
                    ),
                  ),
                  Card(
                    margin: EdgeInsets.symmetric(
                      vertical: 10.0,
                      horizontal: 25.0,
                    ),
                    child: ListTile(
                      onTap: () => {
                        print('github is clicked'),
                        setState(() {
                          _launched = _launchInBrowser(_github);
                        }),
                      },
                      leading: Image.asset(
                        'images/github_icon.png',
                        width: 24.0,
                        height: 24.0,
                      ),
                      title: Text(
                        'github.com/ahmadmostafaashmawy',
                        style: TextStyle(
                          color: Colors.teal.shade900,
                          fontFamily: 'Source Sans Pro',
                          fontSize: 20.0,
                        ),
                      ),
                    ),
                  ),
                  Card(
                    margin: EdgeInsets.symmetric(
                      vertical: 10.0,
                      horizontal: 25.0,
                    ),
                    child: ListTile(
                      onTap: () => {
                        setState(() {
                          _launched = _launchInBrowser(_cv);
                        }),
                      },
                      leading: Image.asset(
                        'images/cv_icon.png',
                        width: 24.0,
                        height: 24.0,
                      ),
                      title: Text(
                        'CV',
                        style: TextStyle(
                          color: Colors.teal.shade900,
                          fontFamily: 'Source Sans Pro',
                          fontSize: 20.0,
                        ),
                      ),
                    ),
                  ),
                  const Padding(padding: EdgeInsets.all(16.0)),
                  FutureBuilder<void>(
                      future: _launched, builder: _launchStatus),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
