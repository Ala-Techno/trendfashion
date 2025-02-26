import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:trendfashion/core/ath/auth_form_fields.dart';
import 'package:trendfashion/core/ath/auth_validators.dart';
import 'package:trendfashion/core/ath/token_storage.dart';
import 'package:trendfashion/core/util/ScreenUtil.dart';
import 'package:trendfashion/core/widgets/customText.dart';
import '../../../../injection_container.dart';
import '../manager/Registration_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscurePassword = true;
  ScreenUtil screenUtil = ScreenUtil();

  @override
  Widget build(BuildContext context) {
    screenUtil.init(context);

    return Scaffold(
      body: BlocProvider(
        create: (context) => sl<Registration_bloc>(),
        child: BlocConsumer<Registration_bloc, RegistrationState>(
          listener: (context, state) {
            if (state is LoginLoading) {
              _showLoadingDialog(context);
            } else if (state is LoginLoaded) {
              _handleLoginSuccess(context, state);
            }
            if (state is LoginonError) {
              _handleErrorState(context, state);
            }
          },
          builder: (context, state) {
            return _buildLoginForm(context);
          },
        ),
      ),
    );
  }

  Widget _buildLoginForm(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        color: Colors.white,
        height: screenUtil.screenHeight, //
        child: Stack(
          children: [
            Positioned(
              top: 0,
              right: 0,
              bottom: 350,
              left: 0,
              child: Image.asset(
                'assets/images/Logo_TrendFashion.jpg',
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              child: SvgPicture.asset(
                // ← Changed to SVG widget
                'assets/images/LoginImage1.svg',
                // width: 20,
                height: 200,
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
              top: screenUtil.screenHeight * 0.4, // Start at 40% from top
              child: Container(
                  width: screenUtil.screenWidth,
                  // height: screenUtil.screenHeight * 0.7, // 70% of screen height
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
                        children: [
                          CustomTextTitle1(
                            customText: 'Login',
                            customSize: 52,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              CustomTextTitle2(
                                customText: 'Good to see you back ! ',
                                customSize: 20,
                              ),
                              Image.asset(
                                'assets/images/LoveHand.png',
                                width: 25,
                                height: 20,
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          _buildUsernameField(),
                          const SizedBox(height: 20),
                          _buildPasswordField(),
                          const SizedBox(height: 30),
                          _buildSubmitButton(context),
                        ],
                      ),
                    ),
                  )),
            ),
          ],
        ),
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
      //   border: OutlineInputBorder(
      //     borderRadius: BorderRadius.circular(12),
      //     borderSide: BorderSide(color: Colors.grey.shade300),
      //   ),
      //   filled: true,
      //   fillColor: Colors.grey.shade50,
    );
  }

  Widget _buildPasswordField() {
    return PasswordField(
      controller: _passwordController,
      // border: OutlineInputBorder(
      //   borderRadius: BorderRadius.circular(12),
      //   borderSide: BorderSide(color: Colors.grey.shade300),
      // ),
      // filled: true,
      // fillColor: Colors.grey.shade50,
    );
  }

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
        'Login',
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
    );
  }

  // Keep existing methods below...
  void _submitForm(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      BlocProvider.of<Registration_bloc>(context).add(
        LoginEvent(
          username: _usernameController.text.trim(),
          password: _passwordController.text,
        ),
      );
    }
  }

  void _handleErrorState(BuildContext context, LoginonError state) {
    Navigator.of(context, rootNavigator: true).pop();
    QuickAlert.show(
      context: context,
      type: QuickAlertType.error,
      title: 'Login Failed',
      text: state.errorMessage,
    );
  }

  void _showLoadingDialog(BuildContext context) {
    if (!Navigator.of(context, rootNavigator: true).userGestureInProgress) {
      QuickAlert.show(
        context: context,
        type: QuickAlertType.loading,
        text: 'Loading Now 😊',
      );
    }
  }

  void _handleLoginSuccess(BuildContext context, LoginLoaded state) async {
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
    _passwordController.dispose();
    super.dispose();
  }
}
