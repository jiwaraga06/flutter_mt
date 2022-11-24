import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_mt/source/data/Auth/cubit/auth_cubit.dart';
import 'package:flutter_mt/source/data/Mesin/cubit/ket_mesin_cubit.dart';
import 'package:flutter_mt/source/data/Perawatan/Edit/cubit/edit_detail_task_perawatan_cubit.dart';
import 'package:flutter_mt/source/data/Perawatan/Edit/cubit/edit_perawatan_cubit.dart';
import 'package:flutter_mt/source/data/Perawatan/cubit/detail_task_perawatan_cubit.dart';
import 'package:flutter_mt/source/data/Perawatan/cubit/perawatan_cubit.dart';
import 'package:flutter_mt/source/data/Perawatan/cubit/post_perawatan_cubit.dart';
import 'package:flutter_mt/source/data/Perawatan/cubit/save_perawatan_cubit.dart';
import 'package:flutter_mt/source/data/Perbaikan/Edit/cubit/edit_perbaikan_cubit.dart';
import 'package:flutter_mt/source/data/Perbaikan/Edit/cubit/save_edit_perbaikan_cubit.dart';
import 'package:flutter_mt/source/data/Perbaikan/cubit/material_cubit.dart';
import 'package:flutter_mt/source/data/Perbaikan/cubit/mesin_history_perbaikan_cubit.dart';
import 'package:flutter_mt/source/data/Perbaikan/cubit/perbaikan_cubit.dart';
import 'package:flutter_mt/source/data/Perbaikan/cubit/post_perbaikan_cubit.dart';
import 'package:flutter_mt/source/data/Perbaikan/cubit/riwayat_perbaikan_cubit.dart';
import 'package:flutter_mt/source/data/Perbaikan/cubit/save_perbaikan_cubit.dart';
import 'package:flutter_mt/source/data/Perbaikan/cubit/tree_view_cubit.dart';
import 'package:flutter_mt/source/network/network.dart';
import 'package:flutter_mt/source/repository/repository.dart';
import 'package:flutter_mt/source/router/router.dart';

void main() {
  runApp(MyApp(
    router: RouterNavigation(),
    myRepository: MyRepository(myNetwork: MyNetwork()),
  ));
}

class MyApp extends StatelessWidget {
  final RouterNavigation? router;
  final MyRepository? myRepository;
  const MyApp({super.key, this.router, this.myRepository});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (auth) => AuthCubit(myRepository: myRepository),
        ),
        BlocProvider(
          create: (pebaikan) => PerbaikanCubit(myRepository: myRepository),
        ),
        BlocProvider(
          create: (save_pebaikan) => SavePerbaikanCubit(),
        ),
        BlocProvider(
          create: (tree_view) => TreeViewCubit(myRepository: myRepository),
        ),
        BlocProvider(
          create: (material) => MaterialCubit(myRepository: myRepository),
        ),
        BlocProvider(
          create: (post_perbaikan) => PostPerbaikanCubit(myRepository: myRepository),
        ),
        BlocProvider(
          create: (riwayat_perbaikan) => RiwayatPerbaikanCubit(myRepository: myRepository),
        ),
        BlocProvider(
          create: (ket_mesin) => KetMesinCubit(myRepository: myRepository),
        ),
        BlocProvider(
          create: (ket_mesin) => MesinHistoryPerbaikanCubit(myRepository: myRepository),
        ),
        BlocProvider(
          create: (edit_perbaikan) => EditPerbaikanCubit(myRepository: myRepository),
        ),
        BlocProvider(
          create: (save_edit_perbaikan) => SaveEditPerbaikanCubit(myRepository: myRepository),
        ),
        BlocProvider(
          create: (perawatan) => PerawatanCubit(myRepository: myRepository),
        ),
        BlocProvider(
          create: (perawatan) => SavePerawatanCubit(),
        ),
        BlocProvider(
          create: (perawatan) => DetailTaskPerawatanCubit(myRepository: myRepository),
        ),
        BlocProvider(
          create: (perawatan) => PostPerawatanCubit(myRepository: myRepository),
        ),
        BlocProvider(
          create: (edit_perawatan) => EditPerawatanCubit(myRepository: myRepository),
        ),
        BlocProvider(
          create: (detail_edit_perawatan) => EditDetailTaskPerawatanCubit(myRepository: myRepository),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        onGenerateRoute: router!.generateRoute,
      ),
    );
  }
}

