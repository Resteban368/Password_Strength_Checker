import 'package:flutter/material.dart';

class PasswordStrengthChecker extends StatefulWidget {
  const PasswordStrengthChecker({
    super.key,
    required this.password,
    required this.onStrengthChanged,
  });

  /// Password value: obtained from a text field
  //* contraseña valor: obtenido de un campo de texto
  final String password;

  /// Callback that will be called when password strength changes
  //* Callback que se llamará cuando cambie la fortaleza de la contraseña
  final Function(bool isStrong) onStrengthChanged;

  @override
  State<PasswordStrengthChecker> createState() =>
      _PasswordStrengthCheckerState();
}

class _PasswordStrengthCheckerState extends State<PasswordStrengthChecker> {

  // Anule el método didUpdateWidget, para validar la solidez de la contraseña cada vez que el widget PasswordStrengthChecker
  // sea reconstruido por su widget principal. Dentro de eso, verifique si la contraseña realmente ha cambiado, 
  //si se cambia, vuelva a validar la fuerza de la contraseña haciendo un bucle sobre el mapa de validadores predefinido: 
  //si todos coinciden, la contraseña es completamente fuerte, si no no.

  @override
  void didUpdateWidget(covariant PasswordStrengthChecker oldWidget) {
    super.didUpdateWidget(oldWidget);

    /// Check if the password value has changed
    //* Compruebe si el valor de la contraseña ha cambiado
    if (widget.password != oldWidget.password) {
      /// If changed, re-validate the password strength
      //* Si cambia, vuelva a validar la fortaleza de la contraseña
      final isStrong = _validators.entries.every(
        (entry) => entry.key.hasMatch(widget.password),
      );

      /// Call callback with new value to notify parent widget
      //* Llame al callback con un nuevo valor para notificar al widget principal
      WidgetsBinding.instance.addPostFrameCallback(
        (_) => widget.onStrengthChanged(isStrong),
      );
    }
  }

  /// Map of validators to be used to validate the password.
  ///
  ///
  /// Key: RegExp to check if the password contains a certain character type
  /// Value: Validation message to be displayed
  ///
  /// Note: You can add, remove, or change validators as per your requirements
  /// and if you are not good with RegExp, (most of us aren't), you can get help
  /// from Bard or ChatGPT to generate RegExp and validation messages.
  ///
  //*Mapa de validadores que se utilizarán para validar la contraseña.
  //* Clave: RegExp para comprobar si la contraseña contiene un cierto tipo de carácter
  //*Valor: Mensaje de validación que se mostrará
  ///
  //*Nota: puede agregar, eliminar o cambiar validadores según sus requisitos
  //* y si no eres bueno con RegExp, (la mayoría de nosotros no lo somos), puedes obtener ayuda
  //*de Bard o ChatGPT para generar RegExp y mensajes de validación.
  ///
  final Map<RegExp, String> _validators = {
    RegExp(r'[A-Z]'): 'One uppercase letter',
    RegExp(r'[!@#\\$%^&*(),.?":{}|<>]'): 'One special character',
   RegExp(r'.*[0-9].*'): 'One number',
    RegExp(r'^.{8,32}$'): '8-32 characters',
  };

  @override
  Widget build(BuildContext context) {
    /// If the password is empty yet, we'll show validation messages in plain
    /// color, not green or red
    //* Si la contraseña está vacía, mostraremos mensajes de validación en plano
    //* color, no verde o rojo
    final hasValue = widget.password.isNotEmpty;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(

      color: const Color.fromARGB(235, 255, 255, 255),
      borderRadius: BorderRadius.circular(10),

      //some shadow
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.3),
          spreadRadius: 1,
          blurRadius: 2,
          offset: const Offset(0, 1), // changes position of shadow
        ),
      ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _validators.entries.map(
          (entry) {
            /// Check if the password matches the current validator requirement
            //* Compruebe si la contraseña coincide con el requisito de validación actual
            final hasMatch = entry.key.hasMatch(widget.password);
    
            /// Based on the match, we'll show the validation message in green or
            /// red color
            //* En función de la coincidencia, mostraremos el mensaje de validación en verde o
            //* color rojo
            final color =
                hasValue ? (hasMatch ? Colors.green : Colors.red) : null;
    
            return Padding(
              padding: const EdgeInsets.only(bottom: 4.0),
              child: Text(
                entry.value,
                style: TextStyle(color: color),
              ),
            );
          },
        ).toList(),
      ),
    );
  }
}
