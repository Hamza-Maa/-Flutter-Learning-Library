import 'package:flutter/material.dart';

class ScreenEx2 extends StatefulWidget {
  const ScreenEx2({super.key});

  @override
  State<ScreenEx2> createState() => _ScreenEx2State();
}

class _ScreenEx2State extends State<ScreenEx2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(20), // Adding padding for better layout
        children: [
          const SizedBox(height: 20),
          const Center(
            child: CircleAvatar(
              radius: 80,
              backgroundImage: AssetImage('assets/images/profile.png'),
            ),
          ),
          const SizedBox(height: 20),
          const Center(
            child: Text(
              'John Doe',
              style: TextStyle(
                  fontSize: 24, fontWeight: FontWeight.bold), // Added styling
            ),
          ),
          const SizedBox(height: 10),
          const Center(
            child: Text(
              'Software Engineer',
              style:
                  TextStyle(fontSize: 18, color: Colors.grey), // Added styling
            ),
          ),
          const SizedBox(height: 20),
          // Add the GridView within a SizedBox to give it a fixed height
          SizedBox(
            height: 300, // Specify a fixed height
            child: GridView.count(
              crossAxisCount: 2, // Two containers in each row
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              children: List.generate(6, (index) {
                return CustomRectangleContainer(
                  text: 'Container ${index + 1}',
                  color: Colors.blueAccent,
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}

// Custom widget
class CustomRectangleContainer extends StatelessWidget {
  final String text; // Optional: To display some text inside the container
  final Color color;

  const CustomRectangleContainer({
    super.key,
    required this.text,
    this.color = Colors.blue,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150, // Set the width of the rectangle
      height: 80, // Set the height of the rectangle
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
      ),
      alignment: Alignment.center,
      child: Text(
        text,
        style: const TextStyle(color: Color.fromARGB(255, 88, 193, 246)),
      ),
    );
  }
}
