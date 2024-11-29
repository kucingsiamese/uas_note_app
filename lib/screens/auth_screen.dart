import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLogin = true;
  bool _hidePassword = true;
  void _submitAuthForm() {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all fields')),
      );
      return;
    }

    // login/register
    if (_isLogin) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Logged in successfully!')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Registered successfully!')),
      );
    }

    // Navigasikan ke layar utama setelah login/register
    Navigator.of(context).pushReplacementNamed('/home');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 3, 0, 10),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  _isLogin ? 'NoteApp Login' : 'Create Account',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF8A56AC),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  _isLogin
                      ? 'Hey, Enter your details to sign in to your account'
                      : 'Create an account to start your notes',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Color.fromARGB(255, 156, 134, 187),
                  ),
                ),
                const SizedBox(height: 30),
                TextField(
                  controller: _emailController,
                  style:
                      const TextStyle(color: Color.fromARGB(255, 177, 64, 165)),
                  decoration: InputDecoration(
                    labelText: 'Email or Phone No',
                    labelStyle: const TextStyle(
                        color: Color.fromARGB(255, 177, 64, 165)),
                    prefixIcon:
                        const Icon(Icons.email, color: Color(0xFF8A56AC)),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: _passwordController,
                  obscureText: _hidePassword, // Sembunyikan password
                  style:
                      const TextStyle(color: Color.fromARGB(255, 177, 64, 165)),
                  decoration: InputDecoration(
                    labelText: 'Password',
                    labelStyle: const TextStyle(
                        color: Color.fromARGB(255, 177, 64, 165)),
                    prefixIcon:
                        const Icon(Icons.lock, color: Color(0xFF8A56AC)),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _hidePassword ? Icons.visibility : Icons.visibility_off,
                        color: const Color(0xFF8A56AC),
                      ),
                      onPressed: () {
                        setState(() {
                          _hidePassword = !_hidePassword;
                        });
                      },
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                TextButton(
                  onPressed: () {
                    // untuk lupa password
                  },
                  child: const Text(
                    'Having trouble in signing in?',
                    style: TextStyle(color: Color(0xFF8A56AC)),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _submitAuthForm,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF8A56AC),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: Text(
                    _isLogin ? 'Sign in' : 'Register',
                    style: const TextStyle(fontSize: 18),
                  ),
                ),
                const SizedBox(height: 20),
                const Row(
                  children: [
                    Expanded(child: Divider(color: Colors.grey)),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Text('Or Sign in with'),
                    ),
                    Expanded(child: Divider(color: Colors.grey)),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.g_mobiledata, size: 36),
                      color: const Color(0xFF4285F4),
                      onPressed: () {
                        //sign-in Google
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.apple, size: 36),
                      color: const Color.fromARGB(255, 252, 250, 250),
                      onPressed: () {
                        //sign-in Apple
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.facebook, size: 36),
                      color: const Color(0xFF1877F2),
                      onPressed: () {
                        //sign-in Facebook
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                TextButton(
                  onPressed: () {
                    setState(() {
                      _isLogin = !_isLogin;
                    });
                  },
                  child: Text(
                    _isLogin
                        ? 'Don\'t have an account? Register Now'
                        : 'Already have an account? Sign in',
                    style: const TextStyle(color: Color(0xFF8A56AC)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
