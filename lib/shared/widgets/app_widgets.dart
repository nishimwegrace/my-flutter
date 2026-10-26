import 'package:flutter/material.dart';

import '../../core/theme/app_theme.dart';

const companyName = 'Kaze';

class AppLogo extends StatelessWidget {
  const AppLogo({super.key, this.compact = false});
  final bool compact;

  @override
  Widget build(BuildContext context) => Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Container(
        width: compact ? 42 : 48,
        height: compact ? 42 : 48,
        decoration: BoxDecoration(
          color: AppColors.navy,
          borderRadius: BorderRadius.circular(14),
        ),
        child: const Icon(Icons.air_rounded, color: AppColors.cream, size: 27),
      ),
      const SizedBox(width: 12),
      Text(
        companyName,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: AppColors.navy,
          letterSpacing: .2,
        ),
      ),
    ],
  );
}

class AppTextField extends StatelessWidget {
  const AppTextField({
    super.key,
    required this.label,
    required this.hint,
    required this.icon,
    this.controller,
    this.keyboardType,
    this.validator,
    this.textInputAction,
    this.onFieldSubmitted,
  });
  final String label;
  final String hint;
  final IconData icon;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final TextInputAction? textInputAction;
  final void Function(String)? onFieldSubmitted;

  @override
  Widget build(BuildContext context) => _FieldFrame(
    label: label,
    child: TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      validator: validator,
      onFieldSubmitted: onFieldSubmitted,
      autocorrect: false,
      style: const TextStyle(fontSize: 14, color: AppColors.navy),
      decoration: InputDecoration(
        hintText: hint,
        prefixIcon: Icon(icon, size: 20),
      ),
    ),
  );
}

class AppPasswordField extends StatefulWidget {
  const AppPasswordField({
    super.key,
    required this.label,
    required this.hint,
    this.controller,
    this.validator,
    this.textInputAction,
  });
  final String label;
  final String hint;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final TextInputAction? textInputAction;

  @override
  State<AppPasswordField> createState() => _AppPasswordFieldState();
}

class _AppPasswordFieldState extends State<AppPasswordField> {
  bool _obscure = true;

  @override
  Widget build(BuildContext context) => _FieldFrame(
    label: widget.label,
    child: TextFormField(
      controller: widget.controller,
      obscureText: _obscure,
      validator: widget.validator,
      textInputAction: widget.textInputAction,
      autocorrect: false,
      enableSuggestions: false,
      style: const TextStyle(fontSize: 14, color: AppColors.navy),
      decoration: InputDecoration(
        hintText: widget.hint,
        prefixIcon: const Icon(Icons.lock_outline_rounded, size: 20),
        suffixIcon: IconButton(
          tooltip: _obscure ? 'Show password' : 'Hide password',
          onPressed: () => setState(() => _obscure = !_obscure),
          icon: Icon(
            _obscure
                ? Icons.visibility_outlined
                : Icons.visibility_off_outlined,
            size: 20,
          ),
        ),
      ),
    ),
  );
}

class _FieldFrame extends StatelessWidget {
  const _FieldFrame({required this.label, required this.child});
  final String label;
  final Widget child;

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.only(bottom: 7),
        child: Text(
          label,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: AppColors.navy,
          ),
        ),
      ),
      child,
    ],
  );
}

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.enabled = true,
  });
  final String label;
  final VoidCallback? onPressed;
  final bool enabled;

  @override
  Widget build(BuildContext context) => SizedBox(
    width: double.infinity,
    child: FilledButton(
      onPressed: enabled ? onPressed : null,
      child: Text(label),
    ),
  );
}

class TermsAcceptance extends StatelessWidget {
  const TermsAcceptance({
    super.key,
    required this.value,
    required this.onChanged,
    required this.showError,
    required this.onOpen,
  });
  final bool value;
  final ValueChanged<bool?> onChanged;
  final bool showError;
  final ValueChanged<String> onOpen;

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 30,
            height: 28,
            child: Checkbox(
              value: value,
              onChanged: onChanged,
              visualDensity: VisualDensity.compact,
            ),
          ),
          const SizedBox(width: 5),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  const Text(
                    'I agree to the ',
                    style: TextStyle(
                      fontSize: 12.5,
                      height: 1.5,
                      color: AppColors.navy,
                    ),
                  ),
                  _link(
                    'Terms and Conditions',
                    () => onOpen('Terms and Conditions'),
                  ),
                  const Text(
                    ' and ',
                    style: TextStyle(
                      fontSize: 12.5,
                      height: 1.5,
                      color: AppColors.navy,
                    ),
                  ),
                  _link('Privacy Policy', () => onOpen('Privacy Policy')),
                  const Text(
                    '.',
                    style: TextStyle(
                      fontSize: 12.5,
                      height: 1.5,
                      color: AppColors.navy,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      if (showError)
        const Padding(
          padding: EdgeInsets.only(left: 35, top: 2),
          child: Text(
            'Please accept the terms to continue.',
            style: TextStyle(color: AppColors.error, fontSize: 12),
          ),
        ),
    ],
  );

  Widget _link(String label, VoidCallback onTap) => GestureDetector(
    onTap: onTap,
    child: Text(
      label,
      style: const TextStyle(
        fontSize: 12.5,
        height: 1.5,
        color: AppColors.brown,
        fontWeight: FontWeight.w600,
        decoration: TextDecoration.underline,
      ),
    ),
  );
}

class AuthLayout extends StatelessWidget {
  const AuthLayout({
    super.key,
    required this.heading,
    required this.subheading,
    required this.children,
    this.footer,
    this.backButton = false,
  });
  final String heading;
  final String subheading;
  final List<Widget> children;
  final Widget? footer;
  final bool backButton;

  @override
  Widget build(BuildContext context) {
    final inset = MediaQuery.viewInsetsOf(context).bottom;
    return Scaffold(
      appBar: backButton
          ? AppBar(leading: const BackButton(), toolbarHeight: 48)
          : null,
      body: SafeArea(
        child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: LayoutBuilder(
            builder: (context, constraints) => SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(
                24,
                backButton ? 4 : 24,
                24,
                22 + inset,
              ),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: (constraints.maxHeight - (backButton ? 52 : 0))
                      .clamp(0, double.infinity),
                ),
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 420),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Center(child: AppLogo()),
                        const SizedBox(height: 30),
                        Text(
                          heading,
                          style: const TextStyle(
                            fontSize: 27,
                            height: 1.15,
                            letterSpacing: -.5,
                            fontWeight: FontWeight.w700,
                            color: AppColors.navy,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          subheading,
                          style: const TextStyle(
                            fontSize: 14,
                            height: 1.5,
                            color: AppColors.muted,
                          ),
                        ),
                        const SizedBox(height: 24),
                        Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: const Color(0xFFECE9E3)),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: children,
                          ),
                        ),
                        if (footer != null) ...[
                          const SizedBox(height: 22),
                          Center(child: footer!),
                        ],
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Widget authLink(String leading, String link, VoidCallback onTap) => Wrap(
  alignment: WrapAlignment.center,
  crossAxisAlignment: WrapCrossAlignment.center,
  children: [
    Text(leading, style: const TextStyle(fontSize: 13, color: AppColors.muted)),
    GestureDetector(
      onTap: onTap,
      child: Text(
        link,
        style: const TextStyle(
          fontSize: 13,
          color: AppColors.brown,
          fontWeight: FontWeight.w700,
        ),
      ),
    ),
  ],
);

void showPrototypeNotice(BuildContext context, String message) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
        backgroundColor: AppColors.navy,
      ),
    );
}
