class LoginRequest {
  String phone;
  String password;

  LoginRequest(this.phone, this.password);
}

class RegisterRequest {
  String userName;
  String countryMobileCode;
  String mobileNumber;
  String password;
  String passwordConfirm;

  RegisterRequest(this.userName, this.countryMobileCode, this.mobileNumber,
      this.password, this.passwordConfirm);
}