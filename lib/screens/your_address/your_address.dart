import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:neo_registration_page/screens/home/home_page.dart';
import 'package:neo_registration_page/screens/your_info/your_info.dart';
import 'package:neo_registration_page/utils/enum.dart';
import 'package:neo_registration_page/utils/enum/state.dart';
import 'package:neo_registration_page/utils/input_validator.dart';
import 'package:neo_registration_page/utils/string.dart';
import 'package:neo_registration_page/utils/utility.dart';
import 'package:neo_registration_page/viewModel/provider/register_notifier.dart';
import 'package:neo_registration_page/widgets/app_header.dart';
import 'package:neo_registration_page/widgets/dropdown.dart';
import 'package:neo_registration_page/widgets/register_button.dart';
import 'package:neo_registration_page/widgets/text_form_field.dart';
import 'package:provider/provider.dart';

class YourAddress extends StatefulWidget {
  const YourAddress({Key? key}) : super(key: key);

  @override
  _YourAddressState createState() => _YourAddressState();
}

class _YourAddressState extends State<YourAddress> with InputValidator {
  final formGlobalKey = GlobalKey<FormState>();
  final addressController = TextEditingController();
  final landmarkController = TextEditingController();
  final zipcodeController = TextEditingController();
  final cityController = TextEditingController();
  final stateController = TextEditingController();
  late RegisterNotifier registerNotifier;


  String? selectedValue;
  final List<String> stateItems = [
    'Maharashtra',
    'Gujarat',
    'Karnataka',
    'Madhya Pradesh”',
    'Delhi',
    'Others',
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
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: ((context) => const YourInfo())));
                      },
                      icon: const Icon(Icons.arrow_back)),

                  const Align(
                      alignment: Alignment.center,
                      child: AppHeader(text: 'Your Address')),
                  Spacer(),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 40, right: 40, top: 5, bottom: 5),
                child: yourAddressForm(context),
              ),
            ],
          ),
        )),
      ),
    );
  }

  Form yourAddressForm(BuildContext context) {
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
            SizedBox(height: 40,),
            RegisterTextField(
              labelText: "",
              hintText: "Address",
              leadingIcon: Icons.location_city,
              controller: addressController,
              textInputType: TextInputType.text,
              validator: validateAddress,
              inputType: InputType.address,
            ),
            SizedBox(height: 20,),
            RegisterTextField(
              labelText: "",
              hintText: "Landmark",
              leadingIcon: Icons.location_city,
              controller: landmarkController,
              textInputType: TextInputType.text,
              validator: validateLandmark,
              inputType: InputType.landmark,
            ),
            SizedBox(height: 20,),
            RegisterTextField(
              labelText: "",
              hintText: "City",
              leadingIcon: Icons.location_city,
              controller: cityController,
              textInputType: TextInputType.text,
              //validator: validateFirstName,
              inputType: InputType.city,
            ),
            SizedBox(height: 20,),
            stateDropdown(),
            SizedBox(height: 20,),

            RegisterTextField(
              labelText: "",
              hintText: "Pin Code",
              leadingIcon: Icons.location_city,
              controller: zipcodeController,
              textInputType: TextInputType.number,
              validator: validatePinCode,
              inputType: InputType.zipcode,
            ),
            SizedBox(height: 40,),
            RegisterButton(
              onPressed: (){
                 onSubmitTap();
              },
              text: "Submit",
              btnColor: Colors.blue.shade900,
            ),
            const SizedBox(
              height: 40,
            ),

          ],
        ));
  }

  Consumer<RegisterNotifier> stateDropdown() {
    return Consumer<RegisterNotifier>(builder: (_, a, child) {
      return RegisterDropdown<States?>(
          hintText: "Select your State",
          value: a.states,
          items: States.values
              .map((e) => DropdownMenuItem<States>(
              value: e, child: Text(e.name.capitalize())))
              .toList(),
          onChanged: (val) => a.state = val);
    });
  }

  DropdownButtonFormField2 stateDropdown2() {
    return DropdownButtonFormField2(
      decoration: InputDecoration(
        isDense: true,
        contentPadding: EdgeInsets.zero,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(color: Colors.black, width: 2)
        ),
        focusedBorder: OutlineInputBorder(
          // borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.black, width: 2),
        ),
        enabledBorder: OutlineInputBorder(
          //borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.black87),
        ),
        disabledBorder: OutlineInputBorder(
          // borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.black87),
        ),
      ),
      isExpanded: true,
      hint: const Text(
        'Select Your State',
        style: TextStyle(fontSize: 14),
      ),
      icon: const Icon(
        Icons.arrow_drop_down,
        color: Colors.black,
      ),
      iconSize: 30,
      buttonHeight: 60,
      buttonPadding: const EdgeInsets.only(left: 20, right: 10),
      dropdownDecoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
      ),
      items: stateItems
          .map((item) => DropdownMenuItem<String>(
                value: item,
                child: Text(
                  item,
                  style: const TextStyle(
                    fontSize: 14,
                  ),
                ),
              ))
          .toList(),
      // validator: (value) {
      //   if (value == null) {
      //     return Utility.showErrorSnackBar(context,
      //         message: "Education can not be empty");
      //   }
      //   return null;
      // },
      onChanged: (data) {
        setState(() {
          selectedValue = data as String?;
        });
      },
      onSaved: (value) {
        // selectedValue = value as String?;
      },
    );
  }

  void onSubmitTap() {
    if (formGlobalKey.currentState?.validate() ?? false) {
      formGlobalKey.currentState!.save();

      if(registerNotifier.states == null){
        Utility.showErrorSnackBar(context, message: "Please Select State");
      } else{
        Utility.showSuccessSnackBar(context, message: "Successfully Submitted");
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: ((context) => const HomePage())));
      }

    } else {
      Utility.showErrorSnackBar(context, message: "Please enter all details");
    }
  }
}
