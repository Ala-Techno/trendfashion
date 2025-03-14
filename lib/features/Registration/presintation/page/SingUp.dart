import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:trendfashion/core/AppTheme.dart';
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

  // Focus Nodes
  final FocusNode _userName = FocusNode();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  ScreenUtil screenUtil = ScreenUtil();

  @override
  Widget build(BuildContext context) {
    screenUtil.init(context);

    return Scaffold(
      backgroundColor: AppTheme.scaffoldBackgroundColor,
      body: BlocProvider(
        create: (context) => sl<Registration_bloc>(),
        child: BlocConsumer<Registration_bloc, RegistrationState>(
            listener: (context, state) {
          if (state is SingUpLoading) {
            _showLoadingDialog(context);
          } else if (state is SingUpLoaded) {
            // cachedData(key: 'token', data: state.registrationModel.token);
            _handleSuccessState(context, state);
          } else if (state is SingUponError) {
            _handleErrorState(context, state);
          }
        }, builder: (context, state) {
          return Scaffold(
            body: Stack(
              children: [
                Positioned(
                  top: 0,
                  left: 0,
                  child: SvgPicture.asset(
                    // ← Changed to SVG widget
                    'assets/images/LoginImage1.svg',
                    // width: 20,
                    height: 290,
                  ),
                ),
                Positioned(
                  top: 0,
                  left: 0,
                  child: SvgPicture.asset(
                    // ← Changed to SVG widget
                    'assets/images/LoginImage2.svg',
                    // width: 20,
                    height: 240,
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
                SingleChildScrollView(
                  child: Container(
                    margin:
                        EdgeInsets.only(top: screenUtil.screenHeight * 0.34),
                    padding: const EdgeInsets.only(
                        top: 24, left: 24, right: 24, bottom: 0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            alignment: Alignment.center,
                            child: CustomTextTitle1(
                              customText: 'Sign Up',
                              customSize: 52,
                            ),
                          ),
                          const SizedBox(height: 20),
                          _buildUsernameField(),
                          const SizedBox(height: 20),
                          _buildEmailField(),
                          const SizedBox(height: 20),
                          _buildPasswordField(),
                          const SizedBox(height: 30),
                          _buildSubmitButton(context),
                          Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.symmetric(
                                vertical: 15, horizontal: 50),
                            child: InkWell(
                              onTap: () {
                                // Navigate to LoginPage instead of toggling _isLogin
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => LoginPage(),
                                  ),
                                );
                              },
                              child: Text(
                                'Already have an account? Login',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
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
      focusNode: _userName,
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
      focusNode: _emailFocusNode,
    );
  }

  Widget _buildPasswordField() {
    return PasswordField(
      controller: _passwordController,
      passwordFocusNode: _passwordFocusNode,
    );
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
        backgroundColor: AppTheme.primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 3,
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

    AwesomeDialog(
      context: context,
      dialogType: DialogType.error,
      animType: AnimType.scale,
      title: 'Registration Failed',
      desc: state.errorMessage,
      dismissOnTouchOutside: true, // Block taps outside (correct param name)
      dismissOnBackKeyPress: true, // Allow back button to close dialog
      btnOk: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red[400], //
        ),
        onPressed: () {
          Navigator.pop(context); // Close  error dialog
          FocusScope.of(context)
              .requestFocus(_userName); // or _passwordFocusNode
        },
        child: const Text(
          'Retry',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    ).show();
  }

  void _showLoadingDialog(BuildContext context) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.info,
      animType: AnimType.scale,
      title: 'Loading...',
      desc: 'Please wait 😊',
      dismissOnTouchOutside: false, // Block taps outside (correct param name)
      dismissOnBackKeyPress: false, // Block back button (correct param name)
    ).show();
  }

// In _handleSuccessState of SingUpPage
  Future<void> _handleSuccessState(
      BuildContext context, SingUpLoaded state) async {
    try {
      await TokenStorage.saveToken(state.registrationModel.token);
      Navigator.pushNamedAndRemoveUntil(
          context, '/categories', (route) => false);
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

    // Dispose Focus Nodes
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();

    super.dispose();
  }
}
