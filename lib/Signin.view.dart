import 'package:flutter/material.dart';

bool isDarkTheme = false;
String currentLanguage = 'English'; // Varsayılan dil İngilizce

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isObscure = true;

  String _getLocalizedText(String tr, String en) {
    return currentLanguage == 'English' ? en : tr;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _getLocalizedText('Giriş Yap', 'Sign In'),
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: isDarkTheme ? Colors.white : Colors.orange,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: isDarkTheme ? Colors.black : Colors.white,
        actions: [
          IconButton(
            icon: Icon(
              currentLanguage == 'English' ? Icons.language : Icons.translate,
              color: isDarkTheme ? Colors.orange : Colors.orange,
            ),
            onPressed: () {
              setState(() {
                currentLanguage =
                currentLanguage == 'English' ? 'Türkçe' : 'English';
              });
            },
          ),
          IconButton(
            icon: Icon(
              isDarkTheme ? Icons.dark_mode : Icons.light_mode,
              color: isDarkTheme ? Colors.orange : Colors.orange,
            ),
            onPressed: () {
              setState(() {
                isDarkTheme = !isDarkTheme;
              });
            },
          ),
        ],
      ),
      backgroundColor:
      isDarkTheme ? Colors.black : Colors.grey.shade100, // Arka plan rengi
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor:
                  isDarkTheme ? Colors.grey.shade900 : Colors.grey.shade100,
                  hintText: _getLocalizedText('E-posta', 'Email'),
                  hintStyle: TextStyle(
                    color: isDarkTheme ? Colors.grey.shade400 : Colors.grey,
                  ),
                  prefixIcon: Icon(
                    Icons.email,
                    color: isDarkTheme ? Colors.orange : Colors.orange,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(
                      color: isDarkTheme ? Colors.orange : Colors.orange,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(
                      color: isDarkTheme ? Colors.orange : Colors.orange,
                      width: 2,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _passwordController,
                obscureText: _isObscure,
                decoration: InputDecoration(
                  filled: true,
                  fillColor:
                  isDarkTheme ? Colors.grey.shade900 : Colors.grey.shade100,
                  hintText: _getLocalizedText('Şifre', 'Password'),
                  hintStyle: TextStyle(
                    color: isDarkTheme ? Colors.grey.shade400 : Colors.grey,
                  ),
                  prefixIcon: Icon(
                    Icons.lock,
                    color: isDarkTheme ? Colors.orange : Colors.orange,
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isObscure ? Icons.visibility_off : Icons.visibility,
                      color: isDarkTheme ? Colors.orange : Colors.orange,
                    ),
                    onPressed: () {
                      setState(() {
                        _isObscure = !_isObscure;
                      });
                    },
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(
                      color: isDarkTheme ? Colors.orange : Colors.orange,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(
                      color: isDarkTheme ? Colors.orange : Colors.orange,
                      width: 2,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  // Sign-in işlemi
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content: Text(
                            _getLocalizedText('Giriş Yapıldı!', 'Logged In!'))),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: isDarkTheme ? Colors.orange : Colors.orange,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding:
                  const EdgeInsets.symmetric(vertical: 16, horizontal: 80),
                ),
                child: Text(
                  _getLocalizedText('Giriş Yap', 'Sign In'),
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () {
                  // Şifremi unuttum işlemi
                },
                child: Text(
                  _getLocalizedText('Şifremi Unuttum?', 'Forgot Password?'),
                  style: TextStyle(
                    fontSize: 16,
                    color: isDarkTheme ? Colors.orange : Colors.orange,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
