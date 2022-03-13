import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:project_property/Basic%20Ui/home.dart';
import 'package:project_property/page/Home.dart';
import 'package:shared_preferences/shared_preferences.dart';

class addNewHome extends StatefulWidget {
  @override
  _addNewHomeState createState() => _addNewHomeState();
}

class _addNewHomeState extends State<addNewHome> {

  File _image;
  final picker = ImagePicker();
  var pickedFile;
  var color = Colors.black54;
   int checkBox;
  var phone;
  var price;
  var _token;
  var llocation;
  var area;
  var descreptionn;
  var stat;
  var iduser;
  var phoneController=TextEditingController();
  var descreptionController=TextEditingController();
  var priceController=TextEditingController();
  var llocationController=TextEditingController();
  final FormKey = GlobalKey<FormState>();
  var areaController=TextEditingController();
  var Scaf = GlobalKey<ScaffoldState>();
  Future getImage() async {
    pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
        if(pickedFile!=null)
        _image = File(pickedFile.path);
         else print("NO IMAGE SELECTED");

    });
  }
  Future<int> getData() async {

    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      iduser = pref.getString("id");

    }
    );
  }
  Future getImageFromCamera() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);
    setState(() {
      if(pickedFile!=null)
        _image = File(pickedFile.path);
      else print("NO IMAGE SELECTED");
    });
  }
  @override
  void initState() {
    getData();
    getUserToken();
    // TODO: implement initState
    super.initState();
  }
 @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
        fit: BoxFit.fill,
        image: AssetImage("images/1.jpg"),
      )),
      child: Scaffold(
       backgroundColor: Colors.transparent,
        appBar: AppBar(
elevation: 120,
          backgroundColor: Colors.transparent,


          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(right:8.0),
                child: FloatingActionButton(

                    backgroundColor: Colors.transparent,
                    elevation: 100,
                    child:  Icon(Icons.arrow_back,color: color,size: 40,),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Home()));
                    }
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left:8.0),
                child: FloatingActionButton(
                    backgroundColor: Colors.transparent,
                    elevation: 100,
                    child:  Icon(Icons.backup_outlined,color: color,size: 40,),
                    onPressed: () {
                      if(FormKey.currentState.validate())
                      {
                        if(check()) {

                          RegisterHome();
                          Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Home()));
                        }
                        else{
                          showDialog(context: context,builder: (context) {
                            return AlertDialog(
                              title: Text("نقص في الإدخال:"),
                              content: Text("تحقق من أنك رفعت صورة و حددت نوع الاستثمار(بيع أو إيجار)"),
                              actions: [
                                Column(
                                  children: [
                                    RaisedButton(
                                        child:Text("سأحلها"),
                                        onPressed: (){
                                          Navigator.of(context).pop();//to exit of alert

                                        }),
                                  ],
                                ),
                              ],
                            );


                          });


                        }
                      }
                    }
                ),
              )
            ],
          ),

        ),
        body: Container(
          child: SafeArea(
            child: SingleChildScrollView(
              child: Form(
                key: FormKey,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                       child:SingleChildScrollView(
                       child:  Column(
                       children: [





                      Container(
                        child: Padding(
                          padding: const EdgeInsets.only(top:4.0),
                          child: Row(
                            children: [
                              Container(
                                child: IconButton(
                                  icon:
                                  Icon(Icons.add_photo_alternate_outlined),
                                  color: color,
                                  iconSize: 50,
                                  onPressed: () {
                                    getImage();

                                  },


                                ),
                                margin: EdgeInsets.only(left: 20),
                              ),
                              Container(
                                child: IconButton(
                                  icon: Icon(Icons.photo_camera),
                                  color: color,
                                  iconSize: 50,
                                  onPressed: () {
                                    getImageFromCamera();

                                  },
                                ),
                                margin: EdgeInsets.only(right: 20, left: 20),
                              ),


                            ],
                          ),
                        ),
                        margin: EdgeInsets.only(bottom: 2, left: 100),
                      ),



                      Container(

                        child: Row(children: [

                          Padding(

                            padding: const EdgeInsets.only(left:75.0),
                            child: Radio(value: 1,groupValue:checkBox,focusColor: Colors.black54, onChanged: (value){
                              setState(() {

                                checkBox=value;
                                stat="بيع";
                              });
                            },

                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right:100.0),
                            child: Text('بيع'),
                          ),
                          Radio(value: 2,groupValue:checkBox,onChanged: (value){
                            setState(() {
                              checkBox=value;
                              stat="إيجار";
                            });
                          },

                          ),
                          Text('إيجار'),
                        ],),
                      ),
                      Container(
                        child: TextFormField(
                          validator: checkPhone,
                          maxLength: 15,
                          controller: phoneController,
                          keyboardType: TextInputType.streetAddress,
                          style: TextStyle(color: Colors.cyan),
                          decoration: InputDecoration(

                              icon: Icon(
                                Icons.phone_android,
                                color: color,
                              ),
                              prefixText: "+",
                              prefixStyle: TextStyle(color: Colors.cyan),
                              border: new OutlineInputBorder(
                                borderRadius:
                                BorderRadius.all(Radius.circular(18)),
                              ),
                              hintText: "أدخل رقم الهاتف ً",
                              hintStyle: TextStyle(color: color),
                              labelStyle: TextStyle(color: color),
                              labelText: 'Phone',

                              suffixStyle: TextStyle(color: Colors.cyan)),
                          // onChanged: (value)
                          // {
                          //   setState(() {
                          //     phone=value;
                          //   });
                          // },
                        ),
                        margin: EdgeInsets.only(bottom:2),
                      ),
                      Container(
                        child: TextFormField(
                          maxLength: 15,
                          controller: priceController,
                          validator: checkPrice,
                          keyboardType: TextInputType.streetAddress,
                          style: TextStyle(color: Colors.cyan),
                          decoration: InputDecoration(
                            icon: Icon(
                              Icons.monetization_on_outlined,
                              color: color,
                            ),
                            border: new OutlineInputBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(18)),
                            ),
                            hintText: "أدخل السعرً",
                            hintStyle: TextStyle(color: color),
                            labelStyle: TextStyle(color: color),
                            labelText: 'Price',
                            suffixStyle: TextStyle(color: Colors.cyan),
                            suffixText: '\$',
                          ),
                          // onChanged: (value)
                          // {
                          //   setState(() {
                          //     price=value ;
                          //   });
                          // },
                        ),

                        margin: EdgeInsets.only(bottom: 2),

                      ),

                      Container(
                        child: TextFormField(
                          maxLength: 50,
                          validator: checkLocation,
                          controller: llocationController,
                          keyboardType: TextInputType.streetAddress,
                          style: TextStyle(color: Colors.cyan),
                          decoration: InputDecoration(
                            icon: Icon(
                              Icons.add_location_alt,
                              color: color,
                            ),
                            border: new OutlineInputBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(18)),
                            ),
                            hintText: "أدخل الموقع",
                            hintStyle: TextStyle(color: color),
                            labelStyle: TextStyle(color: color),
                            labelText: 'Location',


                          ),
                          // onChanged: (value)
                          // {
                          //   setState(() {
                          //    llocation=value;
                          //   });
                          // },
                        ),
                        margin: EdgeInsets.only(bottom: 2),
                      ),
                      Container(
                        child: TextFormField(
                          maxLength: 8,
                          controller: areaController,
                          validator: checkArea,
                          keyboardType: TextInputType.streetAddress,
                          style: TextStyle(color: Colors.cyan),
                          decoration: InputDecoration(
                              icon: Icon(
                                Icons.home_work,
                                color: color,
                              ),
                              border: new OutlineInputBorder(
                                borderRadius:
                                BorderRadius.all(Radius.circular(18)),
                              ),
                              hintText: "أدخل مساحة العقار",
                              hintStyle: TextStyle(color: color),
                              labelStyle: TextStyle(color: color),
                              labelText: 'Area',
                              suffixStyle: TextStyle(color: Colors.red),
                              suffixText: "m*m"),
                          // onChanged: (value)
                          // {
                          //   setState(() {
                          //     area=value;
                          //   });
                          // },
                        ),
                        margin: EdgeInsets.only(bottom: 2),
                      ),
                      Container(
                      //////////  height: 300,
                        child: TextFormField(
                          validator: checkDesc,
                          maxLength: 120,
                          controller: descreptionController,
                          maxLines: 3,
                          keyboardType: TextInputType.streetAddress,
                          style: TextStyle(color:Colors.cyan),
                          decoration: InputDecoration(
                            icon: Icon(
                              Icons.comment,
                              color: color,
                            ),
                            border: new OutlineInputBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(18)),
                            ),
                            hintText: "أدخل وصف العقار",
                            hintStyle: TextStyle(color: color),
                            labelStyle: TextStyle(color: color),
                            labelText: 'descreptionn',

                          ),
                          // onChanged: (value)
                          // {
                          //   setState(() {
                          //     descreptionn=value;
                          //   });
                          // },
                        ),



                      ),




                      ],
                    ),),


                    ),

                  ],
                ),
              ),
            ),
          ),
        ),


      ),
    );
  }
  Future RegisterHome() async {

      String base64 = base64Encode(_image.readAsBytesSync());
      String imagename = _image.path.split('/').last;
      phone = phoneController.text;
      area = areaController.text;
      llocation = llocationController.text;
      price = priceController.text;
      descreptionn = descreptionController.text;
      var data = {
        "phone": phone,
        "area": area,
        "llocation": llocation,
        "price": price,
        "descreptionn": descreptionn,
        "stat": stat,
        "imagename": imagename,
        "image64": base64,
        "iduser":iduser,
        "token":_token,
      };

      var url = "https://propertymanagment.000webhostapp.com/upload.php";

      var response = await http.post(Uri.parse(url), body: data);


     if (response.statusCode == 200) {

        // ignore: deprecated_member_use
        print("Upload successfulR");


        // ignore: deprecated_member_use

      } else {
        print("Upload isn't successfulR");
      }

      }
  bool check()
      {
        if(stat.toString().length==0||stat==null||_image==null)
          return false;

          else
          return true;
      }
  String checkPhone(String value) {
    if (value.isEmpty) return " Phone can't empty";
    if (value.contains(" ")) {
      return "Phone can't contain space";
    }
    if (value.length < 10) {
      return "Phone can't be\nless than 10 numbers ";
    }
    if (value.length > 15) {
      return "Phone can't be\nmore than 15 numbers ";
    }
  }
  String checkPrice(String value) {
    if (value.isEmpty) return " Price can't empty";
    if (value.contains(" ")) {
      return "Price can't contain space";
    }

    if (value.length > 15) {
      return "Price can't be\nmore than 15 numbers ";
    }
  }
  String checkLocation(String value) {
    if (value.isEmpty) return " Location can't empty";


    if (value.length > 50) {
      return "Location can't be\nmore than 50 numbers ";
    }
  }
  String checkArea(String value) {
    if (value.isEmpty) return " Area can't empty";
    if (value.length < 2) {
      return "Area can't be\nless than 2 numbers ";
    }

    if (value.length > 10) {
      return "Area can't be\nmore than 10 numbers ";
    }
  }
  String checkDesc(String value) {
    if (value.isEmpty) return " Description can't empty";
    if (value.length < 4) {
      return "Area can't be\nless than 4 numbers ";
    }

    if (value.length > 120) {
      return "Area can't be\nmore than 120 numbers ";
    }
  }
  Future<void>  getUserToken() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {

      _token = pref.getString("token")??"000";
    });

  }
}
