import 'package:flutter/material.dart';
import 'StatelessWidget.dart';
import 'register.dart';

class Login extends StatelessWidget {
  Login ({super.key});

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE7E1CE),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 28),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      'images/elementer/elmenterapp.png',
                      width: 150,
                      height: 150,
                      fit: BoxFit.contain,
                    ),

                    const SizedBox(width: 16), // khoảng cách trái

                    const Text(
                      'ĐĂNG NHẬP',
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFF4A6A6),
                        letterSpacing: 1.5,
                      ),
                    ),

                    const SizedBox(width: 16), // khoảng cách phải

                    Image.asset(
                      'images/elementer/elmenterapp.png',
                      width: 150,
                      height: 150,
                      fit: BoxFit.contain,
                    ),
                  ],
                ),
                const SizedBox(height: 40),

                // TÊN ĐĂNG NHẬP
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Tên đăng nhập:',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF6B6B4F),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                _inputField(controller: usernameController),

                const SizedBox(height: 24),

                // MẬT KHẨU
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Mật khẩu:',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF6B6B4F),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                _inputField(
                  controller: passwordController,
                  obscureText: true,
                ),

                const SizedBox(height: 32),

                // NÚT ĐĂNG NHẬP
                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFB8BE82),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(28),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                          MaterialPageRoute(
                          builder: (context) => const  MyApp(),
                        ),
                      );
                    },
                    child: const Text(
                      'ĐĂNG NHẬP',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFF4CCCA),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                // QUÊN MK & ĐĂNG KÝ
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Quên mật khẩu',
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFF6B6B4F),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Register(),
                          ),
                        );
                      },
                      child: const Text(
                        'Đăng ký',
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF6B6B4F),
                        ),
                      ),
                    ),
                  ],
                ),

              ],
                ),

            ),
          ),
        ),

    );
  }

  // INPUT FIELD
  Widget _inputField({
    required TextEditingController controller,
    bool obscureText = false,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        contentPadding:
        const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(
            color: Color(0xFFB8BE82),
            width: 2,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(
            color: Color(0xFF9FA665),
            width: 2,
          ),
        ),
      ),
    );
  }
}
