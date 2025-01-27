import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'pages/home.dart';
import 'pages/profile.dart';

@riverpod
Future<String> alertas(Ref ref) async {
  final fb = FirebaseFirestore.instance;
  final snapshot = await fb.collection("alertas").get();
  return snapshot.docs.single.id;
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Make sure home is your initial screen widget, not another MaterialApp
      home: const HomePage(), // Replace with your actual home widget
      routes: {
        '/profile': (context) => const ProfilePage(),
      },
    );
  }
}