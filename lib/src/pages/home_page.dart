import 'package:cl3_t6nn_rodriguez_leon_mitchell/src/providers/menu_provider.dart';
import 'package:cl3_t6nn_rodriguez_leon_mitchell/utils/icon_string_util.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Evaluación de Laboratorio 3')),
      body: _list(),
    );
  }

  Widget _list() {
    return FutureBuilder (
      future: menuProvider.loadData(),
      initialData: [],
      builder: ( context, AsyncSnapshot<List<dynamic>> snapshot) {
        if(snapshot.hasError) {
          return Center(child: Text('Error'));
        }

        if(!snapshot.hasData) {
          return Center(child: Text('There\'s no data'));
        }

        return ListView(
        children: _listItems(snapshot.data, context),
      );
      }
    );
  }

  List<Widget> _listItems(List<dynamic>? data, BuildContext context) {
    final List<Widget> options = [];

    data?.forEach((option) {
      final widgetTemp = ListTile(
        title: Text(option['name']),
        leading: getIcon(option['icon']),
        trailing: Icon(Icons.keyboard_arrow_right, color: Colors.red),
        onTap: () {
          Navigator.pushNamed(context, option['route']);
        },
      );

      options..add(widgetTemp)
      ..add(Divider());
    });

    return options;
  }
}



