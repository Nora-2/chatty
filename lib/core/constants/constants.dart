// ignore_for_file: non_constant_identifier_names, camel_case_types, avoid_print

import 'package:flutter/material.dart';
import 'package:scholar_chat/core/constants/colorconstant.dart';
import 'package:scholar_chat/core/constants/image_constant.dart';

 
class AppMessage {
  AppMessage._();

static List<Map<String, String>> infodata = [
  {
    'titel': 'How can users utilize the program to research drug toxicity ?',
    'subtitel':
        'Users can input drug information via SMILES or images to investigate its toxicity'
 
  },
   {
    'titel':
            'How are the toxicity results presented to users, and what specific information do they receive ?',
        
        'subtitel':
            'Results are displayed, indicating whether the drug is toxic or non-toxic, along with SA Score and Tox Score.',
  }, {
    'titel':
            'How does the program handle the Mutagenicity analysis, and what are the expected results?',
        'subtitel':
            'The Mutagenicity analysis processes SMILES input and provides information on whether the substance is mutagenic or not.',
     
  }, {
    'titel':
            'How can the user check if the drug induces liver injury (DILI) ,and what are the expected results?',
        'subtitel':
            'Users can input SMILES to check its ability to induce liver injury, and the program outputs either positive or negative results',
     
  }, {
     'titel':
            "What is the significance and usage of SA Score and Tox Score in the program's results?",
        'subtitel':
            "SA Score and Tox Score provide insights into the drug's safety ,helping users interpret drug potential toxicity and its probability to be synthesized",
    
  }, {
      'titel':
            "Is Toxikon available to the general public, or is it targeted towards a specific group of researchers or specialists?",
        'subtitel':
            "Toxikon is accessible to both the general public and specific groups of researchers or specialists.",
     
  }
  , {
      'titel':
            "What technologies or methods does Toxikon use in drug toxicity research?",
        'subtitel':
            "Toxikon employs advanced technologies and methods for comprehensive drug toxicity research.",
    
  }
];
  static ScaffoldFeatureController<SnackBar, SnackBarClosedReason>
      customSnackBar(
          {required BuildContext context,
          required String content,
          Color backgroundColor = icolor}) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(content),
        backgroundColor: backgroundColor,
      ),
    );
  }
}

// ignore: must_be_immutable
class socialmedia extends StatelessWidget {
  // final GoogleSignIn googleSignIn = new GoogleSignIn();

 
 const socialmedia({Key? key, 
  
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            // signInWithFacebook();
          },
          child: Image.asset(
            ImageConstant.facebook,
            width: 35,
            height: 35,
          ),
        ),
        SizedBox(
          width: size.width * .09,
        ),
        GestureDetector(
          onTap: () async{
           
                AppMessage.customSnackBar(
        context: context,
        content: 'An error occurred while signing in with Google. Please try again.',
      );
           

          },
          child: Image.asset(
            ImageConstant.google,
            width: 35,
            height: 35,
          ),
        ),
        SizedBox(
          width: size.width * .09,
        ),
        Image.asset(
          ImageConstant.twitter,
          width: 35,
          height: 35,
        )
      ],
    );
  }
}

class seprator extends StatelessWidget {
  const seprator({Key? key, 

    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: 1,
          width: size.width * .4,
          decoration: const BoxDecoration(
            color: Colors.grey,
          ),
        ),
        const Text('or',
            style: TextStyle(
                fontFamily: 'sanchez',
                fontWeight: FontWeight.w500,
                fontSize: 16)),
        Container(
          height: 1,
          width: size.width * .4,
          decoration: const BoxDecoration(
            color: Colors.grey,
          ),
        )
      ],
    );
  }
}
const kPrimaryColor = Color(0xff2B475E);
String kCollection = 'messages';