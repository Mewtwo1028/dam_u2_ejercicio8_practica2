import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String username = "Ash";
  String password = "K";
  final controladorUser = TextEditingController();
  final controladorPass = TextEditingController();
  String texto = "";

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        padding: EdgeInsets.all(50),
        children: [
          TextField(
            controller: controladorUser,
            decoration: const InputDecoration(labelText: 'Nombre de entrenador'),
          ),
          TextField(
            controller: controladorPass,
            decoration: const InputDecoration(labelText: 'Contraseña'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                (controladorUser.text == username && controladorPass.text == password)
                    ? texto = "OK"
                    : texto = "Fail";
              });
            },
            child: Text("Iniciar sesión en el Pokédex"),
          ),

          Text(texto),
          Image.asset("assets/RotomDex.png"),
        ],
      ),
    );
  }
}