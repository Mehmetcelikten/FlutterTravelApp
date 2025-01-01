import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

bool isDarkTheme = false;
String currentLanguage = 'English'; // Varsayılan dil İngilizce

class SettingsManager {
  static Future<void> savePreferences(String language, bool isDark) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('language', language);
    await prefs.setBool('isDarkTheme', isDark);
  }

  static Future<void> loadPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    currentLanguage = prefs.getString('language') ?? 'English';
    isDarkTheme = prefs.getBool('isDarkTheme') ?? false;
  }
}

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isObscure = true;

  @override
  void initState() {
    super.initState();
    // Tercihleri yükle
    SettingsManager.loadPreferences().then((_) {
      setState(() {});
    });
  }

  String _getLocalizedText(String tr, String en) {
    return currentLanguage == 'English' ? en : tr;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _getLocalizedText('Kayıt Ol', 'Register'),
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
              SettingsManager.savePreferences(currentLanguage, isDarkTheme);
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
              SettingsManager.savePreferences(currentLanguage, isDarkTheme);
            },
          ),
        ],
      ),
      backgroundColor: isDarkTheme ? Colors.black : Colors.grey.shade100,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextField(
                controller: _usernameController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor:
                  isDarkTheme ? Colors.grey.shade900 : Colors.grey.shade100,
                  hintText: _getLocalizedText('Kullanıcı Adı', 'Username'),
                  hintStyle: TextStyle(
                    color: isDarkTheme ? Colors.grey.shade400 : Colors.grey,
                  ),
                  prefixIcon: Icon(
                    Icons.person,
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
                  // Kayıt olma işlemi
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content: Text(_getLocalizedText(
                            'Kayıt Başarılı!', 'Registration Successful!'))),
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
                  _getLocalizedText('Kayıt Ol', 'Register'),
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
                  // Sign In sayfasına yönlendirme
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SignInPage(),
                    ),
                  );
                },
                child: Text(
                  _getLocalizedText(
                      'Zaten hesabınız var mı?', 'Already have an account?'),
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

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign In'),
      ),
      body: Center(
        child: Text('Sign In Page'),
      ),
    );
  }
}
