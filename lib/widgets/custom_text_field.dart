import 'package:flutter/material.dart';

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
    final theme = Theme.of(context);
    final primaryColor = theme.colorScheme.primary;
    final grayText = theme.textTheme.bodyMedium?.color ?? Colors.grey;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          label,
          style: TextStyle(
              fontSize: 13, fontWeight: FontWeight.w600, color: primaryColor),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          obscureText: obscure,
          keyboardType: keyboardType,
          style: TextStyle(fontSize: 15, color: primaryColor),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(color: grayText, fontSize: 14),
            prefixIcon: Icon(icon, color: grayText, size: 20),
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
    final grayText =
        Theme.of(context).textTheme.bodyMedium?.color ?? Colors.grey;

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
          color: grayText,
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
