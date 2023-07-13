import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plot/Layout/responsive_layout.dart';

import 'package:plot/bloc/auth_bloc/auth_bloc.dart';
import 'package:plot/bloc/category_bloc/category_bloc.dart';
import 'package:plot/bloc/category_dopdown_cubit/category_items_cubit.dart';
import 'package:plot/bloc/post_bloc/post_bloc.dart';
import 'package:plot/firebase_repo/auth_repo.dart';

import 'package:plot/screens/signin_screen.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //initialising firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => AuthRepository(),
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthBloc>(
            create: (context) => AuthBloc(
              authRepository: RepositoryProvider.of<AuthRepository>(context),
            ),
          ),
          BlocProvider<PostBloc>(create: (context) => PostBloc()),
          BlocProvider<CategoryItemsCubit>(
              create: (context) => CategoryItemsCubit()),
          BlocProvider<CategoryBloc>(create: (context) => CategoryBloc()),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Plot',
          theme: ThemeData(
            primaryColor: const Color(0xff086788),
            colorScheme: ColorScheme.fromSwatch()
                .copyWith(secondary: const Color(0xffD3D3D3)),
          ),
          home: StreamBuilder(
            stream: FirebaseAuth.instance.userChanges(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.active) {
                if (snapshot.hasData) {
                  return const ResponsiveLayout();
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('$snapshot.error'),
                  );
                }
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return const LoginScreen();
            },
          ),
        ),
      ),
    );
  }
}
