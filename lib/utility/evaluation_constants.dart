class Evaluation {
  List<String> papersize = [
    "A4 ขนาด 21 X 29.7 cm",
    "A5 ขนาด 14.8 X 21 cm",
    "B5 ขนาด 18.2 X 25.7 cm"
  ];

  List<String> papertype = ["กระดาษปอนด์", "กระดาษอาร์ต", "กระดาษถนอมสายตา"];

  List<String> printingtype = ["ขาว-ดำ(หน้า-หลัง)", "ขาว-ดำ(หน้าเดียว)", "4สี"];

  List<String> bookbinding = [
    "ไสสันทากาว",
    "เย็บกลาง/เย็บมุงหลังคา",
    "สันห่วง/ขดลวด"
  ];

  List<int> bookbindingvalue = [15, 25, 35];

  var binding1 = ["ไสสันทากาว", 15];
  var binding2 = ["เย็บกลาง/เย็บมุงหลังคา", 25];
  var binding3 = ["สันห่วง/ขดลวด", 35];
  

  Evaluation();
}
