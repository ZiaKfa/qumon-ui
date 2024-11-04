import 'package:flutter/material.dart';
import 'package:qumon/ui/registrasi_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _passwordVisible = false;
  bool _confirmPasswordVisible = false;

  bool rememberUser = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[900],
        image: DecorationImage(
          image: const AssetImage("assets/images/login_bg.png"),
          fit: BoxFit.fitWidth,
          alignment: Alignment.topCenter,
        ),
      ),
      child: Scaffold(
        backgroundColor: const Color.fromARGB(86, 35, 41, 98),
        body: Stack(children: [
          Positioned(top: 80, child: _buildTop()),
          Positioned(bottom: 0, child: _buildBottom()),
        ]),
      ),
    );
  }

  Widget _buildTop() {
    final mediaSize = MediaQuery.of(context).size;
    return SizedBox(
      width: mediaSize.width,
      child: const Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Q!",
            style: TextStyle(
                color: Color.fromARGB(255, 240, 221, 16),
                fontWeight: FontWeight.bold,
                fontSize: 96,
                fontFamily: 'Poppins',
                letterSpacing: 2),
          )
        ],
      ),
    );
  }

  Widget _buildBottom() {
    final mediaSize = MediaQuery.of(context).size;
    return SizedBox(
      width: mediaSize.width,
      child: Card(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          topLeft: Radius.circular(50),
          topRight: Radius.circular(50),
        )),
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: _buildForm(),
        ),
      ),
    );
  }

  Widget _buildForm() {
    final myColor = Colors.blue;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Selamat Datang!",
          style: TextStyle(
              color: Colors.black,
              fontSize: 22,
              fontWeight: FontWeight.w600,
              fontFamily: 'Poppins'),
        ),
        _buildText("Masuk untuk memulai tantangan seru!"),
        const SizedBox(height: 40),
        _buildText("Username"),
        _usernameTextField(),
        const SizedBox(height: 30),
        _buildText("Password"),
        _passwordTextField(),
        const SizedBox(height: 30),
        _buildRememberForgot(),
        const SizedBox(height: 40),
        _loginButton(),
        const SizedBox(height: 40),
        _linkToRegister(),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildText(String text) {
    return Text(
      text,
      style: const TextStyle(
          color: Color.fromARGB(255, 0, 0, 0), fontFamily: 'Poppins'),
    );
  }

  Widget _usernameTextField() {
    return TextFormField(
      decoration: InputDecoration(),
      style: const TextStyle(color: Colors.black, fontFamily: 'Georgia'),
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

  _buildRememberForgot() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Checkbox(
                value: rememberUser,
                onChanged: (value) {
                  setState(() {
                    rememberUser = value!;
                  });
                }),
            Text(
              "Simpan Password",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400),
            ),
          ],
        ),
        TextButton(
          onPressed: () {},
          child: Text(
            "Lupa Password?",
            style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400),
          ),
        )
      ],
    );
  }

  Widget _loginButton() {
    return ElevatedButton(
      onPressed: () {
        // debugPrint("Email : ${emailController.text}");
        // debugPrint("Password : ${passwordController.text}");
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.black,
        shape: const StadiumBorder(),
        elevation: 20,
        minimumSize: const Size.fromHeight(60),
      ),
      child: const Text("Login",
          style: TextStyle(
              color: Color.fromARGB(255, 255, 255, 255),
              fontSize: 18,
              fontFamily: 'Poppins')),
    );
  }

  Widget _linkToRegister() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Belum punya akun? ",
          style: TextStyle(
              color: Colors.black,
              fontSize: 16,
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
          child: Text(
            "Daftar",
            style: TextStyle(
                color: Colors.blue,
                fontSize: 16,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400),
          ),
        )
      ],
    );
  }
}
