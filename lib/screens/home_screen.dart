import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/authentication/authentication_event.dart';
import '../blocs/blocs.dart';
import '../blocs/tab/tab_bloc.dart';
import '../blocs/tab/tab_event.dart';
import '../blocs/url/url_event.dart';
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
            floatingActionButton: FloatingActionButton(
              onPressed: () => _buildUrlForm(context),
              backgroundColor: Theme.of(context).primaryColor,
              child: const Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),
            bottomNavigationBar: TabSelector(
                activeTab: state,
                onTabSelected: (tab) =>
                    context.read<TabBloc>().add(UpdateTab(tab: tab)))),
      );

  Future<Widget> _buildUrlForm(BuildContext context) => showDialog(
      context: context,
      child: AlertDialog(
        content: SizedBox(
          height: 100,
          child: Column(
            children: [
              const Text('Add new url'),
              TextField(
                controller: _urlTextEditingController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Theme.of(context).accentColor),
                        borderRadius: BorderRadius.circular(5)),
                    hintText: 'Enter url link'),
              ),
            ],
          ),
        ),
        actions: [
          FlatButton(
              onPressed: () {
                _urlTextEditingController.clear();

                Navigator.of(context).pop();
              },
              child: const Text(
                'Cancel',
                style: TextStyle(color: Colors.red, fontSize: 18),
              )),
          FlatButton(
              onPressed: () {
                if (_urlTextEditingController.text.isNotEmpty) {
                  context
                      .read<UrlBloc>()
                      .add(AddUrl(inputUrl: _urlTextEditingController.text));

                  _urlTextEditingController.clear();

                  Navigator.of(context).pop();
                }
              },
              child: Text(
                'Save',
                style: TextStyle(
                    color: Theme.of(context).primaryColor, fontSize: 18),
              ))
        ],
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
