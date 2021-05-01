// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_page_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$LoginPageViewModel on _LoginPageViewModelBase, Store {
  final _$isAutoValidateAtom =
      Atom(name: '_LoginPageViewModelBase.isAutoValidate');

  @override
  bool get isAutoValidate {
    _$isAutoValidateAtom.reportRead();
    return super.isAutoValidate;
  }

  @override
  set isAutoValidate(bool value) {
    _$isAutoValidateAtom.reportWrite(value, super.isAutoValidate, () {
      super.isAutoValidate = value;
    });
  }

  final _$onPressedLoginButtonAsyncAction =
      AsyncAction('_LoginPageViewModelBase.onPressedLoginButton');

  @override
  Future<void> onPressedLoginButton() {
    return _$onPressedLoginButtonAsyncAction
        .run(() => super.onPressedLoginButton());
  }

  final _$_LoginPageViewModelBaseActionController =
      ActionController(name: '_LoginPageViewModelBase');

  @override
  bool checkForm() {
    final _$actionInfo = _$_LoginPageViewModelBaseActionController.startAction(
        name: '_LoginPageViewModelBase.checkForm');
    try {
      return super.checkForm();
    } finally {
      _$_LoginPageViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isAutoValidate: ${isAutoValidate}
    ''';
  }
}
