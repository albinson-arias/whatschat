import 'package:flutter/material.dart';
import 'package:phone_form_field/phone_form_field.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whatschat/src/common/widgets/app_button.dart';
import 'package:whatschat/src/core/colors.dart';
import 'package:whatschat/src/features/home/presentation/widgets/phone_field.dart';
import 'package:whatschat/src/l10n/l10n.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  late final PhoneController controller;
  final formKey = GlobalKey<FormState>();
  final phoneKey = GlobalKey<FormFieldState<PhoneNumber>>();
  bool isValid = false;
  bool isBusy = false;

  void validate() {
    if (formKey.currentState!.validate() &&
        phoneKey.currentState!.validate() &&
        controller.value != null &&
        controller.value!.nsn.length > 1) {
      setState(() {
        isValid = true;
      });
    } else {
      setState(() {
        isValid = false;
      });
    }
  }

  @override
  void initState() {
    controller = PhoneController(null);
    controller.addListener(() async {
      setState(() {
        isBusy = true;
      });
      await Future<void>.delayed(const Duration(milliseconds: 200));
      validate();
      setState(() {
        isBusy = false;
      });
    });
    super.initState();
  }

  Future<void> onSubmit() async {
    // Check if the form is valid and not busy
    if (isValid && !isBusy) {
      // Set the busy state
      setState(() {
        isBusy = true;
      });

      // Get the url to open WhatsApp
      final url = Uri.parse(
        'https://wa.me/${controller.value?.international.substring(1)}?text=${context.l10n.hello}',
      );

      // Check if the url can be launched
      if (!await canLaunchUrl(url)) {
        if (mounted) {
          // Show a snackbar if the url can't be launched
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(context.l10n.cantOpenWhatsApp),
            ),
          );
        }
        setState(() {
          isBusy = false;
        });
        return;
      }

      // Launch the url
      await launchUrl(url, mode: LaunchMode.externalApplication);

      // Set the busy state
      setState(() {
        isBusy = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // const SizedBox(height: 32),
            const Spacer(
              flex: 2,
            ),
            Center(
              child: Image.asset(
                'assets/logo.png',
                height: 125,
              ),
            ),
            // const SizedBox(height: 32),
            const Spacer(
              flex: 2,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 4),
              child: Text(
                context.l10n.whatsappNumber,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Form(
                key: formKey,
                child: PhoneFieldView(
                  inputKey: phoneKey,
                  controller: controller,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 6),
              child: Text(
                context.l10n.aChatWithThisNumber,
                style: TextStyle(
                  fontSize: 12,
                  color: AppColors.secondaryText,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
              child: Center(
                child: SizedBox(
                  height: 52,
                  width: double.maxFinite,
                  child: AppButton(
                    onPressed: !isValid ? null : onSubmit,
                    text: context.l10n.goToChat,
                  ),
                ),
              ),
            ),
            const Spacer(
              flex: 6,
            ),
          ],
        ),
      ),
    );
  }
}
