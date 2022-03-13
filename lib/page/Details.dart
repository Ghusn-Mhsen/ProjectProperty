import 'package:flutter/material.dart';
import 'package:project_property/newProperty/addNewHome.dart';
import 'package:url_launcher/url_launcher.dart';
import 'Data/propertylist.dart';
import 'component/detailsPage/DetailsInfo.dart';
import 'component/detailsPage/ListButton.dart';
import 'component/detailsPage/houseInfo.dart';
import 'component/detailsPage/imageCover.dart';
import 'component/home/ButtonBottom.dart';
import 'package:http/http.dart' as http;
class DetailsPage extends StatefulWidget {
    var house;
var fun;
var icon;
   static var id;
   DetailsPage({this.house,this.fun,this.icon});

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
var phone;
var whatsappurl;
var callurl;

  @override
  void initState() {
    // TODO: implement initState
     phone=widget.house['phone'];
     DetailsPage.id=widget.house['id'];
     whatsappurl="whatsapp://send?phone=$phone";
     callurl="tel://$phone";
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: null,
        body: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Column(
              children: [
                ImageCover(widget.house['imagee'],this.widget.fun,this.widget.icon),
                DetailsInfo(house:widget.house),
                ListButton(house:widget.house),
                HouseInfo(house:widget.house),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ButtonBottom(icon: Icons.chat,function: () async {
                  try {
                    await canLaunch(whatsappurl)
                        ? await launch(whatsappurl)
                        : throw("error");
                  }
                  catch(e)
                  {
                    print(e.toString());
                  }
                  },txt:"Chat"),
                ButtonBottom(icon: Icons.call_end_rounded,function: () async {
                  try {
                    await canLaunch(callurl)
                        ? await launch(callurl)
                      : throw("error");
                  }
                  catch(e)
                  {
                  print(e.toString());
                  }
                },txt:"Call"),
              ],
            ),
          ],
        ),
      ),
    );
  }

}
