import 'dart:convert';
import 'package:Nirvana/constants.dart';
import 'package:http/http.dart';
import 'package:Nirvana/models/Property.dart';

Future<List<Property>> getProperties(Map<String, dynamic> order) async {
  List<Property> reports = [];
  try {
    final url = (server+"/properties");
    Response response = await post(Uri.encodeFull(url), body: json.encode(order), headers: {"Content-Type": "application/json", "Connection": "Keep-Alive"},);
    List data = jsonDecode(response.body)["data"];
    for (int i = 0; i < data.length; i++) {
      Property _property = new Property(
            index: data[i]["index"],
            name: data[i]["name"],
            bhk: data[i]["BHK"],
            type: data[i]["type"],
            floor: data[i]["floor"],
            description: data[i]["description"],
            latitude: data[i]["latitude"],
            longitude: data[i]["longitude"],
            location: data[i]["location"],
            city: data[i]["city"],
            pincode: data[i]["pincode"],
            state: data[i]["state"],
            country: data[i]["country"],
            numberOfRooms: data[i]["numberOfRooms"],
            landlord_id: data[i]["landlord_id"],
            landmark_id: data[i]["landmark_id"],
            price: data[i]["price"],
            area_in_sqft: data[i]["area_in_sqft"],
            status: data[i]["status"],
            deposit: data[i]["deposit"],
            bathrooms: data[i]['bathrooms'],
            facing: data[i]["facing"],
            photos_urls: data[i]["photos_urls"],
            rating: data[i]["rating"],
            remarks: data[i]["remarks"],
            is_verified: data[i]["is_verified"],
            is_accquired: data[i]["is_accquired"],
            created_at: data[i]["created_at"],
            updated_at: data[i]["updated_at"],
      );
      reports.add(_property);
    }
  } catch (e) {
    print(e);
  }
  return reports;
}

Future<List<Property>> getFilteredProperties(Map<String, dynamic> filter) async {
  List<Property> reports = [];
  try {
    final url = (server+"properties/apply_filter");
    Response response = await post(Uri.encodeFull(url), body: json.encode(filter), headers: {"Content-Type": "application/json", "Connection": "Keep-Alive"},);
    List data = jsonDecode(response.body)["data"];
    for (int i = 0; i < data.length; i++) {
      Property _property = new Property(
            index: data[i]["index"],
            name: data[i]["name"],
            bhk: data[i]["BHK"],
            type: data[i]["type"],
            floor: data[i]["floor"],
            description: data[i]["description"],
            latitude: data[i]["latitude"],
            longitude: data[i]["longitude"],
            location: data[i]["location"],
            city: data[i]["city"],
            pincode: data[i]["pincode"],
            state: data[i]["state"],
            country: data[i]["country"],
            numberOfRooms: data[i]["numberOfRooms"],
            landlord_id: data[i]["landlord_id"],
            landmark_id: data[i]["landmark_id"],
            price: data[i]["price"],
            area_in_sqft: data[i]["area_in_sqft"],
            status: data[i]["status"],
            deposit: data[i]["deposit"],
            bathrooms: data[i]['bathrooms'],
            facing: data[i]["facing"],
            photos_urls: data[i]["photos_urls"],
            rating: data[i]["rating"],
            remarks: data[i]["remarks"],
            is_verified: data[i]["is_verified"],
            is_accquired: data[i]["is_accquired"],
            created_at: data[i]["created_at"],
            updated_at: data[i]["updated_at"],
      );
      reports.add(_property);
    }
  } catch (e) {
    print(e);
  }
  return reports;
}

Future<List<Property>> getPopularProperties(Map<String, double> origin) async {
  List<Property> reports = [];
  try {
    final url = (server+"properties/popular");
    Map<String, dynamic> raw = {
      "origin" : origin
    };
    Response response = await post(Uri.encodeFull(url), body: json.encode(raw), headers: {"Content-Type": "application/json", "Connection": "Keep-Alive"},);
    List data = jsonDecode(response.body)["data"];
    for (int i = 0; i < data.length; i++) {
      Property _property = new Property(
            index: data[i]["index"],
            name: data[i]["name"],
            bhk: data[i]["BHK"],
            type: data[i]["type"],
            floor: data[i]["floor"],
            description: data[i]["description"],
            latitude: data[i]["latitude"],
            longitude: data[i]["longitude"],
            location: data[i]["location"],
            city: data[i]["city"],
            pincode: data[i]["pincode"],
            state: data[i]["state"],
            country: data[i]["country"],
            numberOfRooms: data[i]["numberOfRooms"],
            landlord_id: data[i]["landlord_id"],
            landmark_id: data[i]["landmark_id"],
            price: data[i]["price"],
            area_in_sqft: data[i]["area_in_sqft"],
            status: data[i]["status"],
            deposit: data[i]["deposit"],
            bathrooms: data[i]['bathrooms'],
            facing: data[i]["facing"],
            photos_urls: data[i]["photos_urls"],
            rating: data[i]["rating"],
            remarks: data[i]["remarks"],
            is_verified: data[i]["is_verified"],
            is_accquired: data[i]["is_accquired"],
            created_at: data[i]["created_at"],
            updated_at: data[i]["updated_at"],
      );
      reports.add(_property);
    }
  } catch (e) {
    print(e);
  }
  return reports;
}
