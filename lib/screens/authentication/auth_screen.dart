import 'package:flutter/material.dart';
import 'package:car_workshop_app/const/color.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _formKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';
  bool _isLogin = true;
  String? _role;

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
                    TextFormField(
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
                      onSaved: (value) => _email = value!,
                    ),
                    SizedBox(height: screenHeight * 0.020),
                    TextFormField(
                      decoration: const InputDecoration(labelText: 'Password'),
                      obscureText: true,
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            value.length < 6) {
                          return 'Password must be at least 6 characters long';
                        }
                        return null;
                      },
                      onSaved: (value) => _password = value!,
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
                      onPressed: () {},
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
}
