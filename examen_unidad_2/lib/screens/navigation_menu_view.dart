import 'package:examen_unidad_2/router/list_routers.dart';
import 'package:examen_unidad_2/router/routers.dart';
import 'package:flutter/material.dart';

class NavigationExample extends StatefulWidget {
  final Widget child;

  const NavigationExample({super.key, required this.child});
  
  @override
  State<NavigationExample> createState() => _NavigationExampleState();
}

class _NavigationExampleState extends State<NavigationExample> {
  int currentPageIndex = 0;

  // Lista de rutas asociadas a las vistas del NavigationBar
  final List<String> _routes = [
    // Routers.categories, // Página de Categorías
          
    
    Routers.finder,
    Routers.cart,  
    Routers.lastseen,   
    // router.user   
    
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });

          // Cambiar la ruta actual
          Navigator.pushReplacementNamed(
            context,
            _routes[currentPageIndex],
          );
        },
        selectedIndex: currentPageIndex,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.search),
            label: 'Buscador',
          ),
          NavigationDestination(
            icon: Icon(Icons.shopping_cart),
            label: 'Carrito',
          ),
          NavigationDestination(
            icon: Icon(Icons.history),
            label: 'Vistos',
          ),
          NavigationDestination(
            icon: Icon(Icons.person),
            label: 'Perfil',
          ),
        ],
      ),
      // Renderizar la pantalla según la ruta seleccionada
      body: widget.child
    );
  }
}
