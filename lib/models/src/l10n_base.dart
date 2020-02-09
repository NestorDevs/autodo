import 'package:flutter/material.dart';

abstract class AutodoLocalization {
  static AutodoLocalization of(BuildContext context) => Localizations.of<AutodoLocalization>(context, AutodoLocalization);
  // Units
  dateFormat(date) {}
  String get fuelUnits => "l";
  String get moneyUnits => "\$"; // what money units to use?
  String get moneyUnitsSuffix => "(USD)";
  String get distanceUnits => "km";
  String get distanceUnitsShort => "(km)";
  String get mileage => "Mileage";

  // Text
  String get appTitle => "auToDo";
  String get undo => "Undo";
  todoDeleted(name) => "ToDo $name deleted.";
  String get refuelingDeleted => "Refueling deleted.";
  String get repeatDeleted => "Repeat deleted.";
  String get firstTimeDoingTask => "First Time Doing This Task.";
  String get dueAt => "Due At";
  String get dueOn => "Due on";
  String get pastDue => "Past Due";
  String get dueSoon => "Due Soon";
  String get upcoming => "Upcoming";
  String get totalCost => "Total Cost";
  String get totalAmount => "Total Amount";
  String get onLiteral => "on";
  String get refueling => "Refueling";
  String get at => "at";
  String get requiredLiteral => "Required";
  String get optional => "Optional";
  String get odomReading => "Odometer Reading";
  String get totalPrice => "Total Price";
  String get refuelingDate => "Refueling Date";
  String get refuelingAmount => "Refueling Amount";
  String get chooseDate => "Choose Date";
  String get invalidDate => "Not a valid date";
  String get addRefueling => "Add Refueling";
  String get editRefueling => "Edit Refueling";
  String get saveChanges => "Save Changes";
  String get carName => "Car Name";
  String get todoDueSoon => "Maintenance ToDo Due Soon";
  String get markAllIncomplete => "Mark All Incomplete";
  String get markAllComplete => "Mark All Complete";
  String get clearCompleted => "Clear Completed";
  String get filterTodos => "Filter ToDos";
  String get showAll => "Show All";
  String get showActive => "Show Active";
  String get showCompleted => "Show Completed";
  String get todos => "ToDos";
  String get refuelings => "Refuelings";
  String get stats => "Stats";
  String get repeats => "Repeats";
  String get interval => "Interval";
  String get dueDate => "Due Date";
  String get signInWithGoogle => "Sign In with Google";
  String get forgotYourPassword => "Forgot your password?";
  String get login => "Login";
  String get email => "Email";
  String get password => "Password";
  String get sendPasswordReset => "Send Password Reset";
  String get createAnAccount => "Create an Account";
  String get legal1 => "By signing up, you agree to the";
  String get legal2 => "terms and conditions";
  String get legal3 => "and";
  String get legal4 => "privacy policy";
  String get legal5 => "of the auToDo app.";
  String get gotItBang => "Got It!";
  String get send => "Send";
  String get back => "Back";
  String get loginFailure => "Login Failure";
  String get loggingInEllipsis => "Logging in...";
  String get signingUpEllipsis => "Signing up...";
  String get signup => "Sign Up";
  String get alreadyHaveAnAccount => "Already have an account?";
  String get verifyEmail => "Verify Email";
  String get verifyBodyText =>
      'An email has been sent to you with a link to verify your account.\n\nYou must verify your email to use auToDo.';
  String get next => "Next";
  String get editTodo => "Edit ToDo";
  String get addTodo => "Add Todo";
  String get repeatName => "Repeat Name";
  String get editRepeat => "Edit Repeat";
  String get addRepeat => "Add Repeat";
  String get verificationSent => "Verification Email Sent";
  String get verificationDialogContent =>
      "Please check the specified email address for an email from auToDo. This email will contain a link through which you can verify your account and use the app.";
  String get completed => "Completed: ";
}