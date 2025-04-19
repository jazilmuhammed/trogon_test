import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_inappwebview_android/flutter_inappwebview_android.dart';
import 'package:trogon_test/provider/module_screen_provider.dart';
import 'package:trogon_test/provider/subject_provider.dart';
import 'package:trogon_test/provider/video_list_screen_provider.dart';
import 'package:trogon_test/screens/splash_screen.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Add this line to initialize the webview platform
  InAppWebViewPlatform.instance = AndroidInAppWebViewPlatform(); // or iOSInAppWebViewPlatform()

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SubjectProvider()),
        ChangeNotifierProvider(create: (_) => ModuleProvider()),
        ChangeNotifierProvider(create: (_) => VideoProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: SplashScreen(),
      ),
    );
  }
}
