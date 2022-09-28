import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:neo_registration_page/screens/register/RegisterScreen.dart';
import 'package:neo_registration_page/screens/your_address/your_address.dart';
import 'package:neo_registration_page/utils/app_colors.dart';
import 'package:neo_registration_page/utils/enum.dart';
import 'package:neo_registration_page/utils/enum/education.dart';
import 'package:neo_registration_page/utils/input_validator.dart';
import 'package:neo_registration_page/utils/string.dart';
import 'package:neo_registration_page/utils/utility.dart';
import 'package:neo_registration_page/viewModel/provider/register_notifier.dart';
import 'package:neo_registration_page/widgets/app_header.dart';
import 'package:neo_registration_page/widgets/category_header.dart';
import 'package:neo_registration_page/widgets/dropdown.dart';
import 'package:neo_registration_page/widgets/register_button.dart';
import 'package:neo_registration_page/widgets/text_form_field.dart';
import 'package:neo_registration_page/widgets/widget_header.dart';
import 'package:provider/provider.dart';

class YourInfo extends StatefulWidget {
  const YourInfo({Key? key}) : super(key: key);

  @override
  _YourInfoState createState() => _YourInfoState();
}

class _YourInfoState extends State<YourInfo> with InputValidator {
  final formGlobalKey = GlobalKey<FormState>();
  final yearOfPassingController = TextEditingController();
  final gradeController = TextEditingController();
  final experienceController = TextEditingController();
  final designationController = TextEditingController();
  final domainController = TextEditingController();

  late RegisterNotifier registerNotifier;

  final List<String> educationItems = [
    'Post Graduate',
    'Graduate',
    '“HSC/Diploma',
    'SSC',
  ];

