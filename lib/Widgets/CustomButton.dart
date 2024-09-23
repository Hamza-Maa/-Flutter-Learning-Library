// custom_button.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final IconData icon;

  const CustomButton({
    super.key,
    required this.label,
    required this.onPressed,
    required this.icon,
    required BuildContext context,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      elevation: 4,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        splashColor: Colors.deepPurpleAccent.withOpacity(0.2),
        onTap: onPressed,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 40, color: Colors.deepPurpleAccent),
              const SizedBox(height: 10),
              Text(
                label,
                textAlign: TextAlign.center,
                style: GoogleFonts.lato(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
