// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_page_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$HomePageViewModel on _HomePageViewModelBase, Store {
  final _$projectsAtom = Atom(name: '_HomePageViewModelBase.projects');

  @override
  List<Project> get projects {
    _$projectsAtom.reportRead();
    return super.projects;
  }

  @override
  set projects(List<Project> value) {
    _$projectsAtom.reportWrite(value, super.projects, () {
      super.projects = value;
    });
  }

  final _$loadingProjectsAtom =
      Atom(name: '_HomePageViewModelBase.loadingProjects');

  @override
  bool get loadingProjects {
    _$loadingProjectsAtom.reportRead();
    return super.loadingProjects;
  }

  @override
  set loadingProjects(bool value) {
    _$loadingProjectsAtom.reportWrite(value, super.loadingProjects, () {
      super.loadingProjects = value;
    });
  }

  final _$loadProjectsAsyncAction =
      AsyncAction('_HomePageViewModelBase.loadProjects');

  @override
  Future<void> loadProjects() {
    return _$loadProjectsAsyncAction.run(() => super.loadProjects());
  }

  final _$handleClickAsyncAction =
      AsyncAction('_HomePageViewModelBase.handleClick');

  @override
  Future<void> handleClick(Project project) {
    return _$handleClickAsyncAction.run(() => super.handleClick(project));
  }

  final _$_HomePageViewModelBaseActionController =
      ActionController(name: '_HomePageViewModelBase');

  @override
  void resetProjects() {
    final _$actionInfo = _$_HomePageViewModelBaseActionController.startAction(
        name: '_HomePageViewModelBase.resetProjects');
    try {
      return super.resetProjects();
    } finally {
      _$_HomePageViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
projects: ${projects},
loadingProjects: ${loadingProjects}
    ''';
  }
}
