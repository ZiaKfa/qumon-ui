import 'package:flutter/material.dart';

class RegistrasiPage extends StatefulWidget {
  const RegistrasiPage({Key? key}) : super(key: key);

  @override
  _RegistrasiPageState createState() => _RegistrasiPageState();
}

class _RegistrasiPageState extends State<RegistrasiPage> {
  // ignore: unused_field
  final _formKey = GlobalKey<FormState>();
  // ignore: unused_field
  bool _isLoading = false;
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _passwordVisible = false;
  bool _confirmPasswordVisible = false;

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
      backgroundColor: const Color.fromARGB(86, 35, 41, 98),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.transparent, 
            elevation: 0, 
            floating: true, 
            pinned: true, 
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                alignment: Alignment.topLeft,
                padding: const EdgeInsets.all(10.0),
                child: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white), 
                  onPressed: () {
                    Navigator.pop(context); 
                  },
                ),
              ),
            ),
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: Column(
              children: [
                const SizedBox(height: 60), // Jarak dari atas
                _buildTop(),
                const Spacer(),
                _buildBottom(),
              ],
            ),
          ),
        ],
      ),
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
                fontSize: 72,
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
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text(
        "Daftar Akun Baru!",
        style: TextStyle(
            color: Colors.black,
            fontSize: 22,
            fontWeight: FontWeight.w600,
            fontFamily: 'Poppins'),
      ),
      _buildText("Buat akun dan uji wawasanmu!"),
      const SizedBox(height: 50),
      _buildText("Username"),
      _usernameTextField(),
      const SizedBox(height: 30),
      _buildText("Password"),
      _passwordTextField(),
      const SizedBox(height: 30),
      _buildText("Konfirmasi Password"),
      _confirmPasswordTextField(),
      const SizedBox(height: 40),
      _registrasiButton(),
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

  Widget _confirmPasswordTextField() {
    return TextFormField(
      decoration: InputDecoration(
        suffixIcon: IconButton(
          icon: Icon(
            _confirmPasswordVisible ? Icons.visibility : Icons.visibility_off,
          ),
          onPressed: () {
            setState(() {
              _confirmPasswordVisible = !_confirmPasswordVisible;
            });
          },
        ),
      ),
      style: const TextStyle(color: Colors.black, fontFamily: 'Poppins'),
      obscureText: !_confirmPasswordVisible,
      controller: _confirmPasswordController,
      validator: (value) {
        if (value != _passwordController.text) {
          return "Konfirmasi Password tidak sama";
        }
        return null;
      },
    );
  }

  final myColor = Colors.blue;
  Widget _registrasiButton() {
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
      child: const Text("Registrasi",
          style: TextStyle(
              color: Color.fromARGB(255, 255, 255, 255),
              fontSize: 16,
              fontFamily: 'Poppins')),
    );
  }
}
