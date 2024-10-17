import 'package:admin/views/screens/side_bar_screens/categories_screen.dart';
import 'package:admin/views/screens/side_bar_screens/dashboard_screen.dart';
import 'package:admin/views/screens/side_bar_screens/order_screen.dart';
import 'package:admin/views/screens/side_bar_screens/product_screen.dart';
import 'package:admin/views/screens/side_bar_screens/upload_banner_screen.dart';
import 'package:admin/views/screens/side_bar_screens/venders_screen.dart';
import 'package:admin/views/screens/side_bar_screens/withdrawal_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  Widget _selectItem = const DashboardScreen();

  screenSelector(item){
    switch (item.route) {
      case DashboardScreen.routeName:
        setState(() {
          _selectItem = const DashboardScreen();
        });
        break;

      case VenderScreen.routeName:
        setState(() {
          _selectItem = const VenderScreen();
        });
        break;

      case WithdrawalScreen.routeName:
        setState(() {
          _selectItem = const WithdrawalScreen();
        });
        break;

      case OrderScreen.routeName:
        setState(() {
          _selectItem = const OrderScreen();
        });
        break;

      case CategoriesScreen.routeName:
        setState(() {
          _selectItem = const CategoriesScreen();
        });
        break;

      case ProductScreen.routeName:
        setState(() {
          _selectItem = const ProductScreen();
        });
        break;

      case UploadBannerScreen.routeName:
        setState(() {
          _selectItem = const UploadBannerScreen();
        });
        break;
      default:
    }
  }


  @override
  Widget build(BuildContext context) {
    return AdminScaffold(
      appBar: AppBar(
        flexibleSpace: Container(
            decoration: BoxDecoration(
              color: Colors.green[200],
            ),
          ),
        title: const Text('Management'),
      ),
      sideBar: SideBar(
        backgroundColor: Colors.white,
        iconColor: Colors.grey[700],
        textStyle: TextStyle(color: Colors.grey[700]),
        items: const [
          AdminMenuItem(
            title: 'Dashboard',
            icon: Icons.dashboard,
            route: DashboardScreen.routeName,
          ),
          AdminMenuItem(
            title: 'Venders',
            icon: CupertinoIcons.person_3,
            route: VenderScreen.routeName,
          ),
          AdminMenuItem(
            title: 'Withdrawal',
            icon: CupertinoIcons.money_dollar,
            route: WithdrawalScreen.routeName,
          ),
          AdminMenuItem(
            title: 'Orders',
            icon: CupertinoIcons.shopping_cart,
            route: OrderScreen.routeName,
          ),
          AdminMenuItem(
            title: 'Categories',
            icon: Icons.category,
            route: CategoriesScreen.routeName,
          ),
          AdminMenuItem(
            title: 'Products',
            icon: Icons.shop,
            route: ProductScreen.routeName,
          ),
          AdminMenuItem(
            title: 'Upload Banners',
            icon: CupertinoIcons.add,
            route: UploadBannerScreen.routeName,
          )
        ],
        selectedRoute: '',
        onSelected: (item) {
          screenSelector(item);
        },
        header: Container(
          height: 50,
          width: double.infinity,
          color: Colors.green[50],
          child: const Center(
            child: Text(
              'Eshop panel',
              style: TextStyle(
                color: Colors.black54,
              ),
            ),
          ),
        ),
        footer: Container(
          height: 50,
          width: double.infinity,
          color: Colors.green[50],
          child: const Center(
            child: Text(
              'footer',
              style: TextStyle(
                color: Colors.black54,
              ),
            ),
          ),
        ),
      ),
      body: _selectItem,
    );
  }
}
