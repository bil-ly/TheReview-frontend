class User {
  final String id;
  final String fullName;
  final String email;
  final String? profileImageUrl;
  final List<String>? linkedAccounts;

  User({
    required this.id,
    required this.fullName,
    required this.email,
    this.profileImageUrl,
    this.linkedAccounts,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as String,
      fullName: json['fullName'] as String,
      email: json['email'] as String,
      profileImageUrl: json['profileImageUrl'] as String?,
      linkedAccounts: (json['linkedAccounts'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fullName': fullName,
      'email': email,
      'profileImageUrl': profileImageUrl,
      'linkedAccounts': linkedAccounts,
    };
  }

  User copyWith({
    String? id,
    String? fullName,
    String? email,
    String? profileImageUrl,
    List<String>? linkedAccounts,
  }) {
    return User(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      linkedAccounts: linkedAccounts ?? this.linkedAccounts,
    );
  }
}
