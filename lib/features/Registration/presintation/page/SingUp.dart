import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:trendfashion/core/ath/auth_form_fields.dart';
import 'package:trendfashion/core/ath/auth_validators.dart';
import 'package:trendfashion/core/util/ScreenUtil.dart';
import 'package:trendfashion/core/ath/token_storage.dart';
import 'package:trendfashion/core/widgets/customText.dart';
import 'package:trendfashion/features/Registration/presintation/page/LoginPage.dart';
import '../../../../injection_container.dart';
import '../manager/Registration_bloc.dart';

class SingUpPage extends StatefulWidget {
  const SingUpPage({super.key});

  @override
  State<SingUpPage> createState() => _SingUpPageState();
}

class _SingUpPageState extends State<SingUpPage> {
  // bool _isLogin = false;

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  ScreenUtil screenUtil = ScreenUtil();

  @override
  Widget build(BuildContext context) {
    screenUtil.init(context);

    return Scaffold(
      body: BlocProvider(
        create: (context) => sl<Registration_bloc>(),
        child: BlocConsumer<Registration_bloc, RegistrationState>(
            listener: (context, state) {
          if (state is SingUpLoading) {
            _showLoadingDialog(context);
          } else if (state is SingUpLoaded) {
            // cachedData(key: 'token', data: state.registrationModel.token);
            _handleSuccessState(context, state);
          }
        }, builder: (context, state) {
          if (state is SingUponError) {
            _handleErrorState(context, state);
          }
          return SingleChildScrollView(
            child: SizedBox(
              height: screenUtil.screenHeight, //
              child: Stack(
                children: [
                  Positioned(
                    top: 0,
                    left: 0,
                    child: SvgPicture.asset(
                      // ← Changed to SVG widget
                      'assets/images/LoginImage1.svg',
                      // width: 20,
                      height: 300,
                    ),
                  ),
                  Positioned(
                    top: 0,
                    left: 0,
                    child: SvgPicture.asset(
                      'assets/images/LoginImage2.svg',
                      // width: 20,
                      height: 250,
                    ),
                  ),
                  Positioned(
                    top: 250,
                    right: 0,
                    child: SvgPicture.asset(
                      'assets/images/LoginImage3.svg',
                      // width: 20,
                      height: 100,
                    ),
                  ),
                  Positioned(
                    top:
                        screenUtil.screenHeight * 0.35, // Start at 40% from top
                    child: Container(
                      width: screenUtil.screenWidth,
                      //  /   height: screenUtil.screenHeight * 0.7, // 70% of screen height
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        // color: Colors.white,
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30)),
                      ),
                      child: SingleChildScrollView(
                        child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomTextTitle1(
                                customText: 'Sign Up',
                                customSize: 52,
                              ),
                              const SizedBox(height: 20),
                              _buildUsernameField(),
                              const SizedBox(height: 20),
                              _buildEmailField(),
                              const SizedBox(height: 20),
                              _buildPasswordField(),
                              const SizedBox(height: 30),
                              _buildSubmitButton(context),
                              InkWell(
                                onTap: () {
                                  // Navigate to LoginPage instead of toggling _isLogin
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => LoginPage()),
                                  );
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 40, vertical: 10),
                                  child: const Text(
                                      'Already have an account? Login'),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildUsernameField() {
    return AuthTextField(
      controller: _usernameController,
      label: 'Username',
      hint: 'Enter 4-20 characters',
      validator: AuthValidators.usernameValidator,
      prefixIcon: Icons.person_outline,
      autofillHints: const [AutofillHints.name],
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.name,
    );
  }

  Widget _buildEmailField() {
    return AuthTextField(
      controller: _emailController,
      label: 'Email',
      hint: 'your.email@example.com',
      validator: AuthValidators.emailValidator,
      prefixIcon: Icons.email_outlined,
      autofillHints: const [AutofillHints.email],
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.emailAddress,
    );
  }

  Widget _buildPasswordField() {
    return PasswordField(controller: _passwordController);
  }

  // Widget _buildPasswordField() {
  //   return TextFormField(
  //     controller: _passwordController,
  //     obscureText: _obscurePassword,
  //     decoration: InputDecoration(
  //       labelText: 'Password',
  //       prefixIcon: const Icon(Icons.lock_outline),
  //       border: const OutlineInputBorder(),
  //       hintText: 'At least 8 characters',
  //       suffixIcon: IconButton(
  //         icon:
  //             Icon(_obscurePassword ? Icons.visibility_off : Icons.visibility),
  //         onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
  //       ),
  //     ),
  //     validator: (value) {
  //       if (value == null || value.isEmpty) return 'Password required';
  //       if (value.length < 8) return 'Minimum 8 characters';
  //       if (!RegExp(r'[A-Z]').hasMatch(value))
  //         return 'Include uppercase letter';
  //       if (!RegExp(r'[a-z]').hasMatch(value))
  //         return 'Include lowercase letter';
  //       if (!RegExp(r'[0-9]').hasMatch(value)) return 'Include number';
  //       return null;
  //     },
  //     autofillHints: const [AutofillHints.newPassword],
  //     textInputAction: TextInputAction.done,
  //     onFieldSubmitted: (_) => _submitForm(context),
  //   );
  // }

  Widget _buildSubmitButton(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(double.infinity, 55),
        backgroundColor: Colors.blue,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 5,
      ),
      onPressed: () => _submitForm(context),
      child: const Text(
        'Sign Up',
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
    );
  }

  void _submitForm(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      BlocProvider.of<Registration_bloc>(context).add(
        SingUpEvent(
          username: _usernameController.text.trim(),
          email: _emailController.text.trim(),
          password: _passwordController.text,
        ),
      );
    }
  }

  void _handleErrorState(BuildContext context, SingUponError state) {
    Navigator.of(context, rootNavigator: true).pop();
    QuickAlert.show(
      context: context,
      type: QuickAlertType.error,
      title: 'Registration Failed',
      text: state.errorMessage,
    );
  }

  void _showLoadingDialog(BuildContext context) {
    QuickAlert.show(
      context: context,
      type: QuickAlertType.loading,
      text: 'Loading Now 😊',
    );
  }

// In _handleSuccessState of SingUpPage
  Future<void> _handleSuccessState(
      BuildContext context, SingUpLoaded state) async {
    try {
      await TokenStorage.saveToken(state.registrationModel.token);
      Navigator.pushNamedAndRemoveUntil(context, '/products', (route) => false);
    } catch (e) {
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        title: 'Token Save Failed',
        text: e.toString(),
      );
    }
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
