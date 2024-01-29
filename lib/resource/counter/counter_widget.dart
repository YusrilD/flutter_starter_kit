import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/*
Author : Yusril Dewantara
Email : yusrildewantara2@gmail.com
Description: this class is reusable counter widget, with plus and minus button, 
it also support changing value by filling text
 */

// ignore: must_be_immutable
class CounterWidget extends StatelessWidget {
  CounterWidget({
    Key? key,
    required this.icon,
    this.label = "",
    required this.keyMap,
    required this.value,
    this.validate,
    this.onAdd,
    this.onSubtract,
    this.mainColor = Colors.blue,
  }) : super(key: key);

  IconData icon;
  String label;
  String keyMap;
  TextEditingController value;
  Function(bool val)? validate;
  Function()? onAdd;
  Function()? onSubtract;
  Color mainColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: mainColor,
              ),
              child: Icon(
                icon,
                color: Colors.white,
              ),
            ),
            SizedBox(width: 5),
            Text(
              label,
              style: GoogleFonts.lato(
                fontSize: 18,
                color: Colors.black,
              ),
            ),
          ],
        ),
        _counter(key: keyMap, value: value),
      ],
    );
  }

  _counter({
    String key = "",
    required TextEditingController value,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Color(0xFFADADAD),
          width: 0.5,
        ),
      ),
      child: Row(
        children: [
          InkWell(
            onTap: onSubtract,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(6),
                  bottomLeft: Radius.circular(6),
                ),
                color: mainColor,
              ),
              padding: EdgeInsets.all(6),
              alignment: Alignment.center,
              child: Icon(
                Icons.remove,
                color: Colors.white,
              ),
            ),
          ),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: SizedBox(
              width: 50,
              height: 30,
              child: TextField(
                controller: value,
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey,
                ),
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  border: InputBorder.none,
                ),
              ),
            ),
            // Text(
            //   value,
            //   style: GoogleFonts.lato(
            //     fontSize: 18,
            //     color: Colors.grey,
            //   ),
            // ),
          ),
          InkWell(
            onTap: onAdd,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(6),
                  bottomRight: Radius.circular(6),
                ),
                color: mainColor,
              ),
              padding: EdgeInsets.all(6),
              alignment: Alignment.center,
              child: Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
