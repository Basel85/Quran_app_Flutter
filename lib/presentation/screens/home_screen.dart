import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:quran_app/presentation/cubits/bottom_navigation_bar/bottom_navigation_bar_cubit.dart';
import 'package:quran_app/presentation/cubits/bottom_navigation_bar/bottom_navigation_bar_states.dart';
import 'package:quran_app/presentation/widgets/home/drawer_non_header_component.dart';
import 'package:quran_app/presentation/widgets/home/prayer_body.dart';
import 'package:quran_app/presentation/widgets/home/user_main_body.dart';
import 'package:quran_app/presentation/widgets/shared/custom_app_bar.dart';
import 'package:quran_app/presentation/widgets/shared/custom_bottom_navigation_bar_item_icon.dart';
import 'package:quran_app/utils/app_assets.dart';
import 'package:quran_app/utils/app_themes.dart';
import 'package:quran_app/utils/size_config.dart';

class HomeScreen extends StatelessWidget {
  final String? displayName;
  const HomeScreen({super.key, required this.displayName});

  String getTheTitleOfTheAppBar(int index) {
    switch (index) {
      case 1:
        return "Prayer";
      default:
        return "Quran App";
    }
  }

  void gett(BottomNavigationBarState state) {
    if (state is BottomNavigationBarIndexChangedState) {

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(92 * SizeConfig.verticalBlock),
        child: BlocBuilder<BottomNavigationBarCubit, BottomNavigationBarState>(
            buildWhen: (previous, current) =>
                current is BottomNavigationBarIndexChangedState,
            builder: (_, state) => CustomAppBar(
                  title: getTheTitleOfTheAppBar(
                      state is BottomNavigationBarIndexChangedState
                          ? state.index
                          : 0),
                  isNotMainUserScreenAndNonBottomNavigationBarScreens:
                      state is BottomNavigationBarIndexChangedState &&
                              state.index != 0
                          ? true
                          : false,
                )),
      ),
      drawer: Container(
        width: 205 * SizeConfig.horizontalBlock,
        height: double.infinity,
        decoration: ShapeDecoration(
          color: AppThemes.pureWhite,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          shadows: const [
            BoxShadow(
              color: AppThemes.color0x3F000000,
              blurRadius: 10,
              offset: Offset(4, 4),
              spreadRadius: 0,
            )
          ],
        ),
        child: ListView(
          children: [
            SizedBox(
              height: 31 * SizeConfig.verticalBlock,
            ),
            Container(
              margin: EdgeInsets.only(
                  left: 24 * SizeConfig.horizontalBlock,
                  bottom: 39 * SizeConfig.verticalBlock),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.only(
                        top: 11 * SizeConfig.verticalBlock,
                        bottom: 7 * SizeConfig.verticalBlock,
                        right: 9 * SizeConfig.horizontalBlock,
                        left: 9 * SizeConfig.horizontalBlock),
                    decoration: const ShapeDecoration(
                      color: AppThemes.color0xFF300759,
                      shape: OvalBorder(),
                    ),
                    child: SvgPicture.asset(AppAssets.helalIcon),
                  ),
                  SizedBox(
                    width: 12 * SizeConfig.horizontalBlock,
                  ),
                  Expanded(
                      child: Text(
                    displayName!,
                    style: AppThemes.color0xFF300759FontSize13FontWeightW600,
                  ))
                ],
              ),
            ),
            NonHeaderDrawerComponent(
                onTap: () => Navigator.pushNamed(context, '/notification'),
                nonHeaderDrawerIcon: Icons.notifications,
                nonHeaderDrawerText: "Notification"),
            NonHeaderDrawerComponent(
                onTap: () => Navigator.pushNamed(context, '/settings'),
                nonHeaderDrawerIcon: Icons.settings,
                nonHeaderDrawerText: "Settings"),
            NonHeaderDrawerComponent(
                onTap: () {},
                nonHeaderDrawerIcon: Icons.logout,
                nonHeaderDrawerText: "Log Out"),
          ],
        ),
      ),
      body: BlocBuilder<BottomNavigationBarCubit, BottomNavigationBarState>(
        buildWhen: (previous, current) =>
            current is BottomNavigationBarIndexChangedState,
        builder: (_, state) => IndexedStack(
          index:
              state is BottomNavigationBarIndexChangedState ? state.index : 0,
          children: [
            UserMainBody(displayName: displayName!),
            const PrayerBody()
          ],
        ),
      ),
      bottomNavigationBar:
          BlocBuilder<BottomNavigationBarCubit, BottomNavigationBarState>(
        buildWhen: (previous, current) =>
            current is BottomNavigationBarIndexChangedState,
        builder: (_, state) => BottomNavigationBar(
          currentIndex:
              state is BottomNavigationBarIndexChangedState ? state.index : 0,
          onTap: (index) {
            if (state is BottomNavigationBarIndexChangedState) {
              if (index != state.index) {
                BottomNavigationBarCubit.get(context).changeIndex(index);
              }
            } else {
              if (index != 0) {
                BottomNavigationBarCubit.get(context).changeIndex(index);
              }
            }
          },
          
          backgroundColor: AppThemes.color0xFFDAD0E1,
          elevation: 0,
          selectedIconTheme: IconThemeData(
              color: AppThemes.pureWhite, size: 35 * SizeConfig.verticalBlock),
          unselectedIconTheme: IconThemeData(
              color: AppThemes.color0xFF300759,
              size: 19.51 * SizeConfig.horizontalBlock),
          items: [
            BottomNavigationBarItem(
              icon: CustomBottomNavigationBarItemIcon(
                iconData: FontAwesomeIcons.bookQuran,
                isSelected: state is! BottomNavigationBarIndexChangedState ||
                        state.index == 0
                    ? true
                    : false,
              ),
              label: "",
            ),
            BottomNavigationBarItem(
              icon: CustomBottomNavigationBarItemIcon(
                iconData: FontAwesomeIcons.mosque,
                isSelected: state is BottomNavigationBarIndexChangedState &&
                        state.index == 1
                    ? true
                    : false,
              ),
              label: "",
            ),
            
          ],
          
        ),
      ),
    );
  }
}
