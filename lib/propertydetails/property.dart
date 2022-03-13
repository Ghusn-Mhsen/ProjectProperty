class property {
  //var id;
 // var userId;
  var phone;
  var area;
  var llocation;
  var price;
 var imagee;
 var descreptionn;
 var stat;
 var id;
  property(
      {
       // this.id,
        this.phone,
        this.area,
        this.descreptionn,
        this.price,
        this.llocation,
        this.imagee,
        this.stat,
        this.id
    //    this.path
      });
   factory property.fromjson(Map<String, dynamic> js) {
    return property(
      id: js['id'],
        area: js['area'],
        llocation: js['llocation'],
        imagee: js['imagee'],
        phone: js['phone'],
        price: js['price'],
        descreptionn: js['descreptionn'],
      stat: js['stat']
    );
  }
  Map<String, dynamic> tojson() => {
        //'id': id,
        "phone": phone,
        "area": area,
        "llocation": llocation,
        "price": price,
     //   "path": path
      };


}
