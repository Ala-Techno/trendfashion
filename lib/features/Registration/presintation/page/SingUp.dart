import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_dialogs/dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:trendfashion/core/util/ScreenUtil.dart';
import 'package:trendfashion/features/Product/presintation/Widget/ProductCard.dart';
import 'package:trendfashion/features/Product/presintation/page/productsPage.dart';
import '../../../../injection_container.dart';
import '../../../../main.dart';

import '../manager/Registration_bloc.dart';

class SingUpPage extends StatefulWidget {
  SingUpPage({super.key});

  @override
  State<SingUpPage> createState() => _SingUpPageState();
}

class _SingUpPageState extends State<SingUpPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  ScrollController _scrollController = ScrollController();
  List filterList = [
    {
      "name": "الدول  المناصرة للقضية",
      "id": 4,
    },
    {
      "name": "الدول  الداعمة للقضية",
      "id": 3,
    },
    {
      "name": "الدول الداعمة للاحتلال",
      "id": 2,
    },
    {
      "name": "الدول المحايدة",
      "id": 1,
    },
  ];

  GlobalKey<ScaffoldState> scaffolKey = GlobalKey<ScaffoldState>();

  int itemisselected = 0;
  String valueInput = "";
  Widget ProductWidget = Container();
  ScreenUtil screenUtil = ScreenUtil();
  Widget build(BuildContext context) {
    screenUtil.init(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('SingUp'),
        centerTitle: true,
      ),
      body: BlocProvider(
        create: (context) => sl<Registration_bloc>(),
        child: BlocConsumer<Registration_bloc, RegistrationState>(
          listener: (context, state) {
            if (state is SinguponError) {
              Navigator.pop(context); // Dismiss loading
              QuickAlert.show(
                context: context,
                type: QuickAlertType.error,
                text: state.errorMessage,
              );
            }

            if (state is SingupLoading) {
              QuickAlert.show(
                context: context,
                type: QuickAlertType.loading,
                barrierDismissible: false,
                text: 'Loading in Progress',
              );
            }

            if (state is SingupLoaded) {
              Navigator.of(context)
                  .popUntil((route) => route.isFirst); // Clear all dialogs
              Navigator.pushReplacement(
                // Use replacement
                context,
                MaterialPageRoute(builder: (context) => ProductPage()),
              );
            }
          },
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    // Username Field
                    TextFormField(
                      controller: _usernameController,
                      decoration: const InputDecoration(
                        labelText: 'Username',
                        prefixIcon: Icon(Icons.person),
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a username';
                        }
                        if (value.length < 4) {
                          return 'Username must be at least 4 characters';
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 16),

                    // Email Field
                    TextFormField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        prefixIcon: Icon(Icons.email),
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter an email';
                        }
                        if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                            .hasMatch(value)) {
                          return 'Please enter a valid email';
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 16),

                    // Password Field
                    TextFormField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        prefixIcon: const Icon(Icons.lock),
                        border: const OutlineInputBorder(),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscurePassword
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscurePassword = !_obscurePassword;
                            });
                          },
                        ),
                      ),
                      obscureText: _obscurePassword,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a password';
                        }
                        if (value.length < 6) {
                          return 'Password must be at least 6 characters';
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 24),

                    // Sign Up Button
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          // Call your signUp function here
                          final username = _usernameController.text;
                          final email = _emailController.text;
                          final password = _passwordController.text;

                          BlocProvider.of<Registration_bloc>(context).add(
                              SingUpEvent(
                                  username: _usernameController.text,
                                  email: _emailController.text,
                                  password: _passwordController.text));

                          // Example usage:
                          // context.read<AuthRepository>().signUp(
                          //   username: username,
                          //   email: email,
                          //   password: password,
                          // );
                        }
                      },
                      child: const Text('Sign Up'),
                    ),
                  ],
                ),
              ),
            );

            return ProductWidget;
          },
        ),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
