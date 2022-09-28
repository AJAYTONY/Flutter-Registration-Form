class RegisterInfo{
  late String firstName;
  late String lastName;
  late String email;
  late String password;
  late String confirmPassword;
  late int mobileNumber;
  late String? image;

  RegisterInfo({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.confirmPassword,
    required this.mobileNumber,
    this.image,

  });

}