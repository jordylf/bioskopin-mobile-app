class FormValidator {
  // Validasi email
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email tidak boleh kosong';
    }
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+$');
    if (!emailRegex.hasMatch(value)) {
      return 'Email tidak valid';
    }
    return null;
  }

  // Validasi password
  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Kata sandi tidak boleh kosong';
    }
    if (value.length < 6) {
      return 'Kata sandi harus memiliki minimal 6 karakter';
    }
    return null;
  }

  // Validasi nama
  static String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Nama tidak boleh kosong';
    }
    return null;
  }

  // Validasi tiket
  static String? validateTicket(String? value) {
    if (value == null || value.isEmpty) {
      return 'Tiket tidak boleh kosong';
    } else if (int.tryParse(value) == null) {
      return 'Tiket harus berupa angka';
    } else if (int.parse(value) <= 0) {
      return 'Tiket harus lebih besar dari 0';
    }

    return null;
  }
}
