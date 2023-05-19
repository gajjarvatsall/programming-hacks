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
import 'package:programming_hacks/widgets/snackbar.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final usernameController = TextEditingController();

  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  //form key
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: BlocConsumer<AuthUserBloc, AuthUserState>(
        listener: (context, state) {
          if (state is UserSignupLoadedState) {
            showSnackBar(
              context,
              'Successfully Signed Up',
              null,
              ContentType.success,
            );
            Navigator.pushNamedAndRemoveUntil(
              context,
              '/homeScreen',
              (route) => false,
            );
          }
          if (state is UserSignupErrorState) {
            showSnackBar(
              context,
              state.errorMsg,
            );
          }
        },
        builder: (context, state) {
          return Form(
            key: _formKey,
            child: Center(
              child: SingleChildScrollView(
                child: ListView(
                  shrinkWrap: true,
                  padding: const EdgeInsets.symmetric(horizontal: hPadding),
                  children: [
                    const Icon(
                      Icons.person,
                      size: 100,
                    )
                        .animate()
                        .fadeIn(duration: 1000.ms, curve: Curves.easeOutCirc)
                        .slideY(begin: 0.5, end: 0),

                    const SizedBox(height: lSizedBoxHeight),

                    // welcome back, you've been missed!
                    Center(
                      child:
                          Text('Welcome to Programming Hacks', style: CustomTextTheme.welcomeText),
                    )
                        .animate()
                        .fadeIn(duration: 1000.ms, curve: Curves.easeOutCirc)
                        .slideY(begin: 0.5, end: 0),

                    const SizedBox(height: mSizedBoxHeight),

                    // username textfield
                    CustomTextField(
                      controller: usernameController,
                      hintText: 'Username',
                      textInputAction: TextInputAction.next,
                      textInputType: TextInputType.text,
                      validator: FormBuilderValidators.compose(
                        [
                          /// Makes this field required
                          FormBuilderValidators.required(errorText: 'Username is required'),
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

                    // email textfield
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
                          delay: 600.ms,
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
                        .fadeIn(
                          duration: 1000.ms,
                          curve: Curves.easeOutCirc,
                          delay: 700.ms,
                        )
                        .slideY(begin: 0.5, end: 0),

                    const SizedBox(height: mSizedBoxHeight),

                    // sign up button
                    CustomButton(
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          context.read<AuthUserBloc>().add(
                                UserSignUpEvent(
                                  name: usernameController.text,
                                  email: emailController.text,
                                  password: passwordController.text,
                                ),
                              );
                        }
                      },
                      text: 'Sign Up',
                      isLoading: (state is UserSignupLoadingState || state is UserSignupErrorState)
                          ? true
                          : false,
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
                          'Already a member?',
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                        const SizedBox(width: 4),
                        GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: () {
                            Navigator.pushNamed(context, '/loginScreen');
                          },
                          child: Text('Login now', style: CustomTextTheme.textButtonText),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
