mixin InputValidator {
  String? validateFirstName(String? value) {
    bool found = (value?.contains(RegExp(r'[0-9]')) ?? false);
    if (value == null || value == "") {
      return "Please Enter FirstName";
    } else if (found) {
      return "First name should not contains numbers";
    } else if (value.length > 10) {
      return "First Name is too big should contain less than 10 character";
    } else if (value.length < 3) {
      return "First Name is too short";
    }
    return null;
  }

  String? validateLastName(String? value) {
    bool found = (value?.contains(RegExp(r'[0-9]')) ?? false);
    if (value == null || value == "") {
      return "Please Enter LastName";
    } else if (found) {
      return "Last name should not contains numbers";
    } else if (value.length > 10) {
      return "Last Name is too big should contain less than 10 character";
    } else if (value.length < 3) {
      return "Last Name is too short";
    }
    return null;
  }

  String? validateMobileNumber(String? value) {
    if (value == null || value == "") {
      return "Please Enter Mobile Number";
    } else {
      final val = int.tryParse(value);
      if (value.trim().length != 10 || val == null) {
        return "Please Enter 10 digit Mobile Number";
      }
    }
    return null;
  }

  String? validateEmail(String? value) {
    String pattern =
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?)*$";

    bool found = (value?.contains(RegExp(pattern)) ?? false);
    if (value == null || value == "") {
      return "Please Enter Email";
    } else{
      if(found){
        return "Please Enter valid Email";
      }
    }

    return null;
  }

  String? validatePassword(String? value) {
    String pattern =   r"(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*\W)";
    bool found = (value?.contains(RegExp(pattern)) ?? false);

    if (value == null || value == "") {
      return "Please Enter Password";
    } else if (found) {
      return "Password should contain Capital, small letter & Number & Special";
    }
    return null;
  }

  String? validatePinCode(String? value) {
    if (value == null || value == "") {
      return "Please Enter Pin Code";
    } else {
      final val = int.tryParse(value);
      if (value.trim().length != 6 || val == null) {
        return "Please Enter 6 digit Pin Code";
      }
    }
    return null;
  }

  String? validateAddress(String? value) {
    bool found = (value?.contains(RegExp(r'[0-9]')) ?? false);
    if (value == null || value == "") {
      return "Please Enter Address";
    } else if (found) {
      return "Address should not contains numbers";
    }  else if (value.length < 3) {
      return "Address is too short";
    }
    return null;
  }

  String? validateLandmark(String? value) {
    bool found = (value?.contains(RegExp(r'[0-9]')) ?? false);
    if (value == null || value == "") {
      return "Please Enter Landmark";
    } else if (found) {
      return "Landmark should not contains numbers";
    }  else if (value.length < 3) {
      return "Landmark is too short";
    }
    return null;
  }


}
