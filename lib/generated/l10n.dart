// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Habits`
  String get topics {
    return Intl.message('Habits', name: 'topics', desc: '', args: []);
  }

  /// `Add Habit`
  String get add_topic {
    return Intl.message('Add Habit', name: 'add_topic', desc: '', args: []);
  }

  /// `Target`
  String get target {
    return Intl.message('Target', name: 'target', desc: '', args: []);
  }

  /// `Description`
  String get description {
    return Intl.message('Description', name: 'description', desc: '', args: []);
  }

  /// `Cancel`
  String get cancel {
    return Intl.message('Cancel', name: 'cancel', desc: '', args: []);
  }

  /// `Add`
  String get add {
    return Intl.message('Add', name: 'add', desc: '', args: []);
  }

  /// `Edit`
  String get edit {
    return Intl.message('Edit', name: 'edit', desc: '', args: []);
  }

  /// `Delete`
  String get delete {
    return Intl.message('Delete', name: 'delete', desc: '', args: []);
  }

  /// `Save`
  String get save {
    return Intl.message('Save', name: 'save', desc: '', args: []);
  }

  /// `Goal`
  String get goal {
    return Intl.message('Goal', name: 'goal', desc: '', args: []);
  }

  /// `Days`
  String get days {
    return Intl.message('Days', name: 'days', desc: '', args: []);
  }

  /// `The Last`
  String get the_last {
    return Intl.message('The Last', name: 'the_last', desc: '', args: []);
  }

  /// `Day`
  String get day {
    return Intl.message('Day', name: 'day', desc: '', args: []);
  }

  /// `Date`
  String get date {
    return Intl.message('Date', name: 'date', desc: '', args: []);
  }

  /// `Total Times`
  String get total_times {
    return Intl.message('Total Times', name: 'total_times', desc: '', args: []);
  }

  /// `Total Days`
  String get total_days {
    return Intl.message('Total Days', name: 'total_days', desc: '', args: []);
  }

  /// `Streak`
  String get streak {
    return Intl.message('Streak', name: 'streak', desc: '', args: []);
  }

  /// `This Month`
  String get this_month {
    return Intl.message('This Month', name: 'this_month', desc: '', args: []);
  }

  /// `This Week`
  String get this_week {
    return Intl.message('This Week', name: 'this_week', desc: '', args: []);
  }

  /// `Last 3 Months`
  String get last_3_months {
    return Intl.message(
      'Last 3 Months',
      name: 'last_3_months',
      desc: '',
      args: [],
    );
  }

  /// `Longest Streak`
  String get longest_streak {
    return Intl.message(
      'Longest Streak',
      name: 'longest_streak',
      desc: '',
      args: [],
    );
  }

  /// `1st`
  String get first {
    return Intl.message('1st', name: 'first', desc: '', args: []);
  }

  /// `2nd`
  String get second {
    return Intl.message('2nd', name: 'second', desc: '', args: []);
  }

  /// `3rd`
  String get third {
    return Intl.message('3rd', name: 'third', desc: '', args: []);
  }

  /// `History`
  String get history {
    return Intl.message('History', name: 'history', desc: '', args: []);
  }

  /// `Profile`
  String get profile {
    return Intl.message('Profile', name: 'profile', desc: '', args: []);
  }

  /// `Name`
  String get name {
    return Intl.message('Name', name: 'name', desc: '', args: []);
  }

  /// `Email`
  String get email {
    return Intl.message('Email', name: 'email', desc: '', args: []);
  }

  /// `Sign Out`
  String get sign_out {
    return Intl.message('Sign Out', name: 'sign_out', desc: '', args: []);
  }

  /// `Are you sure you want to sign out?`
  String get sign_out_confirm {
    return Intl.message(
      'Are you sure you want to sign out?',
      name: 'sign_out_confirm',
      desc: '',
      args: [],
    );
  }

  /// `اللغة العربية`
  String get language {
    return Intl.message('اللغة العربية', name: 'language', desc: '', args: []);
  }

  /// `Add Habit`
  String get add_habit {
    return Intl.message('Add Habit', name: 'add_habit', desc: '', args: []);
  }

  /// `Times`
  String get times {
    return Intl.message('Times', name: 'times', desc: '', args: []);
  }

  /// `Select Date`
  String get select_date {
    return Intl.message('Select Date', name: 'select_date', desc: '', args: []);
  }

  /// `Are you sure you want to delete this topic?`
  String get delete_topic_confirm {
    return Intl.message(
      'Are you sure you want to delete this topic?',
      name: 'delete_topic_confirm',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to delete this habit?`
  String get delete_habit_confirm {
    return Intl.message(
      'Are you sure you want to delete this habit?',
      name: 'delete_habit_confirm',
      desc: '',
      args: [],
    );
  }

  /// `Title`
  String get title {
    return Intl.message('Title', name: 'title', desc: '', args: []);
  }

  /// `Welcome Back!`
  String get welcome_back {
    return Intl.message(
      'Welcome Back!',
      name: 'welcome_back',
      desc: '',
      args: [],
    );
  }

  /// `Sign in to continue`
  String get sign_in_to_continue {
    return Intl.message(
      'Sign in to continue',
      name: 'sign_in_to_continue',
      desc: '',
      args: [],
    );
  }

  /// `Enter your email`
  String get enter_your_email {
    return Intl.message(
      'Enter your email',
      name: 'enter_your_email',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your email`
  String get please_enter_your_email {
    return Intl.message(
      'Please enter your email',
      name: 'please_enter_your_email',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a valid email`
  String get please_enter_a_valid_email {
    return Intl.message(
      'Please enter a valid email',
      name: 'please_enter_a_valid_email',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message('Password', name: 'password', desc: '', args: []);
  }

  /// `Enter your password`
  String get enter_your_password {
    return Intl.message(
      'Enter your password',
      name: 'enter_your_password',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your password`
  String get please_enter_your_password {
    return Intl.message(
      'Please enter your password',
      name: 'please_enter_your_password',
      desc: '',
      args: [],
    );
  }

  /// `Password must be at least 6 characters`
  String get password_must_be_at_least_6_characters {
    return Intl.message(
      'Password must be at least 6 characters',
      name: 'password_must_be_at_least_6_characters',
      desc: '',
      args: [],
    );
  }

  /// `Forgot Password?`
  String get forgot_password {
    return Intl.message(
      'Forgot Password?',
      name: 'forgot_password',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get login {
    return Intl.message('Login', name: 'login', desc: '', args: []);
  }

  /// `OR`
  String get or {
    return Intl.message('OR', name: 'or', desc: '', args: []);
  }

  /// `Create New Account`
  String get create_new_account {
    return Intl.message(
      'Create New Account',
      name: 'create_new_account',
      desc: '',
      args: [],
    );
  }

  /// `Create Account`
  String get create_account {
    return Intl.message(
      'Create Account',
      name: 'create_account',
      desc: '',
      args: [],
    );
  }

  /// `Sign up to get started`
  String get sign_up_to_get_started {
    return Intl.message(
      'Sign up to get started',
      name: 'sign_up_to_get_started',
      desc: '',
      args: [],
    );
  }

  /// `Full Name`
  String get full_name {
    return Intl.message('Full Name', name: 'full_name', desc: '', args: []);
  }

  /// `Enter your full name`
  String get enter_your_full_name {
    return Intl.message(
      'Enter your full name',
      name: 'enter_your_full_name',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your full name`
  String get please_enter_your_full_name {
    return Intl.message(
      'Please enter your full name',
      name: 'please_enter_your_full_name',
      desc: '',
      args: [],
    );
  }

  /// `Name must be at least 2 characters`
  String get name_must_be_at_least_2_characters {
    return Intl.message(
      'Name must be at least 2 characters',
      name: 'name_must_be_at_least_2_characters',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Password`
  String get confirm_password {
    return Intl.message(
      'Confirm Password',
      name: 'confirm_password',
      desc: '',
      args: [],
    );
  }

  /// `Re-enter your password`
  String get re_enter_your_password {
    return Intl.message(
      'Re-enter your password',
      name: 're_enter_your_password',
      desc: '',
      args: [],
    );
  }

  /// `Please confirm your password`
  String get please_confirm_your_password {
    return Intl.message(
      'Please confirm your password',
      name: 'please_confirm_your_password',
      desc: '',
      args: [],
    );
  }

  /// `Passwords do not match`
  String get passwords_do_not_match {
    return Intl.message(
      'Passwords do not match',
      name: 'passwords_do_not_match',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your name`
  String get please_enter_your_name {
    return Intl.message(
      'Please enter your name',
      name: 'please_enter_your_name',
      desc: '',
      args: [],
    );
  }

  /// `Already have an account? Sign In`
  String get already_have_an_account_sign_in {
    return Intl.message(
      'Already have an account? Sign In',
      name: 'already_have_an_account_sign_in',
      desc: '',
      args: [],
    );
  }

  /// `Reset Password`
  String get reset_password {
    return Intl.message(
      'Reset Password',
      name: 'reset_password',
      desc: '',
      args: [],
    );
  }

  /// `Send Link`
  String get send_link {
    return Intl.message('Send Link', name: 'send_link', desc: '', args: []);
  }

  /// `Email Sent Successfully`
  String get email_sent_successfully {
    return Intl.message(
      'Email Sent Successfully',
      name: 'email_sent_successfully',
      desc: '',
      args: [],
    );
  }

  /// `Check your email for the password reset link.`
  String get check_your_email {
    return Intl.message(
      'Check your email for the password reset link.',
      name: 'check_your_email',
      desc: '',
      args: [],
    );
  }

  /// `An error occurred`
  String get error_occurred {
    return Intl.message(
      'An error occurred',
      name: 'error_occurred',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your email to reset your password`
  String get please_enter_email_to_reset {
    return Intl.message(
      'Please enter your email to reset your password',
      name: 'please_enter_email_to_reset',
      desc: '',
      args: [],
    );
  }

  /// `History of {name}`
  String history_with_name(Object name) {
    return Intl.message(
      'History of $name',
      name: 'history_with_name',
      desc: '',
      args: [name],
    );
  }

  /// `Track your journey`
  String get track_your_journey {
    return Intl.message(
      'Track your journey',
      name: 'track_your_journey',
      desc: '',
      args: [],
    );
  }

  /// `Change Password`
  String get change_password {
    return Intl.message(
      'Change Password',
      name: 'change_password',
      desc: '',
      args: [],
    );
  }

  /// `New Password`
  String get new_password {
    return Intl.message(
      'New Password',
      name: 'new_password',
      desc: '',
      args: [],
    );
  }

  /// `Password Changed Successfully`
  String get password_changed_successfully {
    return Intl.message(
      'Password Changed Successfully',
      name: 'password_changed_successfully',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
