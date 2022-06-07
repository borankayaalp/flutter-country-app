import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../data/models/country_model.dart';

class CountryWidget extends StatelessWidget {
  CountryWidget({required this.countryModel, Key? key}) : super(key: key);

  final CountryModel countryModel;

  final NumberFormat populationFormat =
      NumberFormat('###,###,###,###', 'en_US');
  final NumberFormat areaFormat = NumberFormat('###,###,###,###.#', 'en_US');

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        countryModel.nameCommon,
        textAlign: TextAlign.center,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      contentPadding: const EdgeInsets.only(top: 10),
      insetPadding: const EdgeInsets.symmetric(horizontal: 36),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            alignment: AlignmentDirectional.center,
            children: [
              Image.network(
                countryModel.flagPng,
                color: Colors.white.withOpacity(0.25),
                colorBlendMode: BlendMode.modulate,
              ),
              Container(
                padding: const EdgeInsets.all(8),
                child: Column(
                  children: [
                    titleGenerator('Common Name'),
                    Text(countryModel.nameCommon,
                        style: const TextStyle(fontSize: 12)),
                    const Divider(thickness: 2),
                    titleGenerator('Official Name'),
                    Text(countryModel.nameOfficial,
                        style: const TextStyle(fontSize: 12)),
                    const Divider(thickness: 2),
                    rowGenerator(
                      firstHeader: 'Capital',
                      firstText: countryModel.capital,
                      secondHeader: 'Continent',
                      secondText: countryModel.continents,
                      firstFlex: 7,
                      secondFlex: 4,
                    ),
                    rowGenerator(
                      firstHeader: 'Population',
                      firstText:
                          populationFormat.format(countryModel.population),
                      secondHeader: 'Region',
                      secondText: countryModel.region,
                      firstFlex: 1,
                      secondFlex: 1,
                    ),
                    rowGenerator(
                      firstHeader: 'Area',
                      firstText:
                          '${areaFormat.format(countryModel.area)} km\u{00B2}',
                      secondHeader: 'Subregion',
                      secondText: countryModel.subregion,
                      firstFlex: 1,
                      secondFlex: 2,
                    ),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

Row rowGenerator({
  required String firstHeader,
  required String firstText,
  required String secondHeader,
  required String secondText,
  required int firstFlex,
  required int secondFlex,
}) {
  return Row(
    mainAxisSize: MainAxisSize.max,
    children: [
      expandedWidgetGenerator(firstHeader, firstText, firstFlex, true),
      expandedWidgetGenerator(secondHeader, secondText, secondFlex, false),
    ],
  );
}

Expanded expandedWidgetGenerator(
        String header, String text, int flex, bool isStart) =>
    Expanded(
      flex: flex,
      child: Column(
        crossAxisAlignment:
            isStart ? CrossAxisAlignment.start : CrossAxisAlignment.end,
        children: [
          titleGenerator(header),
          Text(
            text,
            style: const TextStyle(fontSize: 12),
          ),
          const Divider(thickness: 2),
        ],
      ),
    );

Text titleGenerator(String title) => Text(title,
    style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold));
