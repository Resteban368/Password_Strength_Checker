import 'package:flutter/material.dart';

import 'lib/password_strength_checker.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(

      title: 'Password Strength Checker',
      home: const HomePage(),

      //theme dark
      theme: ThemeData.dark().copyWith(
        primaryColor: Colors.deepPurple,
        scaffoldBackgroundColor: Colors.deepPurple,
        colorScheme: const ColorScheme.dark().copyWith(
          primary: Colors.deepPurple,
        ),
      ),
    );
  }
}



class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // 1. Create a TextEditingController to get the password value from the text field
  // 1. Cree un TextEditingController para obtener el valor de la contraseña del campo de texto
  final _passwordController = TextEditingController();

  // 2. Create a boolean to store the password strength
  // 2. Cree un booleano para almacenar la fortaleza de la contraseña
  bool _isStrong = false;

  // 3. Dispose the TextEditingController
  // 3. Dispose el TextEditingController


    bool _isTextFieldFilled = false; // 1. Create a boolean to store the text field value
  // 1. Cree un booleano para almacenar el valor del campo de texto


  bool _isObscure = true; // 2. Create a boolean to store the obscure text value


  @override
  void dispose() {
    super.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;


  


    return Scaffold(
      appBar: AppBar(
        title: const Text('Password Strength Checker'),
      ),
      body:  Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               SizedBox(height: size.height * 0.3),
              TextField(
                obscureText: _isObscure,
                controller: _passwordController,
                decoration:  InputDecoration(
                  hintText: 'Password',
                  filled: true,
                  border: 
                  const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    borderSide: BorderSide.none,
                  ),
                  //icono de la contraseña
                  prefixIcon: const Icon(Icons.lock, color: Colors.white,),
                  //ver la contraseña
                  suffixIcon: 
                  //btn para ver la contraseña
                  IconButton(
                    icon: Icon(
                      _isObscure ? Icons.visibility : Icons.visibility_off,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      setState(() {
                        _isObscure = !_isObscure;
                      });
                    },
                  ),
                ),
                onChanged: (value) {
                  // 2. Update the _isTextFieldFilled boolean
                  // 2. Actualice el booleano _isTextFieldFilled
                  setState(() {
                    _isTextFieldFilled = value.isNotEmpty;
                  });
                },
              ),
              const SizedBox(height: 16.0),
              // 4. Wrap the PasswordStrengthChecker widget with AnimatedBuilder
              // 4. Envuelva el widget PasswordStrengthChecker con AnimatedBuilder
          
          
            // AnimatedBuilder aparece solo cuando _isTextFieldFilled es verdadero
              if (_isTextFieldFilled)
              AnimatedBuilder(
                animation: _passwordController,
                builder: (context, child) {
                  // 5. Get the password value from the TextEditingController
                  // 5. Obtenga el valor de la contraseña del TextEditingController
                  final password = _passwordController.text;
                  // 6. Return the PasswordStrengthChecker widget
                  // 6. Devuelve el widget PasswordStrengthChecker
                  return PasswordStrengthChecker(
                    onStrengthChanged: (bool value) {
                      // 7. Update the _isStrong boolean
                      // 7. Actualice el booleano _isStrong
                      setState(() {
                        _isStrong = value;
                      });
                    },
                    password: password,
                  );
                },
              ),
              const SizedBox(height: 24.0),
              Center(
                child: 
                
            
          
                ElevatedButton(
                  //dise˜no del boton
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white, backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    //tamaño del boton
                    minimumSize: const Size(200, 50),
                    //sombras
                    elevation: 10,
          
                  ),
                  onPressed: _isStrong ? () {
                  } : null,
                  child: const Text('Submit', style: TextStyle(fontSize: 20, color: Colors.deepPurple )),
                ),
              ),
          
              //Text
               SizedBox(height: size.height * 0.2),
              //texto de desarrollado por Baneste Codes
              const Center(
                child: Text(
                  'Developed by Baneste Codes',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                  ),
                ),
              ),
            ],
          ),
        ),
    );
  }
}
