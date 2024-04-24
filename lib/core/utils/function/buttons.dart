// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:scholar_chat/core/constants/colorconstant.dart';

class customButtonContainer extends StatelessWidget {
  const customButtonContainer({Key? key, 
    
    required this.size,
    required this.text,
  }) : super(key: key);

  final Size size;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 38,
      width: size.width * .8,
      decoration: BoxDecoration(
        color: kcolor,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Center(
        child: Text(text,
            style: const TextStyle(
              fontFamily: 'sanchez',
              fontWeight: FontWeight.w500,
              fontSize: 18,
              color: Colors.white,
            )),
      ),
    );
  }
}

class submit extends StatelessWidget {
  const submit({Key? key, 
    
    required this.size,
    required this.isDark,
  }) : super(key: key);

  final Size size;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44,
      width: size.width * .95,
      decoration: BoxDecoration(
        color: isDark ? darkcolor : icolor,
        borderRadius: BorderRadius.circular(15),
      ),
      child:const Center(
        child: Text(
          'Submit',
          style:
                   TextStyle(fontFamily: 'sanchez',fontWeight: FontWeight.w500, fontSize: 22)),
        
      ),
    );
  }
}

class save extends StatefulWidget {
  const save({Key? key, 
    
    required this.size,
    required this.isDark,
  }) : super(key: key);

  final Size size;
  final bool isDark;

  @override
  State<save> createState() => _saveState();
}

class _saveState extends State<save> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44,
      width: widget.size.width * .95,
      decoration: BoxDecoration(
        color: widget.isDark ? darkcolor : icolor,
        borderRadius: BorderRadius.circular(15),
      ),
      child:const Center(
        child: Text(
          'Save',
          style:
                   TextStyle(fontFamily: 'sanchez',fontWeight: FontWeight.w500, fontSize: 22)),
        
      ),
    );
  }
}
