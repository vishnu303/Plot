import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:plot/bloc/auth_bloc/auth_bloc.dart';
import 'package:plot/screens/edit_profile_screen.dart';
import 'package:plot/screens/my_ads_screen.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  @override
  void initState() {
    //BlocProvider.of<AuthBloc>(context).add(const GetUserDetails());
    super.initState();
  }

  @override
  void didChangeDependencies() {
    context.watch<AuthBloc>().add(GetUserDetails());
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: ListView(
        children: [
          const SizedBox(
            height: 10,
          ),
          BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              return Container(
                padding: const EdgeInsets.all(10),
                height: 100,
                width: MediaQuery.of(context).size.width,
                child: Row(
                  children: [
                    CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 40,
                        backgroundImage: state is Authenticated
                            ? NetworkImage(state.userdata!.photoUrl)
                            : const AssetImage('assets/user.png')
                                as ImageProvider),
                    const SizedBox(
                      width: 25,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          state is Authenticated
                              ? state.userdata!.username
                              : 'Login to account',
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          state is Authenticated
                              ? state.userdata!.email
                              : 'No email',
                          style: const TextStyle(
                            fontSize: 16,
                            overflow: TextOverflow.ellipsis,
                          ),
                          maxLines: 1,
                        )
                      ],
                    ),
                    const Spacer(),
                    state is Authenticated
                        ? ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    Theme.of(context).primaryColor),
                            onPressed: () =>
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => EditProfileScreen(
                                          email: state.userdata!.email,
                                          username: state.userdata!.username,
                                          photoUrl: state.userdata!.photoUrl,
                                        ))),
                            child: const Text('Edit'))
                        : ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                disabledBackgroundColor: Colors.grey,
                                backgroundColor:
                                    Theme.of(context).primaryColor),
                            onPressed: () {},
                            child: const Text('Edit'))
                  ],
                ),
              );
            },
          ),
          const Divider(),
          ListTile(
            leading: Icon(Icons.my_library_books_rounded),
            title: Text('My Ads'),
            onTap: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const MyAdsScreen())),
          ),
          ListTile(
            leading: Icon(Icons.favorite_rounded),
            title: Text('Wishlist'),
          ),
          ListTile(
            leading: Icon(Icons.password),
            title: Text('Change Password'),
          ),
          ListTile(
            leading: Icon(
              Icons.delete,
              color: Colors.red,
            ),
            title: Text('Delete Account'),
          ),
          ListTile(
            leading: Icon(FontAwesomeIcons.fileContract),
            title: Text('Version'),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.05,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 90),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor),
                onPressed: () {},
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  child: Text(
                    'Log Out',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                )),
          )
        ],
      )),
    );
  }
}
