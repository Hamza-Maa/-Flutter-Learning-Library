import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_improve/Exercices/Screen_Ex1.dart';
import 'package:project_improve/Exercices/Screen_Ex7.dart';
import 'package:project_improve/Exercices/Shopping_Cart/model/product_model.dart';
import 'package:project_improve/Exercices/Shopping_Cart/pages/prdocuts_list_screen.dart';
import 'package:project_improve/Exercices/to-do_list_With%20Riverpod/page/to_do_Screen.dart';
import 'package:project_improve/Exercices/to-do_list_Without%20state%20managment/page/to_do_Screen.dart';
import 'package:project_improve/Exercices/Screen_Ex2.dart';
import 'package:project_improve/Exercices/Screen_Ex3.dart';
import 'package:project_improve/Exercices/Screen_Ex4.dart';
import 'package:project_improve/Widgets/CustomButton.dart';
import 'Exercices/Weather  App/pages/weather_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.product});
  final Product product;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F4F8), // Light background color
      appBar: AppBar(
        title: Text(
          'Welcome to Flutter Library',
          style: GoogleFonts.lato(fontSize: 22, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        backgroundColor: Colors.deepPurpleAccent, // Custom app bar color
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
        child: Column(
          children: [
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                children: [
                  // EX1 Button
                  CustomButton(
                    context: context,
                    label: "Login Screen",
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginScreen()),
                      );
                    },
                    icon: Icons.login,
                  ),
                  // EX2 Button
                  CustomButton(
                    context: context,
                    label: "Profil Screen",
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ScreenEx2()),
                      );
                    },
                    icon: Icons.layers,
                  ),
                  // EX3 Button
                  CustomButton(
                    context: context,
                    label: "Grid Layout",
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProductGridScreen()),
                      );
                    },
                    icon: Icons.grid_view,
                  ),
                  // EX4 Button
                  CustomButton(
                    context: context,
                    label: "Counter App With Riverpod",
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const CounterExScreen()),
                      );
                    },
                    icon: Icons.countertops,
                  ),
                  // EX5 without Riverpod
                  CustomButton(
                    context: context,
                    label: "To Do App",
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const Todo()),
                      );
                    },
                    icon: Icons.task_alt,
                  ),
                  // EX5 with Riverpod
                  CustomButton(
                    context: context,
                    label: "To Do App With Riverpod",
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => TodoWithRiverpod()),
                      );
                    },
                    icon: Icons.task_alt,
                  ),
                  // EX6 Shopping Cart
                  CustomButton(
                    context: context,
                    label: "Shopping Cart",
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ProductListScreen()),
                      );
                    },
                    icon: Icons.shopping_cart,
                  ),
                  // EX7 API Data Fetch
                  CustomButton(
                    context: context,
                    label: "Simple Api Fetch",
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const fetchData()),
                      );
                    },
                    icon: Icons.api,
                  ),
                  // EX8 Weather App
                  CustomButton(
                    context: context,
                    label: "Weather App",
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const WeatherPage()),
                      );
                    },
                    icon: Icons.wb_sunny,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
