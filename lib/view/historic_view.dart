import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_calc/controller/historic_controller.dart';
import 'package:simple_calc/controller/theme_controller.dart';


class HistoricView extends StatelessWidget {
  const HistoricView({super.key});

    showDeleteConfirmationDialog(BuildContext context, dynamic clr) {
      return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Confirmação'),
            content: Text('Tem certeza que deseja apagar o histórico?'),
            actions: <Widget>[
              TextButton(
                child: Text('Cancelar'),
                onPressed: () {
                  Navigator.of(context).pop(); // Fecha o diálogo
                },
              ),
              TextButton(
                child: Text('Sim'),
                onPressed: () {
                  Navigator.of(context).pop(); // Fecha o diálogo
                  clr(); // Executa a ação de apagar
                },
              ),
            ],
          );
        },
      );
  }

  @override
  Widget build(BuildContext context) {
    final themeController = context.watch<ThemeController>();
    final historicController = context.watch<HistoricController>();

    List<List<dynamic>> operations = historicController.data.reversed.toList();

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              showDeleteConfirmationDialog(context, historicController.clear);
            },
            icon: Icon(Icons.delete),
          ),
          IconButton(onPressed: themeController.selectTheme, icon: themeController.iconTheme),
          IconButton(onPressed: () => {Navigator.of(context).popAndPushNamed('/')}, icon: Icon(Icons.exit_to_app)),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: operations.length,
        itemBuilder: (context, index) {
          final op = operations[index];
          return Card(
            elevation: 3,
            margin: const EdgeInsets.symmetric(vertical: 6),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    op[0],
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    "${op[1]}",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ],
              ),
            ),
          );
        },      
      )
    );
  }
}