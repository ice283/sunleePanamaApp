bool isNumeric(String s) {
  if (s == null) return false;
  if (s.isEmpty) return false;
  final n = num.tryParse(s);
  return (n == null) ? false : true;
}

bool isEmail(String email) {
  if (email == null) return false;
  if (email.isEmpty) return false;
  String p =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regExp = new RegExp(p);
  bool result = regExp.hasMatch(email);
  return result;
}

bool notEmpty(String s) {
  if (s == null) return false;
  if (s.isEmpty) return false;
  return true;
}

bool compare(String s, String s2) {
  if (s == null || s2 == null) return false;
  if (s.isEmpty) return false;
  if (s2.isEmpty) return false;
  if (s != s2) return false;
  return true;
}
