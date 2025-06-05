import 'package:flutter/material.dart';
import 'package:list/firebase/firebase_authentication.dart';
import 'package:list/ui/list/generic_list.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const App());
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<StatefulWidget> createState() => _AppState();
}

class _AppState extends State<App> {
  final FirebaseAuthentication _firebaseAuthentication = FirebaseAuthentication();

  @override
  void initState() {
    super.initState();
    _firebaseAuthentication.signInAnonymously();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      home: const GenericList(),
    );
  }
}
