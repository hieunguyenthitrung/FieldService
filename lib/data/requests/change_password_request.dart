class ChangePasswordRequest {
  String currentPassword;
  String newPassword;
  String confirmNewPassword;
  ChangePasswordRequest({
    required this.currentPassword,
    required this.newPassword,
    required this.confirmNewPassword,
  });

  String get validate {
    if (currentPassword.length < 6) {
      return 'Current Password at least 6 characters';
    }
    if (newPassword.length < 6) {
      return 'New Password at least 6 characters';
    }

    if (confirmNewPassword.length < 6) {
      return 'Confirm New Password at least 6 characters';
    }

    if (newPassword != confirmNewPassword) {
      return 'Confirm New Password and New Password does not match';
    }

    return '';
  }
}