  @override
  void initState() {
    registerNotifier = Provider.of<RegisterNotifier>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SafeArea(
            child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  IconButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: ((context) => const RegisterScreen())));
                    },
                    icon: const Icon(Icons.arrow_back),
                  ),

                  const Expanded(
                    child: Align(
                        alignment: Alignment.center,
                        child: AppHeader(text: 'Your Info')),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 40, right: 40, top: 5, bottom: 5),
                child: yourInfoForm(context),
              ),
            ],
          ),
        )),
      ),
    );
  }

  Form yourInfoForm(BuildContext context) {
    return Form(
      key: formGlobalKey,
      child: yourInfoFormInputFields(context),
    );
  }

  Align yourInfoFormInputFields(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SizedBox(
            height: 16,
          ),
          const CategoryHeader(text: 'Education Info'),
          const WidgetHeader(text: 'Education *'),
          const SizedBox(
            height: 4,
          ),
          educationDropdown(),
          const SizedBox(
            height: 10,
          ),
          const WidgetHeader(text: 'Year of passing *'),
          const SizedBox(
            height: 4,
          ),
          yearOfPassingWidget(context),
          const SizedBox(
            height: 10,
          ),
          const WidgetHeader(text: 'Grade *'),
          const SizedBox(
            height: 4,
          ),
          gradeWidget(context),
          const SizedBox(
            height: 8,
          ),
          const Divider(color: Colors.grey),
          const SizedBox(
            height: 16,
          ),
          const CategoryHeader(text: 'Professional Info'),
          const WidgetHeader(text: 'Experience *'),
          const SizedBox(
            height: 4,
          ),
          experienceWidget(context),
          const SizedBox(
            height: 10,
          ),
          const WidgetHeader(text: 'Designation *'),
          const SizedBox(
            height: 4,
          ),
          designationWidget(context),
          const SizedBox(
            height: 10,
          ),
          const WidgetHeader(text: 'Domain'),
          const SizedBox(
            height: 4,
          ),
          domainWidget(context),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child: TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: ((context) => const RegisterScreen())));
                  },
                  child: const Text("Previous",
                      style:
                          const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                  style: ButtonStyle(
                      padding: MaterialStateProperty.all<EdgeInsets>(
                          const EdgeInsets.all(15)),
                      foregroundColor: MaterialStateProperty.all<Color>(
                          Colors.blue.shade900),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              //borderRadius: BorderRadius.circular(18.0),
                              side: BorderSide(color: Colors.blue.shade900)))),
                ),
              ),
              const SizedBox(width: 10),
              Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child: ElevatedButton(
                    child: const Text("Next",
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold)),
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all<EdgeInsets>(
                          const EdgeInsets.all(15)),
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Colors.blue.shade900),
                      // shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      //     RoundedRectangleBorder(
                      //         borderRadius: BorderRadius.zero,
                      //         side: BorderSide(color: Colors.red)
                      //     )
                      // )
                    ),
                    onPressed: () {
                      onRegisterTap();
                    }),
              )
            ],
          ),
          const SizedBox(
            height: 40,
          ),
        ],
      ),
    );
  }

  Consumer<RegisterNotifier> educationDropdown() {
    return Consumer<RegisterNotifier>(builder: (_, a, child) {
      return RegisterDropdown<Education?>(
          hintText: "Select your Education",
          value: a.education,
          items: Education.values
              .map((e) => DropdownMenuItem<Education>(
                  value: e, child: Text(e.name.capitalize())))
              .toList(),
          onChanged: (val) => a.education = val);
    });
  }

  TextFormField yearOfPassingWidget(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.number,
      decoration: const InputDecoration(
        floatingLabelBehavior: FloatingLabelBehavior.always,
        labelText: '',
        hintText: 'Enter year of passing',
        // icon: const Padding(
        //   padding: EdgeInsets.only(top: 15.0),
        //   child: Icon(Icons.lock),
        // ),
        errorStyle: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 10,
        ),
        focusedBorder: const OutlineInputBorder(
          // borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.black, width: 2),
        ),
        border: OutlineInputBorder(
          //borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.black87),
        ),
        enabledBorder: OutlineInputBorder(
          //borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.black87),
        ),
        disabledBorder: const OutlineInputBorder(
          // borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.black87),
        ),
        // suffixIcon: Icon(
        //   Icons.arrow_drop_down_outlined,
        //   color: AppColors.iconColor,
        // ),
      ),
      controller: yearOfPassingController,
      validator: (val) {
        if (val == null || val == "") {
          return "Please Enter year of passing";
        }
        return null;
      },
      // onSaved: (val) => _password = val,
    );
  }

  TextFormField gradeWidget(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.text,
      decoration: const InputDecoration(
        floatingLabelBehavior: FloatingLabelBehavior.always,
        labelText: '',
        hintText: 'Enter your Grade or Percentage',
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
          borderSide:  BorderSide(color: Colors.black87),
        ),
        enabledBorder:  OutlineInputBorder(
          //borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.black87),
        ),
        disabledBorder:  OutlineInputBorder(
          // borderRadius: BorderRadius.circular(10),
          borderSide:  BorderSide(color: Colors.black87),
        ),
        // suffixIcon: Icon(
        //   Icons.arrow_drop_down_outlined,
        //   color: AppColors.iconColor,
        // ),
      ),
      controller: gradeController,
      validator: (val) {
        if (val == null || val == "") {
          return "Please Enter grade";
        }
        return null;
      },
      // onSaved: (val) => _password = val,
    );
  }

  TextFormField experienceWidget(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.number,
      decoration: const InputDecoration(
        floatingLabelBehavior: FloatingLabelBehavior.always,
        labelText: '',
        hintText: 'Enter the years of experience',
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
        // suffixIcon: Icon(
        //   Icons.arrow_drop_down_outlined,
        //   color: AppColors.iconColor,
        // ),
      ),
      controller: experienceController,
      validator: (val) {
        if (val == null || val == "") {
          return "Please Enter experience";
        }
        return null;
      },
      // onSaved: (val) => _password = val,
    );
  }

  TextFormField designationWidget(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.text,
      decoration: const InputDecoration(
        floatingLabelBehavior: FloatingLabelBehavior.always,
        labelText: '',
        hintText: 'Enter designation',
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
        // suffixIcon: Icon(
        //   Icons.arrow_drop_down_outlined,
        //   color: AppColors.iconColor,
        // ),
      ),
      controller: designationController,
      validator: (val) {
        if (val == null || val == "") {
          return "Please Enter designation";
        }
        return null;
      },
      // onSaved: (val) => _password = val,
    );
  }

  TextFormField domainWidget(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.text,
      decoration: const InputDecoration(
        floatingLabelBehavior: FloatingLabelBehavior.always,
        labelText: '',
        hintText: 'Enter your domain',
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
        // suffixIcon: Icon(
        //   Icons.arrow_drop_down_outlined,
        //   color: AppColors.iconColor,
        // ),
      ),
      controller: domainController,
      // validator: (val) {
      //   if (val == null || val == "") {
      //     return "Please Enter domain";
      //   }
      //   return null;
      // },
      // onSaved: (val) => _password = val,
    );
  }

  void onRegisterTap() {
    if (formGlobalKey.currentState?.validate() ?? false) {
      formGlobalKey.currentState!.save();

      if (registerNotifier.education == null) {
        Utility.showErrorSnackBar(context, message: "Please Select Education");
      } else {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: ((context) => const YourAddress())));
      }
    } else {
      Utility.showErrorSnackBar(context, message: "Please enter all details");
    }
  }
}
