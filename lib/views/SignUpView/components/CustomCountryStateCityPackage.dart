import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:google_fonts/google_fonts.dart';

class CustomStatusModel {
  int? id;
  String? name;
  String? emoji;
  String? emojiU;
  List<CustomStateModel>? state;

  CustomStatusModel({this.id, this.name, this.emoji, this.emojiU, this.state});

  CustomStatusModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    emoji = json['emoji'];
    emojiU = json['emojiU'];
    if (json['state'] != null) {
      state = [];
      json['state'].forEach((v) {
        state!.add(CustomStateModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'emoji': emoji,
      'emojiU': emojiU,
      'state': state?.map((v) => v.toJson()).toList(),
    };
  }
}

class CustomStateModel {
  int? id;
  String? name;
  int? countryId;
  List<CustomCity>? Customcity;

  CustomStateModel({this.id, this.name, this.countryId, this.Customcity});

  CustomStateModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    countryId = json['country_id'];
    if (json['city'] != null) {
      Customcity = [];
      json['city'].forEach((v) {
        Customcity!.add(CustomCity.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'country_id': countryId,
      'city': Customcity?.map((v) => v.toJson()).toList(),
    };
  }
}

class CustomCity {
  int? id;
  String? name;
  int? stateId;

  CustomCity({this.id, this.name, this.stateId});

  CustomCity.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    stateId = json['state_id'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'state_id': stateId,
    };
  }
}

class CustomSelectState extends StatefulWidget {
  final ValueChanged<String> onCountryChanged;
  final ValueChanged<String> onStateChanged;
  final ValueChanged<String> onCustomCityChanged;
  final TextStyle? style;

  const CustomSelectState({
    Key? key,
    required this.onCountryChanged,
    required this.onStateChanged,
    required this.onCustomCityChanged,
    this.style,
  }) : super(key: key);

  @override
  _CustomSelectStateState createState() => _CustomSelectStateState();
}

class _CustomSelectStateState extends State<CustomSelectState> {
  List<String> _cities = [];
  List<String> _country = [];
  List<String> _states = [];
  String? _selectedCustomCity;
  String? _selectedCountry;
  String? _selectedState;

  @override
  void initState() {
    super.initState();
    _loadCountryData();
  }

  Future<void> _loadCountryData() async {
    try {
      var data =
          await rootBundle.loadString('assets/signUpAssets/country.json');
      var countryList = (jsonDecode(data) as List)
          .map((e) => CustomStatusModel.fromJson(e))
          .toList();

      setState(() {
        // Use only the country name without emoji
        _country = []; // Reset to avoid duplicates
        _country.addAll(countryList.map((country) => country.name!).toList());
      });
    } catch (e) {
      print('Error loading country data: $e');
    }
  }

  Future<void> _loadStates() async {
    // Reset states when loading
    _states = [];
    var data = await rootBundle.loadString('assets/signUpAssets/country.json');
    var countryList = (jsonDecode(data) as List)
        .map((e) => CustomStatusModel.fromJson(e))
        .toList();

    var selectedCountry = countryList.firstWhere(
        (country) => country.name == _selectedCountry,
        orElse: () => CustomStatusModel());

    setState(() {
      _states.addAll(selectedCountry.state?.map((s) => s.name!).toList() ?? []);
    });
  }

  Future<void> _loadCities() async {
    _cities = ["Choose City"];
    var data = await rootBundle.loadString('assets/signUpAssets/country.json');
    var countryList = (jsonDecode(data) as List)
        .map((e) => CustomStatusModel.fromJson(e))
        .toList();

    var selectedCountry = countryList.firstWhere(
        (country) => country.name == _selectedCountry,
        orElse: () => CustomStatusModel());

    var selectedState = selectedCountry.state?.firstWhere(
        (state) => state.name == _selectedState,
        orElse: () => CustomStateModel());

    setState(() {
      final cityNames =
          selectedState?.Customcity?.map((c) => c.name!).toSet().toList() ?? [];
      _cities.addAll(cityNames);

      if (!_cities.contains(_selectedCustomCity)) {
        _selectedCustomCity = null;
      }
    });
  }

  void _onSelectedCountry(String value) {
    setState(() {
      _selectedCountry = value;
      _selectedState = null;
      _selectedCustomCity = null;
      _states = [];
      _cities = [];
      widget.onCountryChanged(value);
      _loadStates();
    });
  }

  void _onSelectedState(String value) {
    setState(() {
      _selectedState = value;
      _selectedCustomCity = null;
      _cities = ["Choose City"];
      widget.onStateChanged(value);
      _loadCities();
    });
  }

  void _onSelectedCustomCity(String value) {
    setState(() {
      _selectedCustomCity = value;
      widget.onCustomCityChanged(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Country Dropdown
        Text(
          'Country',
          style: GoogleFonts.inter(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: const Color.fromRGBO(32, 37, 56, 1),
          ),
        ),
        const SizedBox(height: 13),
        Container(
          height: 40,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
                width: 1, color: const Color.fromRGBO(216, 218, 220, 1)),
          ),
          child: DropdownButton<String>(
            dropdownColor: Colors.white,
            underline: const SizedBox.shrink(),
            icon: const SizedBox.shrink(),
            hint: Text(
              'Choose here',
              style: GoogleFonts.inter(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: const Color.fromRGBO(128, 128, 128, 1),
              ),
            ),
            isExpanded: true,
            items: _country
                .map((item) => DropdownMenuItem(
                    value: item,
                    child: Text(
                      item,
                      style: GoogleFonts.inter(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: const Color.fromRGBO(32, 37, 56, 1),
                      ),
                    )))
                .toList(),
            onChanged: (value) => _onSelectedCountry(value!),
            value: _selectedCountry,
          ),
        ),

        const SizedBox(height: 16.0),

        // State Dropdown
        Text(
          'State',
          style: GoogleFonts.inter(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: const Color.fromRGBO(32, 37, 56, 1),
          ),
        ),
        const SizedBox(height: 13),
        Container(
          height: 40,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
                width: 1, color: const Color.fromRGBO(216, 218, 220, 1)),
          ),
          child: DropdownButton<String>(
            dropdownColor: Colors.white,
            underline: const SizedBox.shrink(),
            icon: const SizedBox.shrink(),
            hint: Text(
              'Choose here',
              style: GoogleFonts.inter(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: const Color.fromRGBO(128, 128, 128, 1),
              ),
            ),
            isExpanded: true,
            items: _states
                .map((item) => DropdownMenuItem(
                    value: item,
                    child: Text(
                      item,
                      style: GoogleFonts.inter(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: const Color.fromRGBO(32, 37, 56, 1),
                      ),
                    )))
                .toList(),
            onChanged: (value) => _onSelectedState(value!),
            value: _selectedState,
          ),
        ),
        const SizedBox(height: 16.0),
        Text(
          'City',
          style: GoogleFonts.inter(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: const Color.fromRGBO(32, 37, 56, 1),
          ),
        ),
        const SizedBox(height: 13),
        Container(
          height: 40,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
                width: 1, color: const Color.fromRGBO(216, 218, 220, 1)),
          ),
          child: DropdownButton<String>(
            dropdownColor: Colors.white,
            underline: const SizedBox.shrink(),
            icon: const SizedBox.shrink(),
            hint: Text(
              'Choose here',
              style: GoogleFonts.inter(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: const Color.fromRGBO(128, 128, 128, 1),
              ),
            ),
            isExpanded: true,
            items: _cities
                .map((item) => DropdownMenuItem(
                    value: item,
                    child: Text(
                      item,
                      style: GoogleFonts.inter(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: const Color.fromRGBO(32, 37, 56, 1),
                      ),
                    )))
                .toList(),
            onChanged: (value) => _onSelectedCustomCity(value!),
            value: _cities.contains(_selectedCustomCity)
                ? _selectedCustomCity
                : null,
          ),
        ),
      ],
    );
  }
}
