import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_mt/source/data/Auth/cubit/auth_cubit.dart';
import 'package:flutter_mt/source/data/Auth/cubit/profile_cubit.dart';
import 'package:flutter_mt/source/widget/button_logout.dart';
import 'package:flutter_mt/source/widget/custom_button4.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> with SingleTickerProviderStateMixin {
  Animation<double>? _animation;
  AnimationController? _animationController;
  RefreshController _refreshController = RefreshController(initialRefresh: false);
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 260),
    );

    final curvedAnimation = CurvedAnimation(curve: Curves.easeOut, parent: _animationController!);
    _animation = Tween<double>(begin: 0, end: 1).animate(curvedAnimation);
    BlocProvider.of<ProfileCubit>(context).getProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        centerTitle: true,
      ),
      body: CustomScrollView(shrinkWrap: true,
        slivers: [
          SliverToBoxAdapter(
            child: BlocBuilder<ProfileCubit, ProfileState>(
              builder: (context, state) {
                if (state is ProfileLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (state is ProfileLoaded == false) {
                  return Container(
                    alignment: Alignment.center,
                    child: Text('Data False'),
                  );
                }
                var data = (state as ProfileLoaded).json;
                var statusCode = (state as ProfileLoaded).statusCode;
                if (data.isEmpty) {
                  return Container(
                    alignment: Alignment.center,
                    child: Text('Data Kosong'),
                  );
                }
                if (statusCode != 200) {
                  return Container(
                    alignment: Alignment.center,
                    child: Text(data.toString()),
                  );
                }
                return ListView(
                  shrinkWrap: true,
                  children: [
                    const SizedBox(height: 8.0),
                    Icon(FontAwesomeIcons.user, size: 50),
                    const SizedBox(height: 20.0),
                    Text(textAlign: TextAlign.center, data['email'].toString()),
                    const SizedBox(height: 8.0),
                    Text(
                      textAlign: TextAlign.center,
                      'Role',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(
                      height: 50,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: data['roles'].length,
                        itemBuilder: (context, index) {
                          var a = data['roles'][index];
                          return Container(
                            margin: const EdgeInsets.all(8.0),
                            padding: const EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.blue, width: 1.5),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Text(a),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      textAlign: TextAlign.center,
                      'Groups',
                      style: TextStyle(fontSize: 16),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: data['groups'].length,
                      itemBuilder: (context, index) {
                        var a = data['groups'][index];
                        return Container(
                          margin: const EdgeInsets.all(8.0),
                          padding: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8.0), boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              blurRadius: 1.3,
                              spreadRadius: 1.3,
                              offset: Offset(1, 3),
                            )
                          ]),
                          child: Table(
                            columnWidths: const {
                              0: FixedColumnWidth(80),
                              1: FixedColumnWidth(20),
                              // 2: FixedColumnWidth(100),
                            },
                            children: [
                              TableRow(children: [
                                Text(
                                  "Nama",
                                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  ":",
                                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  a['nama'].toString(),
                                  style: TextStyle(fontSize: 15),
                                ),
                              ]),
                              TableRow(children: [
                                Text(
                                  "Member",
                                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  ":",
                                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  a['member'].toString(),
                                  style: TextStyle(fontSize: 15),
                                ),
                              ]),
                              TableRow(children: [
                                Text(
                                  "Lokasi",
                                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  ":",
                                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  a['lokasi'].toString(),
                                  style: TextStyle(fontSize: 15),
                                ),
                              ]),
                              TableRow(children: [
                                Text(
                                  "Kelompok",
                                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  ":",
                                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  a['kelompok'].toString(),
                                  style: TextStyle(fontSize: 15),
                                ),
                              ]),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                );
              },
            ),
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ButtonLogout(
                  text: "Keluar Akun",
                  icon: Icon(FontAwesomeIcons.close, color: Colors.white),
                  color: Colors.red[800],
                  onPressed: (){
                    BlocProvider.of<AuthCubit>(context).keluarAkun(context);
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
