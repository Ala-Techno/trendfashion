class AuthValidators {
  // r'^[\p{Script=Arabic}0-9_\s]+$', For supporting Only Arabic words
  static final usernameRegExp = RegExp(
    r'^[a-zA-Z\p{Script=Arabic}0-9_\s]+$', // Allows Arabic, Latin (English), numbers, _, and spaces
    unicode: true, // Required for Unicode scripts
  );
  static final emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

  static String? usernameValidator(String? value) {
    if (value == null || value.isEmpty) return 'Username required';
    if (value.length < 4 || value.length > 20) {
      return 'Must be 4-20 characters';
    }
    if (!usernameRegExp.hasMatch(value)) {
      return 'Only letters, numbers and _';
    }
    return null;
  }

  static String? emailValidator(String? value) {
    if (value == null || value.isEmpty) return 'Email required';
    if (!emailRegExp.hasMatch(value)) return 'Invalid email format';
    return null;
  }

  // static String? passwordValidator(String? value) {
  //   if (value == null || value.isEmpty) return 'Password required';
  //   if (value.length < 8) return 'Minimum 8 characters';
  //   if (!RegExp(r'[A-Z]').hasMatch(value)) return 'Include uppercase letter';
  //   if (!RegExp(r'[a-z]').hasMatch(value)) return 'Include lowercase letter';
  //   if (!RegExp(r'[0-9]').hasMatch(value)) return 'Include number';
  //   return null;
  // }
}
