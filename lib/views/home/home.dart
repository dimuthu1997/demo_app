import 'package:demo_app/services/provider/authentication.dart';
import 'package:demo_app/utils/common/screen.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.purple,
        title: const Center(child: Text("Home")),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Center(
              child: Center(
                  child: Text(
                "Home",
                style: TextStyle(color: Colors.black),
              )),
            ),
            ScreenUtil.verticalSpace(height: 32),
            SizedBox(
              height: 48,
              width: 180,
              child: ElevatedButton(
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.purple),
                  onPressed: () {
                    AuthService.instance.logout();
                  },
                  child: const Text("Logout")),
            )
          ],
        ),
      ),
    );
  }
}
