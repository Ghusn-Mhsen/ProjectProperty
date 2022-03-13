class House {

  bool isFav;
  var phone;
  var area;
  var llocation;
  var price;
  var imagee;
  var descreptionn;
  var stat;
  var id;
  House({
  this.id,this.price,this.stat,this.imagee,this.descreptionn,this.phone,this.llocation,this.area,
    this.isFav
  });
}



final List<House> houseList = [];


List<String> categoryList = [
  '<\$220.00',
  'For Sale',
  '3-4 bed room',
  'Garages',
  'Modular kitchen'
];
