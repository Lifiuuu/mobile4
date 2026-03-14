class AddressModel {
  final String street;
  final String city;
  final String state;
  final String zipCode;

  AddressModel({
    required this.street,
    required this.city,
    required this.state,
    required this.zipCode,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      street: json['street'] ?? '',
      city: json['city'] ?? '',
      state: json['state'] ?? '',
      zipCode: json['zipCode'] ?? json['zipcode'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'street': street,
      'city': city,
      'state': state,
      'zipCode': zipCode,
    };
  }
}

class DosenModel {
  final int id;
  final String nama;
  final String username;
  final String email;
  final AddressModel address;

  DosenModel({
    required this.id,
    required this.nama,
    required this.username,
    required this.email,
    required this.address,
  });

  factory DosenModel.fromJson(Map<String, dynamic> json) {
    return DosenModel(
      id: json['id'] ?? 0,
      nama: json['nama'] ?? json['name'] ?? '',
      username: json['username'] ?? '',
      email: json['email'] ?? '',
      address: AddressModel.fromJson(json['address'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nama': nama,
      'username': username,
      'email': email,
      'address': address.toJson(),
    };
  }
}