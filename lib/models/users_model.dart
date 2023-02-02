import 'dart:convert';

class UserModel {
  String? fname;
  String? lname;
  String? level;
  String? address;
  String? subdistrict;
  String? district;
  String? province;
  String? zipcode;
  String? phone;
  String? email;
  String? password;
  String? images;
  String? token;

  UserModel({
    required this.fname,
    required this.lname,
    required this.level,
    required this.address,
    required this.subdistrict,
    required this.district,
    required this.province,
    required this.zipcode,
    required this.phone,
    required this.email,
    required this.password,
    required this.images,
    required this.token,
  });

  UserModel copyWith({
    String? fname,
    String? lname,
    String? level,
    String? address,
    String? subdistrict,
    String? district,
    String? province,
    String? zipcode,
    String? phone,
    String? email,
    String? password,
    String? images,
    String? token,
  }) {
    return UserModel(
      fname: fname ?? this.fname,
      lname: lname ?? this.lname,
      level: level ?? this.level,
      address: address ?? this.address,
      subdistrict: subdistrict ?? this.subdistrict,
      district: district ?? this.district,
      province: province ?? this.province,
      zipcode: zipcode ?? this.zipcode,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      password: password ?? this.password,
      images: images ?? this.images,
      token: token ?? this.token,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'fname': fname,
      'lname': lname,
      'level': level,
      'address': address,
      'subdistrict': subdistrict,
      'district': district,
      'province': province,
      'zipcode': zipcode,
      'phone': phone,
      'email': email,
      'password': password,
      'images' : images,
      'token' : token,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    if (map == null) return null!;

    return UserModel(
      fname: map['fname'],
      lname: map['lname'],
      level: map['level'],
      address: map['address'],
      subdistrict: map['subdistrict'],
      district: map['district'],
      province: map['province'],
      zipcode: map['zipcode'],
      phone: map['phone'],
      email: map['email'],
      password: map['password'],
      images: map['images'],
      token:  map['token'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));

  @override
  String toString() =>
      'UserModel(fname: $fname, lname: $lname, level: $level, address: $address, subdistrict: $subdistrict, district: $district, province: $province, zipcode: $zipcode, phone: $phone, email: $email, password: $password, images: $images, token: $token )';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is UserModel &&
        o.fname == fname &&
        o.lname == lname &&
        o.level == level &&
        o.address == address &&
        o.subdistrict == subdistrict &&
        o.district == district &&
        o.province == province &&
        o.zipcode == zipcode &&
        o.phone == phone &&
        o.email == email &&
        o.password == password &&
        o.images == images &&
        o.token == token;
  }

  @override
  int get hashCode =>
      fname.hashCode ^
      lname.hashCode ^
      level.hashCode ^
      address.hashCode ^
      subdistrict.hashCode ^
      district.hashCode ^
      province.hashCode ^
      zipcode.hashCode ^
      phone.hashCode ^
      email.hashCode ^
      password.hashCode ^
      images.hashCode ^
      token.hashCode;
}
