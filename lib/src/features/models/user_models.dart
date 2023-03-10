class UserModel {
  final String? id;
  final String fullName;
  final String phoneNumber;
  final String isOperator;

  const UserModel({
    this.id,
    required this.fullName,
    required this.phoneNumber,
    required this.isOperator,
  });

  toJson() {
    return {
      'id': id,
      'fullName': fullName,
      'phoneNumber': phoneNumber,
      'isOperator': isOperator,
    };
  }
}
