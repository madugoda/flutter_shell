import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:flutter_shell/repository/car_provider.dart';
import 'package:flutter_shell/repository/colors.dart';
import 'package:flutter_shell/components/alert_box.dart';
import 'package:flutter_shell/screens/att_km_form.dart';
import 'package:flutter_shell/screens/my_vehicle_form.dart';
import 'package:flutter_shell/screens/maintenance_form.dart';
import 'package:flutter_shell/screens/history_form.dart';

/* Esse componente é a barra de navegação lateral do app, cada widget
ListTile é uma linha com um ícone e um texto. Quando clicamos (onTap),
é chamado o navegador, que "empurra" uma nova tela no stack do app, que é
fechada quando o formulário ou a função da tela é completa. */

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  @override
  Widget build(BuildContext context) {
    final carData = Provider.of<CarSpecs>(context);
    return Drawer(
      backgroundColor: CustomColors.whiteBack,
      child: ListView(
        children: [
          (carData.carName == '')
              ? ListTile(
                  leading: const Icon(Icons.drive_eta_rounded),
                  title: const Text('Cadastrar Veículo'),
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          FormVehicle(vehicleDataContext: context))),
                )
              : const SizedBox.shrink(),
          ListTile(
            leading: const Icon(Icons.update),
            title: const Text('Atualizar Quilometragem'),
            onTap: () {
              // Não faz sentido, inserir a manutenção ou atualizar a quilometragem
              // sem cadastrar o veículo, por isso, caso o nome do carro seja '',
              // aparece um aviso que impossibilita o usuário de entrar na aba
              if (carData.carName != '') {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (contextNew) =>
                        FormKmAtt(kmDataContext: context)));
              } else {
                showDialog(context: context, builder: (_) => const AlertBox());
              }
            },
          ),
          ListTile(
            leading: const Icon(Icons.add_task),
            title: const Text('Registrar Manutenção'),
            onTap: () {
              if (carData.carName != '') {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (contextNew) =>
                        FormHistory(histContext: context)));
              } else {
                showDialog(context: context, builder: (_) => const AlertBox());
              }
            },
          ),
          ListTile(
            leading: const Icon(Icons.construction),
            title: const Text('Agendar Manutenção'),
            onTap: () {
              if (carData.carName != '') {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (contextNew) =>
                        FormMaintenance(maintenanceContext: context)));
              } else {
                showDialog(context: context, builder: (_) => const AlertBox());
              }
            },
          ),
          ListTile(
              leading: const Icon(Icons.exit_to_app),
              title: const Text('Sair'),
              onTap: () {
                SystemNavigator.pop();
              }),
        ],
      ),
    );
  }
}
