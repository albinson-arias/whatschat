import 'package:flutter/material.dart';
import 'package:phone_form_field/phone_form_field.dart';
import 'package:whatschat/src/core/colors.dart';

class PhoneFieldView extends StatelessWidget {
  const PhoneFieldView({
    required this.inputKey,
    required this.controller,
    super.key,
  });
  final Key inputKey;
  final PhoneController controller;

  PhoneNumberInputValidator? _getValidator() {
    final validators = <PhoneNumberInputValidator>[
      PhoneValidator.validMobile(),
    ];
    return PhoneValidator.compose(validators);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 2,
      borderRadius: BorderRadius.circular(12),
      child: AutofillGroup(
        child: PhoneFormField(
          key: inputKey,
          controller: controller,
          autofocus: true,
          countrySelectorNavigator:
              const CountrySelectorNavigator.draggableBottomSheet(),
          autofillHints: const [AutofillHints.telephoneNumber],
          flagSize: 24,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ),
          decoration: const InputDecoration(
            fillColor: Colors.white,
            filled: true,
            isCollapsed: true,
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent),
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent),
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent),
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
          ),
          validator: _getValidator(),
          cursorColor: AppColors.primary,
        ),
      ),
    );
  }
}
