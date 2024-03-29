import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plot/bloc/auth_bloc/auth_bloc.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  void initState() {
    BlocProvider.of<AuthBloc>(context).add(const GetUserDetails());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state is Authenticated) {
              return Center(
                child: Text(state.userdata!.uid),
              );
            }
            return const Center(
              child: Text('error'),
            );
          },
        ),
        TextButton(
          onPressed: () {
            FirebaseAuth.instance.signOut();
          },
          child: const Text('Logout'),
        ),
      ],
    );
  }
}
