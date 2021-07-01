import 'package:email_validator/email_validator.dart' as e_val;


class GenericValidator {
  Function? validateFunc;
  String? errorMessage;
  bool hasValidated = false;
  bool validationResult = false;
  String validatorNotRun = "Run validators first";

  GenericValidator({required this.errorMessage, this.validateFunc})
      : assert(validateFunc != null, "Please include a validator function"),
        assert(errorMessage != null, "Please include an error message");

  bool validate(String value) {
    validationResult = validateFunc!(value);
    hasValidated = true;
    return validationResult;
  }

  String? getErrorMessage() {
    if (hasValidated) {
      return validationResult ? null : errorMessage;
    } else {
      return validatorNotRun;
    }
  }
}


class EmailValidator extends GenericValidator {
  static String? _errorMessage = "Please input a valid email address";
  bool hasValidated = false;
  bool validationResult = false;

  EmailValidator()
      : super(
            errorMessage: _errorMessage,
            validateFunc: e_val.EmailValidator.validate);
}

bool requiredValidator(String value) {
  if (value.isEmpty) {
    return false;
  }
  return true;
}

class FieldRequiredValidator extends GenericValidator {
  static String? _errorMessage = "This field is required";
  bool hasValidated = false;
  bool validationResult = false;

  FieldRequiredValidator()
      : super(validateFunc: requiredValidator, errorMessage: _errorMessage);
}


bool minLength(String value) {
  if (value.isEmpty) {
    return false;
  }
  return true;
}

// class MinLengthValidator extends GenericValidator {
//   static String? _errorMessage = "Value must be more than ";
//   int? minLength = 4;
//   bool hasValidated = false;
//   bool validationResult = false;
//
//   MinLengthValidator({this.minLength})
//       : super(validateFunc: (val, minLength) { return val > minLength; }, errorMessage: _errorMessage);
//
//
// }




String? validatorConfirm(List<GenericValidator> validators, String value) {
  for (GenericValidator validator in validators) {
    bool res = validator.validate(value);
    if (!res) {
      return validator.getErrorMessage(); // return early
    }
  }
}
