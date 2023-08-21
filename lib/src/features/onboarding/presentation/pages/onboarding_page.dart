import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:whatschat/src/common/widgets/app_button.dart';
import 'package:whatschat/src/features/onboarding/bloc/onboarding_page_cubit.dart';
import 'package:whatschat/src/l10n/l10n.dart';
import 'package:whatschat/src/navigation/routes.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  void _onGetStartedPressed(BuildContext context) {
    context.read<OnboardingPageCubit>().onOnboardingCompleted();
    context.pushReplacementNamed(Routes.home.name);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: SvgPicture.asset('assets/onboarding_image.svg'),
                ),
                const SizedBox(height: 16),
                Text(
                  context.l10n.onboardingText,
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 32,
            left: 32,
            right: 32,
            child: AppButton(
              text: context.l10n.getStarted,
              onPressed: () => _onGetStartedPressed(context),
            ),
          )
        ],
      ),
    );
  }
}
