import 'package:flutter/material.dart';
import 'package:qumon/ui/registrasi_page.dart';
import 'package:qumon/ui/profil_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // ignore: unused_field
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _passwordVisible = false;
  bool rememberUser = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[900],
        image: const DecorationImage(
          image: AssetImage("assets/images/login_bg.png"),
          fit: BoxFit.fitWidth,
          alignment: Alignment.topCenter,
        ),
      ),
      child: Scaffold(
        resizeToAvoidBottomInset: true, 
        backgroundColor: const Color.fromARGB(86, 35, 41, 98),
        body: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height,
            ),
            child: IntrinsicHeight(
              child: Column(
                children: [
                  const SizedBox(height: 80), 
                  _buildTop(),
                  const Spacer(),
                  _buildBottom(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTop() {
    return const Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          "Q!",
          style: TextStyle(
            color: Color.fromARGB(255, 240, 221, 16),
            fontWeight: FontWeight.bold,
            fontSize: 72,
            fontFamily: 'Poppins',
            letterSpacing: 2,
          ),
        )
      ],
    );
  }

  Widget _buildBottom() {
    return Card(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(50),
          topRight: Radius.circular(50),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: _buildForm(),
      ),
    );
  }

  Widget _buildForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text(
          "Selamat Datang!",
          style: TextStyle(
            color: Colors.black,
            fontSize: 22,
            fontWeight: FontWeight.w600,
            fontFamily: 'Poppins',
          ),
        ),
        _buildText("Masuk untuk memulai tantangan seru!"),
        const SizedBox(height: 40),
        _buildText("Username"),
        _usernameTextField(),
        const SizedBox(height: 30),
        _buildText("Password"),
        _passwordTextField(),
        const SizedBox(height: 30),
        _loginButton(),
        const SizedBox(height: 20),
        // _buildRememberForgot(),
        // const SizedBox(height: 40),
        _linkToRegister(),
      ],
    );
  }

  Widget _buildText(String text, {double fontSize = 14}) {
    return Text(
      text,
      style: TextStyle(
        color: const Color.fromARGB(255, 0, 0, 0),
        fontFamily: 'Poppins',
        fontSize: fontSize,
      ),
    );
  }

  Widget _usernameTextField() {
    return TextFormField(
      decoration: const InputDecoration(),
      style: const TextStyle(color: Colors.black, fontFamily: 'Poppins'),
      keyboardType: TextInputType.text,
      controller: _usernameController,
      validator: (value) {
        if (value!.length < 3) {
          return "Nama harus diisi minimal 3 karakter";
        }
        return null;
      },
    );
  }

  Widget _passwordTextField() {
    return TextFormField(
      decoration: InputDecoration(
        suffixIcon: IconButton(
          icon: Icon(
            _passwordVisible ? Icons.visibility : Icons.visibility_off,
          ),
          onPressed: () {
            setState(() {
              _passwordVisible = !_passwordVisible;
            });
          },
        ),
      ),
      style: const TextStyle(color: Colors.black, fontFamily: 'Poppins'),
      obscureText: !_passwordVisible,
      controller: _passwordController,
      validator: (value) {
        if (value!.length < 6) {
          return "Password harus diisi minimal 6 karakter";
        }
        return null;
      },
    );
  }

  // Widget _buildRememberForgot() {
  //   return Row(
  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //     children: [
  //       Row(
  //         children: [
  //           Checkbox(
  //             value: rememberUser,
  //             onChanged: (value) {
  //               setState(() {
  //                 rememberUser = value!;
  //               });
  //             },
  //           ),
  //           const Text(
  //             "Simpan Password",
  //             style: TextStyle(
  //               color: Colors.black,
  //               fontSize: 14, // Ukuran font untuk "Simpan Password"
  //               fontFamily: 'Poppins',
  //               fontWeight: FontWeight.w400,
  //             ),
  //           ),
  //         ],
  //       ),
  //       TextButton(
  //         onPressed: () {},
  //         child: const Text(
  //           "Lupa Password?",
  //           style: TextStyle(
  //             color: Colors.black,
  //             fontSize: 14, // Ukuran font untuk "Lupa Password?"
  //             fontFamily: 'Poppins',
  //             fontWeight: FontWeight.w400,
  //           ),
  //         ),
  //       ),
  //     ],
  //   );
  // }

  Widget _loginButton() {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ProfilPage()),
        );
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.black,
        shape: const StadiumBorder(),
        elevation: 20,
        minimumSize: const Size.fromHeight(60),
      ),
      child: const Text(
        "Login",
        style: TextStyle(
          color: Color.fromARGB(255, 255, 255, 255),
          fontSize: 16,
          fontFamily: 'Poppins',
        ),
      ),
    );
  }

  Widget _linkToRegister() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Belum punya akun? ",
          style: TextStyle(
              color: Colors.black,
              fontSize: 14, 
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w400),
        ),
        TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const RegistrasiPage()),
            );
          },
          child: const Text(
            "Daftar",
            style: TextStyle(
                color: Colors.blue,
                fontSize: 14, 
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400),
          ),
        ),
      ],
    );
  }
}
