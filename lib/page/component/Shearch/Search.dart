import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_property/user/color/color.dart';


class NotFound extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.grey.withOpacity(0.2),
        appBar: null,
        body: Container(
          width: size.width,
          height: size.height,
          child: Center(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.search_outlined,
                    color: Colors.black54.withOpacity(0.5),
                    size: 140,
                  ),
                  Text(
                    "Sorry,We didn't find any results\n     "
                    "  Matching this result ",
                    style: TextStyle(
                      color: Colors.black54.withOpacity(0.6),
                      height: 1.5,
                      fontSize: 20,
                      letterSpacing: 1.1,
                    ),
                    maxLines: 2,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
