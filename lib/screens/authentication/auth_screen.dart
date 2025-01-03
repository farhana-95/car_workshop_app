import 'package:flutter/material.dart';
import 'package:car_workshop_app/const/color.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:car_workshop_app/controllers/auth_controller.dart';

class AuthScreen extends ConsumerStatefulWidget {
  const AuthScreen({super.key});

  @override
  ConsumerState<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends ConsumerState<AuthScreen> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  bool _isLogin = true;
  String? _role;
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text(_isLogin ? 'Login' : 'Register'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.1,
          ),
          child: Column(
            children: [
              SizedBox(height: screenHeight * 0.05),
              Image.asset(
                "assets/images/car_key.png",
                height: screenWidth * 0.45,
                width: screenWidth * 0.45,
              ),
              SizedBox(height: screenHeight * 0.05),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    if (!_isLogin) ...[
                      TextFormField(
                        controller: nameController,
                        decoration: const InputDecoration(labelText: 'Name'),
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a name';
                          }
                          return null;
                        },
                      ),
                    ],
                    SizedBox(height: screenHeight * 0.020),
                    TextFormField(
                      controller: emailController,
                      decoration: const InputDecoration(labelText: 'Email'),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            !value.contains('@')) {
                          return 'Please enter a valid email';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: screenHeight * 0.020),
                    TextFormField(
                      controller: passwordController,
                      decoration: InputDecoration(
                          labelText: 'Password',
                          suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  _isPasswordVisible = !_isPasswordVisible;
                                });
                              },
                              icon: Icon(_isPasswordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off))),
                      obscureText: !_isPasswordVisible,
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            value.length < 6) {
                          return 'Password must be at least 6 characters long';
                        }
                        return null;
                      },
                    ),
                    if (!_isLogin) ...[
                      SizedBox(height: screenHeight * 0.025),
                      DropdownButtonFormField<String>(
                        decoration: const InputDecoration(
                          labelText: 'User',
                          border: UnderlineInputBorder(),
                        ),
                        value: _role,
                        items: const [
                          DropdownMenuItem(
                              value: 'admin', child: Text('Admin')),
                          DropdownMenuItem(
                              value: 'mechanic', child: Text('Mechanic')),
                        ],
                        onChanged: (value) {
                          setState(() {
                            _role = value;
                          });
                        },
                        validator: (value) {
                          if (value == null) {
                            return 'Please select an user type';
                          }
                          return null;
                        },
                      ),
                    ],
                    SizedBox(height: screenHeight * 0.05),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.resolveWith<Color>(
                          (Set<WidgetState> states) {
                            if (states.contains(WidgetState.disabled)) {
                              return ColorList.blue;
                            }
                            return ColorList.blue;
                          },
                        ),
                      ),
                      onPressed: _isLogin ? _logInUser : _signUpUser,
                      child: Text(
                        _isLogin ? 'Login' : 'Register',
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    const Text('Or'),
                    SizedBox(height: screenHeight * 0.02),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _isLogin = !_isLogin;
                        });
                      },
                      child: Text(
                        _isLogin
                            ? 'Create an account'
                            : 'I already have an account',
                        style: const TextStyle(
                            decoration: TextDecoration.underline),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: screenHeight * 0.1),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _signUpUser() async {
    if (_formKey.currentState!.validate()) {
      FocusScope.of(context).unfocus();

      try {
        await ref.read(authControllerProvider.notifier).signUp(
            emailController.text,
            passwordController.text,
            _role!,
            nameController.text);
      } catch (e) {
        if (mounted) {
          _showSnackBar('Sign up failed: $e');
        }
      }
    }
  }

  Future<void> _logInUser() async {
    if (_formKey.currentState!.validate()) {
      FocusScope.of(context).unfocus();

      try {
        await ref
            .read(authControllerProvider.notifier)
            .logIn(emailController.text, passwordController.text);
      } catch (e) {
        if (mounted) {
          _showSnackBar('Log In failed: $e');
        }
      }
    }
  }

  void _showSnackBar(String message) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );
    }
  }
}
