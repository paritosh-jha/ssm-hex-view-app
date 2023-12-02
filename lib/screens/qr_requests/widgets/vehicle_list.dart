import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hex_view/shared/screens/requests_screen/requests.dart';

class VehicleList extends StatelessWidget {
  final Map<String, String> vehicles;
  const VehicleList({super.key, required this.vehicles});

  @override
  Widget build(BuildContext context) {
    return vehicles.isEmpty
        ? const Center(
            child: Text('No vehicles added'),
          )
        : ListView.builder(
            itemBuilder: (context, index) {
              final entry = vehicles.entries.elementAt(index);
              final vehicleNickname = entry.key;
              final vehicleNumber = entry.value;
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 2),
                child: Card(
                  elevation: 0,
                  child: ListTile(
                    leading: const CircleAvatar(
                      backgroundColor: Colors.black26,
                      foregroundColor: Colors.white,
                      child: Icon(
                        FontAwesomeIcons.car,
                        size: 15,
                      ),
                    ),
                    title: Text(vehicleNickname),
                    subtitle: Text(vehicleNumber),
                    trailing: const Icon(
                      FontAwesomeIcons.angleRight,
                      size: 15,
                    ),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => RequestsScreen(
                            vehicleNumber: vehicleNumber,
                            vehicleNickname: vehicleNickname,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              );
            },
            itemCount: vehicles.length,
          );
  }
}
