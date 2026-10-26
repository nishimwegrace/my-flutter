import 'package:flutter/material.dart';

import '../../../core/theme/app_theme.dart';
import '../../../shared/widgets/app_widgets.dart';
import 'forgot_password_screen.dart';
import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _username = TextEditingController();
  final _password = TextEditingController();

  @override
  void dispose() {
    _username.dispose();
    _password.dispose();
    super.dispose();
  }

  void _submit() {
    FocusManager.instance.primaryFocus?.unfocus();
    if (_formKey.currentState!.validate()) {
      showPrototypeNotice(context, 'Sign in is not available yet.');
    }
  }

  @override
  Widget build(BuildContext context) => AuthLayout(
    heading: 'Welcome back',
    subheading: 'Sign in to continue to your Kaze account.',
    footer: authLink(
      'New to Kaze?  ',
      'Create an account',
      () => Navigator.push(
        context,
        MaterialPageRoute<void>(builder: (_) => const RegisterScreen()),
      ),
    ),
    children: [
      Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppTextField(
              label: 'Username',
              hint: 'Enter your username',
              icon: Icons.person_outline_rounded,
              controller: _username,
              textInputAction: TextInputAction.next,
              validator: (value) => value == null || value.trim().isEmpty
                  ? 'Enter your username.'
                  : null,
            ),
            const SizedBox(height: 18),
            AppPasswordField(
              label: 'Password',
              hint: 'Enter your password',
              controller: _password,
              textInputAction: TextInputAction.done,
              validator: (value) => value == null || value.isEmpty
                  ? 'Enter your password.'
                  : null,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (_) => const ForgotPasswordScreen(),
                  ),
                ),
                style: TextButton.styleFrom(
                  foregroundColor: AppColors.brown,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 2,
                    vertical: 10,
                  ),
                ),
                child: const Text(
                  'Forgot password?',
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                ),
              ),
            ),
            AppButton(label: 'Sign in', onPressed: _submit),
          ],
        ),
      ),
    ],
  );
}
