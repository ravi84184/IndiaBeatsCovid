import 'package:flutter/cupertino.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:india_beats_covid/mutations/get_apis_mutation.dart';
import 'package:india_beats_covid/utils/constants.dart';
import 'package:india_beats_covid/utils/routes.dart';
import 'package:india_beats_covid/views/common/error_page.dart';
import 'package:india_beats_covid/views/home/theme_button.dart';

import '../../pkgs.dart';
import 'dashboard.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    // loadAllAPIs();
  }

  @override
  Widget build(BuildContext context) {
    loadAllAPIs();
    final Store store = VxState.store;
    return Scaffold(
      appBar: AppBar(
        title: Constants.appName.text.xl2.semiBold.make(),
        actions: [ThemeButton()],
      ),
      body: VStack(
        [
          VxBuilder(
              builder: (context, status) {
                if (status == VxStatus.none) {
                  print("loaded");
                  return const CupertinoActivityIndicator().centered();
                } else if (status == VxStatus.success) {
                  return [
                    Dashboard(stats: store.stats),
                    20.heightBox,
                    "Resources"
                        .text
                        .bodyText2(context)
                        .xl4
                        .semiBold
                        .make()
                        .px16(),
                    GestureDetector(
                      onTap: () =>
                          context.vxNav.push(Uri.parse(Routes.linkRoute)),
                      child: Card(
                        elevation: 0.0,
                        child: ListTile(
                          title: "External Links".text.xl.semiBold.make(),
                          trailing: const Icon(
                            FontAwesome.link,
                            color: Vx.purple400,
                          ),
                        ),
                      ),
                    )
                  ].vStack(crossAlignment: CrossAxisAlignment.start);
                } else if (status == VxStatus.error) {
                  return ErrorPage();
                }
                return Constants.wentWrong.text.xl2.semiBold.makeCentered();
              },
              mutations: {StatsMutation})
        ],
        crossAlignment: CrossAxisAlignment.center,
        alignment: MainAxisAlignment.center,
      ).p16().scrollVertical(),
    );
  }
}
