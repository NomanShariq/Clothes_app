import 'package:flutter/material.dart';
import 'package:clothing_app/theme/app_colors.dart';
import 'package:clothing_app/theme/app_text_styles.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final String hint;
  final IconData icon;
  final bool obscure;
  final Widget? suffixIcon;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;

  const CustomTextField({
    Key? key,
    required this.label,
    required this.hint,
    required this.icon,
    this.obscure = false,
    this.suffixIcon,
    this.controller,
    this.validator,
    this.keyboardType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(label, style: AppTextStyles.label),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          obscureText: obscure,
          keyboardType: keyboardType,
          style: const TextStyle(fontSize: 15),
          // decoration ka filled/fillColor/border sab
          // AppTheme.lightTheme -> inputDecorationTheme se automatically aa jayega
          decoration: InputDecoration(
            hintText: hint,
            prefixIcon: Icon(icon, color: AppColors.bodyText, size: 20),
            suffixIcon: suffixIcon,
          ),
          validator: validator ??
              (value) {
                if (value == null || value.isEmpty) {
                  return "*Required";
                }
                return null;
              },
        ),
      ],
    );
  }
}

class PasswordField extends StatefulWidget {
  final String label;
  final String hint;
  final TextEditingController? controller;
  final String? Function(String?)? validator;

  const PasswordField({
    Key? key,
    this.label = "Password",
    this.hint = "Enter password",
    this.controller,
    this.validator,
  }) : super(key: key);

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      label: widget.label,
      hint: widget.hint,
      icon: Icons.lock_outline,
      obscure: obscurePassword,
      controller: widget.controller,
      validator: widget.validator,
      suffixIcon: IconButton(
        icon: Icon(
          obscurePassword
              ? Icons.visibility_off_outlined
              : Icons.visibility_outlined,
          color: AppColors.bodyText,
          size: 20,
        ),
        onPressed: () {
          setState(() {
            obscurePassword = !obscurePassword;
          });
        },
      ),
    );
  }
}
