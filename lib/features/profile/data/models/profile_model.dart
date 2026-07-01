class ProfileModel {
  final int id;
  final String name;
  final String? nickname;
  final String email;
  final String phone;
  final String? emailVerifiedAt;
  final String? birthDate;
  final String? gender;
  final String? photoUrl;
  final int? avatarId;
  final String? city;
  final String? currency;
  final int coins;
  final int trips;

  ProfileModel({
    required this.id,
    required this.name,
    this.nickname,
    required this.email,
    required this.phone,
    this.emailVerifiedAt,
    this.birthDate,
    this.gender,
    this.photoUrl,
    this.avatarId,
    this.city,
    this.currency,
    required this.coins,
    required this.trips,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      nickname: json['nickname'],
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      emailVerifiedAt: json['email_verified_at']?.toString(),
      birthDate: json['birth_date'],
      gender: json['gender'],
      photoUrl: json['photo_url'],
      avatarId: json['avatar_id'],
      city: json['city'],
      currency: json['currency'],
      coins: json['coins'] ?? 0,
      trips: json['trips'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'nickname': nickname,
      'email': email,
      'phone': phone,
      'email_verified_at': emailVerifiedAt,
      'birth_date': birthDate,
      'gender': gender,
      'photo_url': photoUrl,
      'avatar_id': avatarId,
      'city': city,
      'currency': currency,
      'coins': coins,
      'trips': trips,
    };
  }

  ProfileModel copyWith({
    int? id,
    String? name,
    String? nickname,
    String? email,
    String? phone,
    String? emailVerifiedAt,
    String? birthDate,
    String? gender,
    String? photoUrl,
    int? avatarId,
    String? city,
    String? currency,
    int? coins,
    int? trips,
  }) {
    return ProfileModel(
      id: id ?? this.id,
      name: name ?? this.name,
      nickname: nickname ?? this.nickname,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      emailVerifiedAt: emailVerifiedAt ?? this.emailVerifiedAt,
      birthDate: birthDate ?? this.birthDate,
      gender: gender ?? this.gender,
      photoUrl: photoUrl ?? this.photoUrl,
      avatarId: avatarId ?? this.avatarId,
      city: city ?? this.city,
      currency: currency ?? this.currency,
      coins: coins ?? this.coins,
      trips: trips ?? this.trips,
    );
  }
  
  bool get isEmailVerified =>
      emailVerifiedAt != null &&
      emailVerifiedAt!.isNotEmpty &&
      emailVerifiedAt!.toLowerCase() != 'null';
  
  // Helper method to get avatar path
  String? get avatarPath {
    if (avatarId != null) {
      return 'assets/images/png/avatars/$avatarId.png';
    }
    return null;
  }
}

