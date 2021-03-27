import 'package:flutter/cupertino.dart';

class FormGroupUtil {
  Map<String, TextEditingController> formControls = Map();

  FormGroupUtil(List<String> controlNames) {
    controlNames.forEach((element) {
      formControls[element] = TextEditingController();
    });
  }

  TextEditingController getFormControl(String controlName) {
    return formControls[controlName];
  }

  Map<String, String> getFormGroupValue() {
    return formControls.map((key, value) => MapEntry(key, value.text));
  }

  String getFormControlValue(String controlName) {
    return getFormControl(controlName).text;
  }
}