import 'package:flutter/material.dart';
import 'Login.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  // ================== CONTROLLERS ==================
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
  TextEditingController();

  // ================== STATE ==================
  bool _agreeTerms = false;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  // ================== ERROR ==================
  String? _usernameError;
  String? _emailError;
  String? _passwordError;
  String? _confirmPasswordError;

  // ================== DISPOSE ==================
  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  // ================== BUILD ==================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE7E1CE),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 28),
        child: Column(
          children: [
            const SizedBox(height: 30),

            /// TITLE
            Stack(
              children: [
                Text(
                  'SKINNOTE',
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5,
                    foreground: Paint()
                      ..style = PaintingStyle.stroke
                      ..strokeWidth = 3
                      ..color = const Color(0xFF6B6B4F),
                  ),
                ),
                const Text(
                  'SKINNOTE',
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5,
                    color: Color(0xFFEF96A0),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Stack(
              children: [
                Text(
                  'XIN CHÀO',
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5,
                    foreground: Paint()
                      ..style = PaintingStyle.stroke
                      ..strokeWidth = 3
                      ..color = const Color(0xFF6B6B4F),
                  ),
                ),
                const Text(
                  'XIN CHÀO',
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5,
                    color: Color(0xFFEF96A0),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            _label('Tên đăng ký'),
            _inputField(
              controller: _usernameController,
              errorText: _usernameError,
            ),

            const SizedBox(height: 15),

            _label('Email / SDT'),
            _inputField(
              controller: _emailController,
              errorText: _emailError,
            ),

            const SizedBox(height: 15),

            _label('Mật khẩu'),
            _inputField(
              controller: _passwordController,
              isPassword: true,
              obscureText: _obscurePassword,
              errorText: _passwordError,
              toggleObscure: () {
                setState(() {
                  _obscurePassword = !_obscurePassword;
                });
              },
            ),

            const SizedBox(height: 15),

            _label('Nhập lại mật khẩu'),
            _inputField(
              controller: _confirmPasswordController,
              isPassword: true,
              obscureText: _obscureConfirmPassword,
              errorText: _confirmPasswordError,
              toggleObscure: () {
                setState(() {
                  _obscureConfirmPassword = !_obscureConfirmPassword;
                });
              },
            ),

            const SizedBox(height: 15),

            Row(
              children: [
                Checkbox(
                  value: _agreeTerms,
                  activeColor: const Color(0xFF6B6B4F),
                  onChanged: (value) {
                    setState(() {
                      _agreeTerms = value ?? false;
                    });
                  },
                ),
                const Text('Tôi đồng ý điều khoản'),
              ],
            ),

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: _validateForm,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFB5B97D),
                ),
                child: const Text(
                  'ĐĂNG KÝ',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ================== LABEL ==================
  Widget _label(String text) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Color(0xFF6B6B4F),
        ),
      ),
    );
  }

  // ================== INPUT ==================
  Widget _inputField({
    required TextEditingController controller,
    bool isPassword = false,
    bool obscureText = false,
    String? errorText,
    VoidCallback? toggleObscure,
  }) {
    return TextField(
      controller: controller,
      obscureText: isPassword ? obscureText : false,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        errorText: errorText,

        suffixIcon: isPassword
            ? IconButton(
          icon: Icon(
            obscureText
                ? Icons.visibility_off
                : Icons.visibility,
            color: const Color(0xFF6B6B4F),
          ),
          onPressed: toggleObscure,
        )
            : null,

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          borderSide:
          const BorderSide(color: Color(0xFFB5B97D), width: 2),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          borderSide:
          const BorderSide(color: Color(0xFFB5B97D), width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          borderSide: const BorderSide(color: Colors.red, width: 2),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          borderSide: const BorderSide(color: Colors.red, width: 2),
        ),
      ),
    );
  }

  // ================== VALIDATE ==================
  void _validateForm() {
    setState(() {
      _usernameError =
      _usernameController.text.isEmpty ? 'Nhập tên đăng ký' : null;

      if (_emailController.text.isEmpty) {
        _emailError = 'Vui lòng nhập Email / SDT';
      } else if (!_emailController.text.contains('@')) {
        _emailError = 'Email không hợp lệ';
      } else {
        _emailError = null;
      }

      _passwordError = _passwordController.text.isEmpty
          ? 'Vui lòng nhập mật khẩu'
          : _passwordController.text.length < 8
          ? 'Mật khẩu ít nhất 8 ký tự'
          : null;

      _confirmPasswordError =
      _confirmPasswordController.text.isEmpty
          ? 'Vui lòng nhập lại mật khẩu'
          : _passwordController.text !=
          _confirmPasswordController.text
          ? 'Mật khẩu không khớp'
          : null;
    });

    if (!_agreeTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Vui lòng đồng ý điều khoản'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (_usernameError == null &&
        _emailError == null &&
        _passwordError == null &&
        _confirmPasswordError == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Đăng ký thành công')),
      );
    }
  }
}
