import 'package:flutter/material.dart';
import 'package:project_property/newProperty/addNewHome.dart';
import 'package:project_property/page/Details.dart';
import 'package:project_property/user/color/color.dart';
import 'package:http/http.dart' as http;

import '../../Home.dart';

class ImageCover extends StatefulWidget {
  final urlImage;
 var fun;
 var icon;
  ImageCover(this.urlImage,this.fun,this.icon);

  @override
  _ImageCoverState createState() => _ImageCoverState();
}

class _ImageCoverState extends State<ImageCover> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      height: size.height * 0.35,
      decoration: BoxDecoration(
        color: black,
      ),
      child: Stack(
        children: [
          Image(
            width: double.infinity,
            image: NetworkImage("https://propertymanagment.000webhostapp.com/uploads/${widget.urlImage}"),
            fit: BoxFit.cover,
          ),
          Positioned(
            top: -45,
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 20.0, top: 70),
              child: Container(
                height: size.height * 0.26,
                width: size.width - 15,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                      IconButton(icon:Icon(Icons.arrow_back),onPressed: this.widget.fun,
                      ),
                        icon(this.widget.icon,(){
                          this.widget.icon==Icons.favorite?(){}:update();

                        }),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget icon(var icon, var tap) {
    return InkWell(
      onTap: tap,
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white.withOpacity(0.4)),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Icon(
          icon,
          size: 25,
          color: white,
        ),
      ),
    );
  }
  Delete() async {

    var data = {
      "id": DetailsPage.id,


    };
    print(data['id']);
    var url = "https://propertymanagment.000webhostapp.com/update.php";
    var response = await http.post(Uri.parse(url), body: data);
    //var req =  jsonDecode(response.body);

    if (response.statusCode == 200) {

      // ignore: deprecated_member_use
      print("Upload successfulR");


      // ignore: deprecated_member_use

    } else {
      print("Upload isn't successfulR");
    }
  }
  update()
  {
    Delete();
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) =>addNewHome()));
  }
}
