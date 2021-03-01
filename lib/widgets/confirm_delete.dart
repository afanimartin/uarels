// import 'package:Uarels/blocs/blocs.dart';
// import 'package:Uarels/blocs/url/url_state.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// import '../blocs/url/url_event.dart';
// import '../models/models.dart';

// class ConfirmDelete extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) => BlocBuilder<UrlBloc, UrlState>(builder: (context, state) => confirmUrlDelete(context));

//   Future<Widget> confirmUrlDelete(BuildContext context) => showDialog(
//       context: context,
//       child: AlertDialog(
//         content: SizedBox(
//           height: 40,
//           child: Column(
//             children: const [
//               Text('Do you want to delete this url?',
//                   style: TextStyle(
//                     fontSize: 20,
//                   )),
//             ],
//           ),
//         ),
//         actions: [
//           FlatButton(
//               onPressed: () {
//                 controller.clear();

//                 Navigator.of(context).pop();
//               },
//               child: const Text(
//                 'Cancel',
//                 style: TextStyle(color: Colors.red, fontSize: 18),
//               )),
//           FlatButton(
//               onPressed: () {
//                 context.read<UrlBloc>().add(DeleteUrl(url: url));

//                 Navigator.of(context).pop();
//               },
//               child: Text(
//                 'Confirm',
//                 style: TextStyle(
//                     color: Theme.of(context).primaryColor, fontSize: 18),
//               ))
//         ],
//       ));
// }

