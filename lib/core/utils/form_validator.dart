class FormValidator {
  static String? validateRequired(String? value, [String? fieldName]) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter ${fieldName?.toLowerCase() ?? 'this field'}';
    }
    return null;
  }

  static String? validateNumber(String? value, [String? fieldName]) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter ${fieldName?.toLowerCase() ?? 'a number'}';
    }
    
    if (double.tryParse(value) == null) {
      return 'Please enter a valid number';
    }
    
    return null;
  }

  static String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter an email address';
    }

    final emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegExp.hasMatch(value)) {
      return 'Please enter a valid email address';
    }

    return null;
  }

  static String? validatePassword(String? value, {int minLength = 6}) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter a password';
    }

    if (value.length < minLength) {
      return 'Password must be at least $minLength characters long';
    }

    return null;
  }

  // Combine multiple validators
  static String? Function(String?) combine(List<String? Function(String?)> validators) {
    return (String? value) {
      for (final validator in validators) {
        final result = validator(value);
        if (result != null) {
          return result;
        }
      }
      return null;
    };
  }
} 