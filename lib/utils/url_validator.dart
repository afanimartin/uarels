import 'package:formz/formz.dart';

enum Validator { invalid }

class UrlValidator extends FormzInput<String, Validator> {
  UrlValidator.pure() : super.pure('');
  UrlValidator.dirty([String value = '']) : super.dirty(value);

  final _validator = RegExp(
      r'[(http(s)?):\/\/(www\.)?a-zA-Z0-9@:%._\+~#=]{2,256}\.[a-z]{2,6}\b([-a-zA-Z0-9@:%_\+.~#?&//=]*)/gim');

  @override
  Validator validator(String value) =>
      _validator.hasMatch(value) ? null : Validator.invalid;
}
