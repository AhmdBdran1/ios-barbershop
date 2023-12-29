class addCountryCode{

  static String addCode(String phoneNumber) {
    // Check if the phone number has at least 1 digit
    if (phoneNumber.isNotEmpty) {
      // Remove the first digit
      String remainingDigits = phoneNumber.substring(1);

      // Add the country code to the beginning
      String modifiedPhoneNumber = "+972$remainingDigits";

      return modifiedPhoneNumber;
    } else {
      // Handle the case where the phone number is empty
      return phoneNumber;
    }
  }

}