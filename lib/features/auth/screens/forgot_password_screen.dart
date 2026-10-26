import 'package:flutter/material.dart';

import '../../../shared/widgets/app_widgets.dart';
import 'login_screen.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _username = TextEditingController();

  @override
  void dispose() {
    _username.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => AuthLayout(
    backButton: true,
    heading: 'Forgot password?',
    subheading:
        'Enter your username to get help recovering access to your account.',
    footer: authLink(
      'Remember your password?  ',
      'Sign in',
      () => Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute<void>(builder: (_) => const LoginScreen()),
        (route) => false,
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
              textInputAction: TextInputAction.done,
              validator: (value) => value == null || value.trim().isEmpty
                  ? 'Enter your username.'
                  : null,
            ),
            const SizedBox(height: 20),
            AppButton(
              label: 'Continue',
              onPressed: () {
                FocusManager.instance.primaryFocus?.unfocus();
                if (_formKey.currentState!.validate()) {
                  showPrototypeNotice(
                    context,
                    'Password recovery is not available yet.',
                  );
                }
              },
            ),
          ],
        ),
      ),
    ],
  );
}
