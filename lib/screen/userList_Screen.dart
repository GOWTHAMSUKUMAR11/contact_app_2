import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user/blocs/app_blocs.dart';
import 'package:user/blocs/app_events.dart';
import 'package:user/blocs/app_states.dart';
import 'package:user/repos/repositories.dart';
import 'package:user/model/userDetails.dart';
import 'package:user/screen/Search_Screen.dart';
import 'package:user/widgets/SortDetailSheet.dart';

class UserList extends StatefulWidget {
  const UserList({super.key});

  @override
  State<UserList> createState() => UserListState();
}

class UserListState extends State<UserList> {
  late List<UserDetails> _userDetails;
  bool valueName = false;
  bool valueId = true;
  bool valueCompanyName = false;

  // ignore: non_constant_identifier_names
  void SelectHandler(BuildContext ctx, id, name) {
    Navigator.of(ctx).pushNamed(
      "/oneUser",
      arguments: {
        'id': id,
        'name': name,
      },
    );
  }

  void searchAndFilter(context) {
    showSearch(
      context: context,
      delegate: Search(totalUserDetails: _userDetails),
    );
  }

  void sort(bool vName, bool vId, bool vCompanyName) {
    setState(() {
      valueName = vName;
      valueId = vId;
      valueCompanyName = vCompanyName;
    });
  }

  void sortDetails(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (bCtx) {
        return SortDetails(
          valueName: valueName,
          valueId: valueId,
          valueCompanyName: valueCompanyName,
          sort: sort,
        );
      },
    );
  }

  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return BlocProvider(
      create: (context) =>
          UserBloc(RepositoryProvider.of<UserRepository>(context), "")
            ..add(LoadUserEvent()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("LiveMe"),
          backgroundColor: const Color.fromARGB(255, 249, 186, 61),
          actions: [
            IconButton(
              onPressed: () => searchAndFilter(context),
              icon: const Icon(Icons.search),
              splashColor: const Color.fromARGB(255, 249, 186, 61),
            )
          ],
        ),
        body: BlocBuilder<UserBloc, UserState>(builder: (context, state) {
          if (state is UserLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is UserLoadedState) {
            _userDetails = state.users;
            if (valueId) {
              _userDetails.sort((a, b) {
                int num1 = int.parse(a.id);
                int num2 = int.parse(b.id);
                if (num1 > num2) {
                  return 1;
                } else if (num1 < num2) {
                  return -1;
                } else {
                  if (valueName) {
                    int sortvalue = a.name.compareTo(b.name);
                    if (sortvalue == 0 && valueCompanyName) {
                      return a.companyName.compareTo(b.companyName);
                    }
                    return sortvalue;
                  }
                  return 0;
                }
              });
            }
            if (!valueId && valueName) {
              _userDetails.sort((a, b) {
                int sortvalue = a.name.compareTo(b.name);
                if (sortvalue == 0 && valueCompanyName) {
                  return a.companyName.compareTo(b.companyName);
                }
                return sortvalue;
              });
            }
            if (!valueId && !valueName && valueCompanyName) {
              _userDetails
                  .sort((a, b) => a.companyName.compareTo(b.companyName));
            }
            return Container(
              height: double.infinity,
              width: double.infinity,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      height: height * 7 / 100,
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 249, 186, 61),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          InkWell(
                            splashColor: Colors.blue,
                            borderRadius: BorderRadius.circular(20),
                            onTap: () {
                              sortDetails(context);
                            },
                            child: Container(
                              width: width * 50 / 100,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.black,
                                  width: 0.1,
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      sortDetails(context);
                                    },
                                    icon: const Icon(
                                      Icons.sort,
                                    ),
                                    color: Colors.white,
                                  ),
                                  const Text(
                                    "Sort",
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          InkWell(
                            splashColor: Colors.blue,
                            borderRadius: BorderRadius.circular(20),
                            onTap: () => searchAndFilter(context),
                            child: Container(
                              width: width * 50 / 100,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.black,
                                  width: 0.1,
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  IconButton(
                                    onPressed: () => searchAndFilter(context),
                                    icon: const Icon(
                                      Icons.filter_list,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const Text(
                                    "Filter",
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      height: height * 90 / 100,
                      color: const Color.fromARGB(127, 249, 186, 61),
                      padding: EdgeInsets.fromLTRB(
                          height * 0.7 / 100,
                          height * 0.7 / 100,
                          height * 0.7 / 100,
                          height * 9 / 100),
                      child: ListView.builder(
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () => SelectHandler(
                                context,
                                _userDetails[index].id,
                                _userDetails[index].name),
                            splashColor: Colors.blue,
                            borderRadius: BorderRadius.circular(20),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              color: Colors.black,
                              elevation: 10,
                              child: Container(
                                padding: const EdgeInsets.all(40),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Center(
                                      child: SizedBox(
                                        width: 60,
                                        child: Text(
                                          _userDetails[index].id,
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "${_userDetails[index].name}\n",
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 17,
                                            ),
                                          ),
                                          Text(
                                            _userDetails[index].companyName,
                                            style: const TextStyle(
                                              color: Color.fromARGB(
                                                  127, 249, 186, 61),
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                        itemCount: _userDetails.length,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }

          if (state is UserErrorState) {
            return const Center(
              child: Text("something went wrong!"),
            );
          }
          return const Center(
            child: Text("something went wrong!"),
          );
        }),
      ),
    );
  }
}
