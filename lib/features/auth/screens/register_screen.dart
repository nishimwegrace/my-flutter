import 'package:flutter/material.dart';

import '../../../shared/widgets/app_widgets.dart';
import 'legal_screen.dart';
import 'login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _username = TextEditingController();
  final _password = TextEditingController();
  final _confirm = TextEditingController();
  bool _accepted = false;
  bool _showTermsError = false;

  @override
  void dispose() {
    _name.dispose();
    _username.dispose();
    _password.dispose();
    _confirm.dispose();
    super.dispose();
  }

  void _submit() {
    FocusManager.instance.primaryFocus?.unfocus();
    final valid = _formKey.currentState!.validate();
    setState(() => _showTermsError = !_accepted);
    if (valid && _accepted) {
      showPrototypeNotice(context, 'Account creation is not available yet.');
    }
  }

  void _openLegal(String title) => Navigator.push(
    context,
    MaterialPageRoute<void>(builder: (_) => LegalScreen(title: title)),
  );

  @override
  Widget build(BuildContext context) => AuthLayout(
    backButton: true,
    heading: 'Create an account',
    subheading: 'A few details and you’ll be ready to get started.',
    footer: authLink(
      'Already have an account?  ',
      'Sign in',
      () => Navigator.pushReplacement(
        context,
        MaterialPageRoute<void>(builder: (_) => const LoginScreen()),
      ),
    ),
    children: [
      Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppTextField(
              label: 'Full name',
              hint: 'Enter your full name',
              icon: Icons.person_outline_rounded,
              controller: _name,
              textInputAction: TextInputAction.next,
              validator: (value) => value == null || value.trim().isEmpty
                  ? 'Enter your full name.'
                  : null,
            ),
            const SizedBox(height: 16),
            AppTextField(
              label: 'Username',
              hint: 'Choose a username',
              icon: Icons.account_circle_outlined,
              controller: _username,
              textInputAction: TextInputAction.next,
              validator: (value) => value == null || value.trim().isEmpty
                  ? 'Choose a username.'
                  : null,
            ),
            const SizedBox(height: 16),
            AppPasswordField(
              label: 'Password',
              hint: 'Create a password',
              controller: _password,
              textInputAction: TextInputAction.next,
              validator: (value) => value == null || value.isEmpty
                  ? 'Create a password.'
                  : value.length < 8
                  ? 'Use at least 8 characters.'
                  : null,
            ),
            const SizedBox(height: 16),
            AppPasswordField(
              label: 'Confirm password',
              hint: 'Confirm your password',
              controller: _confirm,
              textInputAction: TextInputAction.done,
              validator: (value) => value == null || value.isEmpty
                  ? 'Confirm your password.'
                  : value != _password.text
                  ? 'Passwords do not match.'
                  : null,
            ),
            const SizedBox(height: 12),
            TermsAcceptance(
              value: _accepted,
              onChanged: (value) => setState(() {
                _accepted = value ?? false;
                if (_accepted) _showTermsError = false;
              }),
              showError: _showTermsError,
              onOpen: _openLegal,
            ),
            const SizedBox(height: 14),
            AppButton(label: 'Create account', onPressed: _submit),
          ],
        ),
      ),
    ],
  );
}
