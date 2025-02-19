import 'package:flutter/material.dart';

class AuthTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hint;
  final IconData prefixIcon;
  final TextInputType? keyboardType;
  final bool obscureText;
  final String? Function(String?)? validator;
  final List<String> autofillHints;
  final TextInputAction textInputAction;
  final VoidCallback? onSubmitted;
  final Widget? suffixIcon;

  const AuthTextField(
      {super.key,
      required this.controller,
      required this.label,
      required this.hint,
      required this.prefixIcon,
      this.keyboardType,
      this.obscureText = false,
      this.validator,
      this.autofillHints = const [],
      this.textInputAction = TextInputAction.next,
      this.onSubmitted,
      this.suffixIcon});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      validator: validator,
      autofillHints: autofillHints,
      textInputAction: textInputAction,
      onFieldSubmitted: (_) => onSubmitted?.call(),
      decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(prefixIcon),
          border: const OutlineInputBorder(),
          hintText: hint,
          suffixIcon: suffixIcon),
    );
  }
}

class PasswordField extends StatefulWidget {
  final TextEditingController controller;
  final VoidCallback? onSubmitted;

  const PasswordField({
    super.key,
    required this.controller,
    this.onSubmitted,
  });

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return AuthTextField(
      controller: widget.controller,
      label: 'Password',
      hint: 'At least 8 characters',
      prefixIcon: Icons.lock_outline,
      obscureText: _obscureText,
      validator: _passwordValidator,
      autofillHints: const [AutofillHints.password],
      textInputAction: TextInputAction.done,
      onSubmitted: widget.onSubmitted,
      suffixIcon: IconButton(
        icon: Icon(_obscureText ? Icons.visibility_off : Icons.visibility),
        onPressed: () => setState(() => _obscureText = !_obscureText),
      ),
    );
  }

  String? _passwordValidator(String? value) {
    if (value == null || value.isEmpty) return 'Password required';
    if (value.length < 8) return 'Minimum 8 characters';
    if (!RegExp(r'[A-Z]').hasMatch(value)) return 'Include uppercase letter';
    if (!RegExp(r'[a-z]').hasMatch(value)) return 'Include lowercase letter';
    if (!RegExp(r'[0-9]').hasMatch(value)) return 'Include number';
    return null;
  }
}
