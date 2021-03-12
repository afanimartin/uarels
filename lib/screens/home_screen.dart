import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uarels/blocs/public_url/public_url_event.dart';

import '../blocs/authentication/authentication_event.dart';
import '../blocs/blocs.dart';
import '../blocs/favorite_url/favorite_url_state.dart';
import '../blocs/tab/tab_bloc.dart';
import '../blocs/tab/tab_event.dart';
import '../models/models.dart';
import '../widgets/favorite_urls.dart';
import '../widgets/private_urls.dart';
import '../widgets/public_urls.dart';
import '../widgets/widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  static Route<void> route() =>
      MaterialPageRoute<void>(builder: (_) => const HomeScreen());

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _urlTextEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) => BlocBuilder<TabBloc, AppTab>(
        builder: (context, state) => Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: const Icon(
                  Icons.person_outline,
                  size: 30,
                ),
                onPressed: () {},
              ),
              elevation: 4,
              backgroundColor: Theme.of(context).primaryColor,
              centerTitle: true,
              title: const Text(
                'Uarels',
                style: TextStyle(
                    fontSize: 28, letterSpacing: 1.2, color: Colors.white),
              ),
              actions: [
                IconButton(
                    icon: const Icon(
                      Icons.exit_to_app,
                      size: 30,
                    ),
                    onPressed: () =>
                        context.read<AuthenticationBloc>().add(LogUserOut()))
              ],
            ),
            body: _renderUrls(state),
            floatingActionButton:
                BlocBuilder<FavoriteUrlBloc, FavoriteUrlState>(
              builder: (context, favoriteState) => Visibility(
                // ignore: avoid_bool_literals_in_conditional_expressions
                visible: state == AppTab.public ? true : false,
                child: FloatingActionButton(
                  onPressed: () => _buildUrlForm(context),
                  backgroundColor: Theme.of(context).primaryColor,
                  child: favoriteState is AddingToFavorites
                      ? const ProgressLoader()
                      : const Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                ),
              ),
            ),
            bottomNavigationBar: TabSelector(
                activeTab: state,
                onTabSelected: (tab) =>
                    context.read<TabBloc>().add(UpdateTab(tab: tab)))),
      );

  Future<Widget> _buildUrlForm(BuildContext context) => showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      enableDrag: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: _urlTextEditingController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Theme.of(context).accentColor),
                          borderRadius: BorderRadius.circular(5)),
                      hintText: 'Paste url link'),
                ),
                const SizedBox(height: 6),
                ElevatedButton(
                    onPressed: () {
                      if (_urlTextEditingController.text.isNotEmpty) {
                        context.read<PublicUrlBloc>().add(
                            AddUrl(inputUrl: _urlTextEditingController.text));

                        _urlTextEditingController.clear();

                        Navigator.pop(context);
                      }
                    },
                    style: ButtonStyle(
                        minimumSize:
                            MaterialStateProperty.all(const Size(400, 50)),
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Theme.of(context).primaryColor),
                        padding: MaterialStateProperty.all(
                            const EdgeInsets.all(16))),
                    child: const Text(
                      'Save url',
                      style: TextStyle(fontSize: 20),
                    ))
              ],
            ),
          ));

  Widget _renderUrls(AppTab state) {
    switch (state) {
      case AppTab.public:
        return const PublicUrls();
        break;
      case AppTab.private:
        return const PrivateUrls();
        break;
      case AppTab.favourites:
        return const FavoriteUrls();
        break;

      default:
        break;
    }
    return const Text('');
  }
}
