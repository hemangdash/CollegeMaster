import 'package:flag/flag.dart';
import 'package:flutter/material.dart';

class Country {
  String name;
  String flag;
  bool isSelected;

  Country(this.name, this.flag, this.isSelected);
}

class CustomRadio extends StatelessWidget {
  Country _country;

  CustomRadio(this._country);

  @override
  Widget build(BuildContext context) {
    return Card(
        color: _country.isSelected ? Color(0xFF68c1e7) : Colors.white,
        child: Container(
          height: 100,
          width: 60,
          alignment: Alignment.center,
          margin: new EdgeInsets.all(2.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Flag(
                _country.flag,
                height: 40,
              ),
              SizedBox(height: 10),
              Text(
                _country.name,
                style: TextStyle(
                    color: _country.isSelected ? Colors.white : Colors.grey,
                    fontFamily: 'Ubuntu',
                    fontSize: 16),
              )
            ],
          ),
        ));
  }
}

class CountrySelector extends StatefulWidget {
  @override
  _CountrySelectorState createState() => _CountrySelectorState();
}

class _CountrySelectorState extends State<CountrySelector> {
  List<Country> countries = new List<Country>();

  // ignore: missing_return
  String selectedCountry() {
    if (countries[0].isSelected) return countries[0].name;
    if (countries[1].isSelected) return countries[1].name;
    if (countries[2].isSelected) return countries[2].name;
    return null;
  }

  @override
  void initState() {
    super.initState();
    countries.add(new Country("U.S.A.", 'US', false));
    countries.add(new Country("Canada", 'CA', false));
    countries.add(new Country("U.K.", 'GB', false));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: <Widget>[
            Expanded(
                flex: 1,
                child: InkWell(
                  splashColor: Color(0xFFe3f7ff),
                  onTap: () {
                    setState(() {
                      countries[0].isSelected = true;
                      countries[1].isSelected = false;
                      countries[2].isSelected = false;
                    });
                  },
                  child: CustomRadio(countries[0]),
                )),
            Expanded(
                flex: 1,
                child: InkWell(
                  splashColor: Color(0xFFe3f7ff),
                  onTap: () {
                    setState(() {
                      countries[1].isSelected = true;
                      countries[0].isSelected = false;
                      countries[2].isSelected = false;
                    });
                  },
                  child: CustomRadio(countries[1]),
                )),
            Expanded(
                flex: 1,
                child: InkWell(
                  splashColor: Color(0xFFe3f7ff),
                  onTap: () {
                    setState(() {
                      countries[2].isSelected = true;
                      countries[0].isSelected = false;
                      countries[1].isSelected = false;
                    });
                  },
                  child: CustomRadio(countries[2]),
                )),
          ],
        ),
      ],
    );
  }
}
