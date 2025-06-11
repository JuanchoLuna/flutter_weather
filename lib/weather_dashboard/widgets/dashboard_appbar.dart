import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weather/app/router/router.dart';
import 'package:flutter_weather/weather_dashboard/weather_dashboard.dart';
import 'package:go_router/go_router.dart';

class WeatherAppBar extends StatelessWidget implements PreferredSizeWidget {
  const WeatherAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        bottomLeft: Radius.circular(24),
        bottomRight: Radius.circular(24),
      ),
      child: AppBar(
        centerTitle: true,
        backgroundColor: Colors.greenAccent[100],
        elevation: 4,
        title: Row(
          children: [
            const Text(
              'Flutter Weather',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            const Spacer(),
            IconButton(
              onPressed: () {
                context.read<WeatherDashboardBloc>().add(
                      const WeatherDashboardSearchUnselected(),
                    );
                context.push(
                  AppRoute.weatherSearch,
                  extra: context.read<WeatherDashboardBloc>(),
                );
              },
              icon: const Icon(Icons.search, color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}
