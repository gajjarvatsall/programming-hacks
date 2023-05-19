import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:lottie/lottie.dart';
import 'package:particles_flutter/particles_flutter.dart';
import 'package:programming_hacks/app_theme/constant.dart';
import 'package:programming_hacks/app_theme/text_theme.dart';
import 'package:programming_hacks/modules/auth/bloc/auth_bloc.dart';
import 'package:programming_hacks/modules/auth/bloc/auth_state.dart';
import 'package:programming_hacks/widgets/circular_pacticles.dart';
import 'package:programming_hacks/widgets/custom_button.dart';
import 'package:programming_hacks/widgets/custom_textfield.dart';
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
      backgroundColor: Colors.blueGrey[300],
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
                const CustomCircularParticle(),
                Center(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: hPadding),
                      child: GlassmorphicContainer(
                        width: 400,
                        height: 550,
                        borderRadius: 20,
                        blur: 10,
                        alignment: Alignment.bottomCenter,
                        linearGradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            const Color(0xFFffffff).withOpacity(0.3),
                            const Color(0xFFFFFFFF).withOpacity(0.10),
                          ],
                          stops: const [
                            0.1,
                            1,
                          ],
                        ),
                        borderGradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            const Color(0xFFffffff).withOpacity(0.3),
                            const Color((0xFFFFFFFF)).withOpacity(0.05),
                          ],
                        ),
                        border: 0,
                        child: ListView(
                          shrinkWrap: true,
                          padding: const EdgeInsets.symmetric(horizontal: hPadding),
                          children: [
                            // const SizedBox(height: largeSizedBoxHeight),

                            // logo
                            const Icon(
                              Icons.lock,
                              size: 100,
                            ).animate().fadeIn(duration: 1000.ms, curve: Curves.easeOutCirc).slideY(begin: 0.5, end: 0),
                            //
                            // Lottie.asset(
                            //   'assets/lottie/login.json',
                            //   width: 100,
                            //   height: 100,
                            //   fit: BoxFit.fill,
                            // ),

                            const SizedBox(height: lSizedBoxHeight),

                            // welcome back, you've been missed!
                            Center(
                              child: Text(
                                'Welcome back you\'ve been missed!',
                                style: TextStyle(
                                  color: Colors.grey[700],
                                  fontSize: 16,
                                ),
                              ),
                            ).animate().fadeIn(duration: 1000.ms, curve: Curves.easeOutCirc).slideY(begin: 0.5, end: 0),

                            const SizedBox(height: mSizedBoxHeight),

                            // username textfield
                            CustomTextField(
                              controller: emailController,
                              hintText: 'Email',
                              textInputAction: TextInputAction.next,
                              textInputType: TextInputType.emailAddress,
                              validator: FormBuilderValidators.compose([
                                /// Makes this field required
                                FormBuilderValidators.required(errorText: 'Email is required'),
                                FormBuilderValidators.email(errorText: 'Please Provide a Valid Email ID'),
                              ]),
                            )
                                .animate()
                                .fadeIn(
                                  duration: 1000.ms,
                                  curve: Curves.easeOutCirc,
                                  delay: 500.ms,
                                )
                                .slideY(begin: 0.5, end: 0),

                            const SizedBox(height: sSizedBoxHeight),

                            // password textfield
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
                                .fadeIn(duration: 1000.ms, curve: Curves.easeOutCirc, delay: 600.ms)
                                .slideY(begin: 0.5, end: 0),

                            const SizedBox(height: sSizedBoxHeight),

                            // forgot password?
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  'Forgot Password?',
                                  style: TextStyle(color: Colors.grey[600]),
                                )
                                    .animate()
                                    .fadeIn(duration: 1000.ms, curve: Curves.easeOutCirc, delay: 700.ms)
                                    .slideY(begin: 0.5, end: 0),
                              ],
                            ),

                            const SizedBox(height: mSizedBoxHeight),

                            // login button
                            // if (state is UserLoginLoadingState)
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
                                ),

                            const SizedBox(height: lSizedBoxHeight),

                            // not a member? register now
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Not a member?',
                                  style: TextStyle(color: Colors.grey[700]),
                                ),
                                const SizedBox(width: 4),
                                GestureDetector(
                                  behavior: HitTestBehavior.opaque,
                                  onTap: () {
                                    Navigator.pushNamed(context, '/signupScreen');
                                  },
                                  child: Text('Register now', style: CustomTextTheme.textButtonText),
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
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
