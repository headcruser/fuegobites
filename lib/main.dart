import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fuego_bites/common/show_model.dart';
import 'package:fuego_bites/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fuego Bites',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        title: ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.red.shade200,
            radius: 25,
            child: Image.asset(
              'assets/fuego_bites_logo.png', 
              fit: BoxFit.cover
            ),
            
          ),
          title: Text("Fuego Bites",style: TextStyle(fontSize: 12, color: Colors.grey.shade400)),
          subtitle: const Text("Daniel Martinez",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Pedidos"),
                      Text("11/Agosto/2023"),
                    ],
                  ),

                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xffd5e8fa),
                      foregroundColor: Colors.blue.shade800,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)
                      )
                    ),
                    onPressed: (){
                      showModalBottomSheet(
                        context: context, 
                        isScrollControlled: true,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)
                        ),
                        builder: (context) => const NewOrderModel()
                      );
                    }, 
                    child: const Text("Nuevo pedido")
                  )
                ],
              ),
            ]
          ),
        ),
        
      ),
    );
  }
}