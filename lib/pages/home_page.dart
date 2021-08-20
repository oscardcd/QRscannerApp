import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:qrscannerapp/pages/direcciones_page.dart';
import 'package:qrscannerapp/pages/mapas_page.dart';

import 'package:qrscannerapp/providers/db_provider.dart';
import 'package:qrscannerapp/providers/scan_list_provider.dart';
import 'package:qrscannerapp/providers/ui_provider.dart';

import 'package:qrscannerapp/widgets/custom_navigatorbar.dart';
import 'package:qrscannerapp/widgets/scan_button.dart';


class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('Historial'),
        actions: [
          IconButton(
            icon: Icon( Icons.delete_forever ), 
            onPressed: (){

              Provider.of<ScanListProvider>(context, listen: false)
                .borrarTodos();

            }
          )
        ],
      ),
      body: _HomePageBody(),

     bottomNavigationBar: CustomNavigationBar(),
     floatingActionButton: ScanButton(),
     floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
   );
  }
}


class _HomePageBody extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {

    // Obtener el selected menu opt
    final uiProvider = Provider.of<UiProvider>(context);
    
    // Cambiar para mostrar la pagina respectiva
    final currentIndex = uiProvider.selectedMenuOpt;

    // Usar el ScanListProvider
    final scanListProvider = Provider.of<ScanListProvider>(context, listen: false);

    switch( currentIndex ) {

      case 0:
        scanListProvider.cargarScanPorTipo('geo');
        return MapasPage();

      case 1: 
        scanListProvider.cargarScanPorTipo('http');
        return DireccionesPage();

      default:
        return MapasPage();
    }


  }
}