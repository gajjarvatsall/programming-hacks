import 'dart:ui';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:programming_hacks/app_theme/constant.dart';
import 'package:programming_hacks/app_theme/text_theme.dart';
import 'package:programming_hacks/modules/auth/bloc/auth_bloc.dart';
import 'package:programming_hacks/modules/auth/bloc/auth_state.dart';
import 'package:programming_hacks/widgets/custom_button.dart';
import 'package:programming_hacks/widgets/custom_textfield.dart';
import 'package:programming_hacks/widgets/glassmorphic_container.dart';
import 'package:programming_hacks/widgets/rounded_blur_container.dart';
import 'package:programming_hacks/widgets/snackbar.dart';
import 'package:programming_hacks/widgets/square_tile.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // text editing controllers
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  //form key
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: BlocConsumer<AuthUserBloc, AuthUserState>(
        listener: (context, state) {
          if (state is UserLoginLoadedState) {
            showSnackBar(
              context,
              'Successfully logged in',
              null,
              ContentType.success,
            );
            Navigator.pushNamedAndRemoveUntil(context, '/homeScreen', (route) => false);
          }
          if (state is UserLoginErrorState) {
            showSnackBar(
              context,
              state.errorMsg,
            );
          }
        },
        builder: (context, state) {
          return Form(
            key: formKey,
            autovalidateMode: AutovalidateMode.disabled,
            child: Stack(
              children: [
                RoundedBlurContainer(
                  right: 30,
                  top: 50,
                  color: Colors.greenAccent.withOpacity(0.4),
                ),
                RoundedBlurContainer(
                  left: -100,
                  bottom: 300,
                  color: Colors.pinkAccent.withOpacity(0.4),
                ),
                RoundedBlurContainer(
                  right: -100,
                  bottom: -50,
                  color: Colors.greenAccent.withOpacity(0.4),
                ),
                BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 70, sigmaY: 70),
                  child: Center(
                    child: ListView(
                      shrinkWrap: true,
                      children: [
                        SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: hPadding),
                            child: GlassMorphismContainer(
                              width: 400,
                              height: 550,
                              blur: 5,
                              child: ListView(
                                shrinkWrap: true,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: hPadding,
                                  vertical: sSizedBoxHeight,
                                ),
                                children: [
                                  // const SizedBox(height: largeSizedBoxHeight),

                                  // logo
                                  const Icon(
                                    Icons.lock,
                                    color: Colors.white,
                                    size: 100,
                                  )
                                      .animate()
                                      .fadeIn(duration: 1000.ms, curve: Curves.easeOutCirc)
                                      .slideY(begin: 0.5, end: 0),

                                  const SizedBox(height: mSizedBoxHeight),

                                  // welcome back, you've been missed!
                                  Center(
                                    child: Text(
                                      'Login',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 26,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                  )
                                      .animate()
                                      .fadeIn(duration: 1000.ms, curve: Curves.easeOutCirc)
                                      .slideY(begin: 0.5, end: 0),

                                  const SizedBox(height: mSizedBoxHeight),

                                  // username textfield
                                  CustomTextField(
                                    controller: emailController,
                                    hintText: 'Email',
                                    textInputAction: TextInputAction.next,
                                    textInputType: TextInputType.emailAddress,
                                    validator: FormBuilderValidators.compose(
                                      [
                                        /// Makes this field required
                                        FormBuilderValidators.required(
                                            errorText: 'Email is required'),
                                        FormBuilderValidators.email(
                                            errorText: 'Please Provide a Valid Email ID'),
                                      ],
                                    ),
                                  )
                                      .animate()
                                      .fadeIn(
                                        duration: 1000.ms,
                                        curve: Curves.easeOutCirc,
                                        delay: 500.ms,
                                      )
                                      .slideY(begin: 0.5, end: 0),

                                  const SizedBox(height: sSizedBoxHeight),

                                  // password Textfield
                                  CustomTextField(
                                    controller: passwordController,
                                    hintText: 'Password',
                                    obscureText: true,
                                    textInputAction: TextInputAction.done,
                                    textInputType: TextInputType.visiblePassword,
                                    validator: FormBuilderValidators.compose([
                                      /// Makes this field required
                                      FormBuilderValidators.required(
                                        errorText: 'Password is required',
                                      ),
                                    ]),
                                  )
                                      .animate()
                                      .fadeIn(
                                          duration: 1000.ms,
                                          curve: Curves.easeOutCirc,
                                          delay: 600.ms)
                                      .slideY(begin: 0.5, end: 0),

                                  const SizedBox(height: sSizedBoxHeight),
                                  const SizedBox(height: mSizedBoxHeight),

                                  CustomButton(
                                    onTap: () {
                                      if (formKey.currentState!.validate()) {
                                        BlocProvider.of<AuthUserBloc>(context).add(
                                          UserLoginEvent(
                                            email: emailController.text,
                                            password: passwordController.text,
                                          ),
                                        );
                                      }
                                    },
                                    text: 'Login',
                                    isLoading: (state is UserLoginLoadingState) ? true : false,
                                  )
                                      .animate()
                                      .scaleX(
                                        begin: 0.5,
                                        end: 1,
                                        curve: Curves.elasticInOut,
                                        duration: 1000.ms,
                                      )
                                      .then(delay: 100.ms)
                                      .shimmer(
                                        duration: 1000.ms,
                                        angle: 45,
                                        curve: Curves.easeOutQuad,
                                      )
                                      .then(delay: 150.ms)
                                      .shimmer(
                                        duration: 1000.ms,
                                        angle: 45,
                                        curve: Curves.easeOutQuad,
                                      ),

                                  const SizedBox(height: lSizedBoxHeight),

                                  // not a member? register now
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Not a member?',
                                        style: TextStyle(color: Colors.grey[300]),
                                      ),
                                      const SizedBox(width: 4),
                                      GestureDetector(
                                        behavior: HitTestBehavior.opaque,
                                        onTap: () {
                                          Navigator.pushNamed(context, '/signupScreen');
                                        },
                                        child: Text('Register now',
                                            style: CustomTextTheme.textButtonText),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: sSizedBoxHeight,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: mSizedBoxHeight,
                        ),
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Text(
                              'Or continue with',
                              style: TextStyle(color: Colors.grey[200]),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: mSizedBoxHeight,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // google button
                            GestureDetector(
                                onTap: () {
                                  BlocProvider.of<AuthUserBloc>(context)
                                      .add(OAuth2SessionEvent(provider: 'google'));
                                },
                                child: SquareTile(imagePath: 'assets/images/google.png')),

                            SizedBox(width: 25),

                            // apple button
                            GestureDetector(
                                onTap: () {
                                  BlocProvider.of<AuthUserBloc>(context)
                                      .add(OAuth2SessionEvent(provider: 'apple'));
                                },
                                child: SquareTile(imagePath: 'assets/images/apple.png'))
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
