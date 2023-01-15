import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user/widgets/CardUser.dart';
import 'package:user/model/userDetails.dart';

import '../blocs/app_blocs.dart';
import '../blocs/app_events.dart';
import '../blocs/app_states.dart';
import '../repos/repositories.dart';

// ignore: must_be_immutable
class OneUser extends StatelessWidget {
  static const routeName = '/oneUser';
  late List<UserDetails> userDetails;

  OneUser({super.key});

  @override
  Widget build(BuildContext context) {
    final routeArguments = ModalRoute.of(context)!.settings.arguments as Map;

    return BlocProvider(
        create: (context) => UserBloc(
              RepositoryProvider.of<UserRepository>(context),
              "${routeArguments["id"]}",
            )..add(LoadUserEvent()),
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              "Details - ${routeArguments["name"]}",
            ),
            centerTitle: true,
            backgroundColor: const Color.fromARGB(255, 249, 186, 61),
          ),
          body: BlocBuilder<UserBloc, UserState>(builder: (context, state) {
            if (state is UserLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is UserLoadedState2) {
              UserDetails userDetails = state.users;
              return Container(
                height: double.infinity,
                width: double.infinity,
                color: const Color.fromARGB(127, 249, 186, 61),
                padding: const EdgeInsets.all(10),
                child: CardUser(userDetails),
              );
            }
            if (state is UserErrorState) {
              return const Center(
                child: Text("something went wrong!"),
              );
            }
            return const Center(
              child: Text("something double wrong!"),
            );
          }),
        ));
  }
}
