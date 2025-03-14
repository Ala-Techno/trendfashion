import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:trendfashion/core/AppTheme.dart';
import 'package:trendfashion/core/ath/auth_form_fields.dart';
import 'package:trendfashion/core/ath/auth_validators.dart';
import 'package:trendfashion/core/ath/token_storage.dart';
import 'package:trendfashion/core/util/ScreenUtil.dart';
import 'package:trendfashion/core/widgets/customText.dart';
import 'package:trendfashion/features/Registration/presintation/page/SingUp.dart';
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

  // Focus Nodes
  final FocusNode _UserOrEmail = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  // bool _obscurePassword = true;
  ScreenUtil screenUtil = ScreenUtil();

  @override
  Widget build(BuildContext context) {
    screenUtil.init(context);

    return Scaffold(
      // backgroundColor: AppTheme.scaffoldBackgroundColor,
      body: BlocProvider(
        create: (context) => sl<Registration_bloc>(),
        child: BlocConsumer<Registration_bloc, RegistrationState>(
          listener: (context, state) {
            if (state is LoginLoading) {
              _showLoadingDialog(context);
            } else if (state is LoginLoaded) {
              _handleLoginSuccess(context, state);
            }
            if (state is LoginOnError) {
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
              margin: EdgeInsets.only(top: screenUtil.screenHeight * 0.34),
              padding: const EdgeInsets.only(
                  top: 24, left: 24, right: 24, bottom: 0),
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
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 15),
                      child: InkWell(
                        onTap: () {
                          // Navigate to LoginPage instead of toggling _isLogin
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SingUpPage()),
                          );
                        },
                        child: Text(
                          'Sing Up ?',
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
  }

  Widget _buildUsernameField() {
    return AuthTextField(
      controller: _usernameController,
      label: 'Username',
      hint: 'Enter 4-20 characters',
      validator: AuthValidators.usernameValidator,
      prefixIcon: Icons.person_outline, focusNode: _UserOrEmail,
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
      controller: _passwordController, passwordFocusNode: _passwordFocusNode,
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
        backgroundColor: AppTheme.primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 3,
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

  void _handleErrorState(BuildContext context, LoginOnError state) {
    Navigator.of(context, rootNavigator: true).pop();

    AwesomeDialog(
      context: context,
      dialogType: DialogType.error,
      animType: AnimType.scale,
      title: 'Login Failed',
      desc: state.errorMessage,
      dismissOnTouchOutside: true, // Block taps outside
      dismissOnBackKeyPress: true, // Block back button
      btnOk: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red[500], //
        ),
        onPressed: () {
          Navigator.pop(context); // Close dialog
          // Optional: Focus on a form field
          FocusScope.of(context)
              .requestFocus(_UserOrEmail); // or _passwordFocusNode
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

  void _handleLoginSuccess(BuildContext context, LoginLoaded state) async {
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
    _passwordController.dispose();

    _UserOrEmail.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }
}
