import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:real_track/core/constante/constant_var/const_var.dart';
import 'package:real_track/core/constante/forms/customer_forms.dart';

class MyFormNavigator extends StatefulWidget {
  @override
  _MyFormNavigatorState createState() => _MyFormNavigatorState();
}

class _MyFormNavigatorState extends State<MyFormNavigator> {
  int currentFormIndex = 0;
  List<bool> formValidations = [false, false, false];     // Utilisez cette liste pour suivre la validation de chaque formulaire

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Formulaire Navigator'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (currentFormIndex == 0)
            MyForm(
              formIndex: currentFormIndex,
              onFormSubmitted: (isValid) {
                setState(() {
                  formValidations[currentFormIndex] = isValid;
                  if (isValid) {
                    currentFormIndex++;
                  }
                });
              },
            ),

          if (currentFormIndex == 1)
            MyForm(
              formIndex: currentFormIndex,
              onFormSubmitted: (isValid) {
                setState(() {
                  formValidations[currentFormIndex] = isValid;
                  if (isValid) {
                    currentFormIndex++;
                  }
                });
              },
            ),

          if (currentFormIndex == 2)
              MyForm(
              formIndex: currentFormIndex,
              onFormSubmitted: (isValid) {
                setState(() {
                  formValidations[currentFormIndex] = isValid;
                  // Ajoutez ici le code pour la suite ou la validation finale
                });
              },
            ),
            
          if (currentFormIndex == 3)
            // Vous pouvez ajouter d'autres formulaires ici selon vos besoins
            Text('Formulaire finalisé'),
        ],
      ),
    );
  }
}

class MyForm extends StatelessWidget {
  final int formIndex;
  final Function(bool) onFormSubmitted;
  MyForm({required this.formIndex, required this.onFormSubmitted});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Formulaire $formIndex'),
          // Ajoutez ici les champs de formulaire nécessaires
          TextFormField(
            // Ajoutez ici les propriétés du champ de formulaire
            decoration: InputDecoration(labelText: 'Champ de formulaire'),
            validator: (value) {
              // Ajoutez ici la logique de validation du formulaire
              return value == null || value.isEmpty ? 'Champ obligatoire' : null;
            },
          ),
          SizedBox(height: 16),

          ElevatedButton(
            onPressed: () {
              // Simulez la validation du formulaire ici
              bool isValid = true; // Remplacez par votre logique de validation réelle
              onFormSubmitted(isValid);
            },
            child: Text('Next'),
          ),
        ],
      ),
    );
  }
}