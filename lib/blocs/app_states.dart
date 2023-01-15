import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:user/model/userDetails.dart';

@immutable
abstract class UserState extends Equatable {}

class UserLoadingState extends UserState {
  @override
  List<Object?> get props => [];
}

class UserLoadedState extends UserState {
  UserLoadedState(this.users);

  final List<UserDetails> users;
  @override
  List<Object?> get props => [users];
}

class UserLoadedState2 extends UserState {
  UserLoadedState2(this.users);

  final UserDetails users;
  @override
  List<Object?> get props => [users];
}

class UserErrorState extends UserState {
  UserErrorState(this.error);

  final String error;
  @override
  List<Object?> get props => [error];
}
