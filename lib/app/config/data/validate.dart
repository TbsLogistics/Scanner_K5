class Validate {
  String username(String? value) {
    if (value!.isEmpty) {
      return "Nhập tài khoản";
    }
    return "";
  }

  String check(String? value) {
    if (value!.isEmpty) {
      return "Nhập thông tin";
    }
    return "";
  }

  String checkCN2(String? value1, String? value2) {
    if (value2!.isEmpty) {
      return "Nhập thông tin";
    } else if (value2.isNotEmpty && value1 == value2) {
      return "CN2 trùng CN1";
    } else {
      return "";
    }
  }

  String password(String? value) {
    if (value!.isEmpty) {
      return "Nhập mật khẩu";
    } else {
      if (value.length > 15) {
        return "Tối đa 15 kí tự";
      }
    }
    return "";
  }
}
