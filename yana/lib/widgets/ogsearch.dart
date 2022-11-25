import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/material.dart';

class CustomSearch extends StatefulWidget {
  const CustomSearch({super.key});

  @override
  State<CustomSearch> createState() => _CustomSearchState();
}

class _CustomSearchState extends State<CustomSearch> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      child: CSCPicker(
        layout: Layout.vertical,
        // flagState: CountryFlag.DISABLE,
        defaultCountry: DefaultCountry.India,
        disableCountry: true,
        onCountryChanged: (country) {},
        onStateChanged: (state) {},
        onCityChanged: (city) {},
      ),
    );
  }
}
