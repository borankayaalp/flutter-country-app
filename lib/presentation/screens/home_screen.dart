import 'package:country_app/presentation/widgets/groupWidgets/group_grid_widget.dart';
import 'package:country_app/presentation/widgets/sorting_grouping_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sliver_tools/sliver_tools.dart';

import '../../data/functions/functions.dart';
import '../../data/models/country_model.dart';
import '../../logic/bloc/countrybloc/country_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: BlocBuilder<CountryBloc, CountryState>(
        builder: (context, state) {
          if (state is CountryLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is CountryInitialState) {
            return Center(
              child: ElevatedButton(
                onPressed: () {
                  BlocProvider.of<CountryBloc>(context).add(LoadCountryEvent());
                },
                child: const Text('Get the Countries',
                    style: TextStyle(fontSize: 18)),
              ),
            );
          }

          if (state is CountryLoadedState) {
            List<MapEntry<String, List<CountryModel>>> sortedGroupedList =
                (generateCountryMap(state.groupingStatus, state.countryList)
                      ..forEach(
                        (key, value) {
                          value.sort((country1, country2) => generateSorting(
                              state.sortingStatus, country1, country2));
                        },
                      ))
                    .entries
                    .toList();

            return CustomScrollView(
              slivers: [
                SliverAppBar(
                  backgroundColor: Theme.of(context).primaryColor,
                  expandedHeight: 125,
                  pinned: true,
                  flexibleSpace: const FlexibleSpaceBar(
                    title: Text('REST Country API'),
                    centerTitle: true,
                  ),
                ),
                const SliverToBoxAdapter(
                  child: SortGroupWidget(),
                ),
                MultiSliver(
                  children: buildCountryGroups(gridGroupedList: sortedGroupedList),
                )
              ],
            );
          }
          return const Center();
        },
      ),
    );
  }
}

List<Widget> buildCountryGroups(
        {required List<MapEntry<String, List<CountryModel>>>
            gridGroupedList}) =>
    gridGroupedList
        .map((e) => GroupGridWidget(groupTitle: e.key, countryList: e.value))
        .toList();
