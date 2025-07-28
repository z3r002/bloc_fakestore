import 'package:auto_route/auto_route.dart';
import 'package:bloc_pet/core/routing/router.gr.dart';
import 'package:flutter/material.dart';

import '../../main.dart';

@RoutePage()
class UISplashScreen extends StatefulWidget {
  const UISplashScreen({Key? key}) : super(key: key);

  @override
  State<UISplashScreen> createState() => _UISplashScreenState();
}

class _UISplashScreenState extends State<UISplashScreen> {
  // final AuthStore authStore = GetIt.I.get<AuthStore>();
  // final HomeStore homeStore = GetIt.I.get<HomeStore>();


  @override
  void initState() {
    init();
    super.initState();
  }
  init()async{
    appRouter.replace(ProductScreenRoute());
    // await homeStore.checkVersion();
    //await initla();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
    );
  }
}