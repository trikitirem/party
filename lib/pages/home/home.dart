import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:party/pages/account/account.dart';
import 'package:party/pages/home/home_events.dart';
import 'package:party/providers/home_provider.dart';
import 'package:party/widgets/input/avatar.dart';

class Home extends ConsumerStatefulWidget {
  const Home({
    Key? key,
  }) : super(key: key);

  static const String path = "/home";

  @override
  ConsumerState createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home> {
  bool _loggedIn = false;

  @override
  void initState() {
    super.initState();

    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        setState(() {
          _loggedIn = false;
        });
      } else {
        setState(() {
          _loggedIn = true;
        });
      }
    });

    ref.read(homeProvider.notifier).load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "Welcome!",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                        ),
                      ),
                      Text("Search for events in your area"),
                    ],
                  ),
                  Avatar(
                    onClick: () {
                      Navigator.pushNamed(context, Account.path);
                    },
                  ),
                ],
              ),
              const SizedBox(
                height: 16.0,
              ),
              const HomeEvents(),
            ],
          ),
        ),
      ),
    );
  }
}
