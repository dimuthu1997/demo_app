import 'package:demo_app/services/provider/authentication.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../services/provider/app_state.dart';

class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({super.key});

  @override
  State<SplashScreenPage> createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  late AppStateProvider appStateProvider;
  late AuthService _authService;

  @override
  void initState() {
    appStateProvider = Provider.of<AppStateProvider>(context, listen: false);
    _authService = Provider.of<AuthService>(context, listen: false);

    Future.delayed(const Duration(seconds: 4), () async {
      appStateProvider.isLoading = true;
      await _authService.startUpCheck();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Container(
                width: 160,
                height: 160,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Center(
                    child: Text(
                  "LOGO",
                  style: TextStyle(color: Colors.black),
                )),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text("DEMO",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
