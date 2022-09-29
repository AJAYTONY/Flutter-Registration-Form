import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:neo_registration_page/models/register_info.dart';
import 'package:neo_registration_page/screens/your_info/your_info.dart';
import 'package:neo_registration_page/utils/app_colors.dart';
import 'package:neo_registration_page/utils/enum.dart';
import 'package:neo_registration_page/utils/input_validator.dart';
import 'package:neo_registration_page/utils/utility.dart';
import 'package:neo_registration_page/viewModel/provider/register_notifier.dart';
import 'package:neo_registration_page/widgets/add_image.dart';
import 'package:neo_registration_page/widgets/app_header.dart';
import 'package:neo_registration_page/widgets/register_button.dart';
import 'package:neo_registration_page/widgets/register_header.dart';
import 'package:neo_registration_page/widgets/text_form_field.dart';
import 'package:neo_registration_page/widgets/widget_header.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> with InputValidator {
  String? gender;
  int? selectedRadio;

  // Default Radio Button Selected Item When App Starts.
  String radioButtonItem = 'ONE';

  // Group Value for Radio Button.
  int id = 1;

  // show the password or not
  bool isObscure = true;

  RegExp passValid = RegExp(r"(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*\W)");
  RegExp emailValid =
      RegExp(r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
          r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
          r"{0,253}[a-zA-Z0-9])?)*$");

  //A function that validate user entered password
  bool _validatePassword(String pass) {
    String password = pass.trim();
    if (passValid.hasMatch(password)) {
      return true;
    } else {
      return false;
    }
  }

  //A function that validate user entered email
  bool _validateEmail(String email) {
    String emailId = email.trim();
    if (emailValid.hasMatch(emailId)) {
      return true;
    } else {
      return false;
    }
  }

  final formGlobalKey = GlobalKey<FormState>();
  final imageController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  late RegisterNotifier registerNotifier;

  @override
  void initState() {
    super.initState();
    selectedRadio = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SafeArea(
            child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 40, right: 40),
            child: registerForm(context),
          ),
        )),
      ),
    );
  }

  Form registerForm(BuildContext context) {
    return Form(
      key: formGlobalKey,
      child: registerFormInputFields(context),
    );
  }

  Column registerFormInputFields(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Align(
          alignment: Alignment.center,
          child: AppHeader(text: 'Register'),
        ),
        const SizedBox(
          height: 4,
        ),
        const Align(
          alignment: Alignment.center,
          child: AddImageForm(),
        ),
        // Align(
        //   alignment: Alignment.center,
        //   child: AddImageForm2(context),
        // ),
        const WidgetHeader(text: 'First Name *'),
        const SizedBox(
          height: 4,
        ),
        RegisterTextField(
          labelText: "",
          hintText: "Enter your first name here",
          leadingIcon: Icons.person,
          controller: firstNameController,
          textInputType: TextInputType.text,
          validator: validateFirstName,
          inputType: InputType.firstName,
        ),
        const SizedBox(
          height: 10,
        ),
        const WidgetHeader(text: 'Last Name *'),
        const SizedBox(
          height: 4,
        ),
        RegisterTextField(
          labelText: "",
          hintText: "Enter your last name here",
          leadingIcon: Icons.person,
          controller: lastNameController,
          textInputType: TextInputType.text,
          validator: validateLastName,
          inputType: InputType.lastName,
        ),
        const SizedBox(
          height: 10,
        ),
        const WidgetHeader(text: 'Phone Number *'),
        const SizedBox(
          height: 4,
        ),
        RegisterTextField(
          labelText: "",
          hintText: "Enter your 10 digit phone number",
          leadingIcon: Icons.call,
          controller: phoneNumberController,
          textInputType: TextInputType.number,
          validator: validateMobileNumber,
          inputType: InputType.phoneNumber,
        ),
        const SizedBox(
          height: 10,
        ),
        const WidgetHeader(text: 'Email *'),
        const SizedBox(
          height: 4,
        ),
        // RegisterTextField(
        //   labelText: "",
        //   hintText: "Your email goes here",
        //   leadingIcon: Icons.email,
        //   controller: emailController,
        //   textInputType: TextInputType.emailAddress,
        //   validator: validateEmail,
        //   inputType: InputType.email,
        // ),
        _Email(context),
        const SizedBox(
          height: 10,
        ),
        const WidgetHeader(text: 'Gender'),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Radio(
              value: 1,
              groupValue: id,
              onChanged: (val) {
                setState(() {
                  radioButtonItem = 'ONE';
                  id = 1;
                });
              },
            ),
            Text(
              'Male',
              style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.normal,
                  color: Colors.grey),
            ),
            Radio(
              value: 2,
              groupValue: id,
              onChanged: (val) {
                setState(() {
                  radioButtonItem = 'TWO';
                  id = 2;
                });
              },
            ),
            Text(
              'Female',
              style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.normal,
                  color: Colors.grey),
            ),
          ],
        ),
        const WidgetHeader(text: 'Password *'),
        const SizedBox(
          height: 4,
        ),
        TextFormField(
          obscureText: isObscure,
          decoration: InputDecoration(
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintText: 'password',
            labelText: '',
            // icon: const Padding(
            //   padding: EdgeInsets.only(top: 15.0),
            //   child: Icon(Icons.lock),
            // ),
            errorStyle: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 10,
            ),
            focusedBorder: OutlineInputBorder(
              // borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.black, width: 2),
            ),
            border: OutlineInputBorder(
              //borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.black87),
            ),
            enabledBorder: OutlineInputBorder(
              //borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.black87),
            ),
            disabledBorder: OutlineInputBorder(
              // borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.black87),
            ),
            prefixIcon: Icon(
              Icons.lock,
              color: AppColors.iconColor,
            ),
            suffixIcon: IconButton(
                icon: Icon(
                  isObscure ? Icons.visibility : Icons.visibility_off,
                  color: AppColors.iconColor,
                ),
                onPressed: () {
                  setState(() {
                    isObscure = !isObscure;
                  });
                }),
          ),
          //val.length < 6 ? 'Password too short.' : null
          controller: passwordController,
          validator: (value) {
            if (value == null || value == "") {
              return "Please Enter Password";
            } else {
              //call function to check password
              bool result = _validatePassword(value);
              if (result) {
                // create account event
                return null;
              } else {
                return " Password should contain Capital, small letter & Number & Special";
              }
            }
          },
          // onSaved: (val) => _password = val,
        ),
        SizedBox(
          height: 10,
        ),
        const WidgetHeader(text: 'Confirm Password'),
        const SizedBox(
          height: 4,
        ),
        TextFormField(
          obscureText: isObscure,
          decoration: InputDecoration(
            floatingLabelBehavior: FloatingLabelBehavior.always,
            labelText: '',
            hintText: 'password',
            // icon: const Padding(
            //   padding: EdgeInsets.only(top: 15.0),
            //   child: Icon(Icons.lock),
            // ),
            errorStyle: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 10,
            ),
            focusedBorder: OutlineInputBorder(
              // borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.black, width: 2),
            ),
            border: OutlineInputBorder(
              //borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.black87),
            ),
            enabledBorder: OutlineInputBorder(
              //borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.black87),
            ),
            disabledBorder: OutlineInputBorder(
              // borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.black87),
            ),
            prefixIcon: Icon(
              Icons.lock,
              color: AppColors.iconColor,
            ),
          ),
          controller: confirmPasswordController,
          validator: (val) {
            if (val == null || val == "") {
              return "Please Enter confirm Password";
            } else {
              if (val != passwordController.text) {
                return "Password Not match ";
              }
            }
            return null;
          },
          // onSaved: (val) => _password = val,
        ),
        const SizedBox(
          height: 30,
        ),
        RegisterButton(
          onPressed: onRegisterTap,
          text: "Next",
          btnColor: Colors.blue.shade900,
        ),
        const SizedBox(
          height: 40,
        ),
      ],
    );
  }

  // Changes the selected value on 'onChanged' click on each radio button
  setSelectedRadio(int val) {
    setState(() {
      selectedRadio = val;
    });
  }

  void onRegisterTap() {
    if (formGlobalKey.currentState?.validate() ?? false) {
      formGlobalKey.currentState!.save();

      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: ((context) => const YourInfo())));
    } else {
      Utility.showErrorSnackBar(context, message: "Please enter all details");
    }
  }

  TextFormField _Email(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        floatingLabelBehavior: FloatingLabelBehavior.always,
        hintText: 'Your email goes here',
        hintStyle: TextStyle(color: Colors.grey[400]!),
        labelText: '',
        // icon: const Padding(
        //   padding: EdgeInsets.only(top: 15.0),
        //   child: Icon(Icons.lock),
        // ),
        errorStyle: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 10,
        ),
        focusedBorder: OutlineInputBorder(
          // borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.black, width: 2),
        ),
        border: OutlineInputBorder(
          //borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.black87),
        ),
        enabledBorder: OutlineInputBorder(
          //borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.black87),
        ),
        disabledBorder: OutlineInputBorder(
          // borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.black87),
        ),
        prefixIcon: Icon(
          Icons.email,
          color: AppColors.iconColor,
        ),
      ),
      controller: emailController,
      validator: (value) {
        if (value == null || value == "") {
          return "Please Enter Email";
        } else {
          //call function to check password
          bool result = _validateEmail(value);
          if (result) {
            // create account event
            return null;
          } else {
            return "Please enter valid email";
          }
        }
      },
      // onSaved: (val) => _password = val,
    );
  }

  Widget AddImageForm2(BuildContext context) {
    return  Container(
      width: 70.0,
      height: 70.0,
      decoration: BoxDecoration(
        color: const Color(0xff7c94b6),
        image: DecorationImage(
          image: NetworkImage('https://lh3.googleusercontent.com/ogw/AOh-ky3dsfhT8NtSUWFLRZnyOe3Cf4dn80KuUIZd-FufoQ=s32-c-mo'),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.all( Radius.circular(50.0)),
        border: Border.all(
          color: Colors.black87,
          width: 1.0,
        ),
      ),
    );
  }
}

typedef StringCallback = Function(String? params);
typedef ValidatorCallback = String? Function(String? params);
