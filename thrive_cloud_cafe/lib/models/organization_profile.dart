import 'package:thrive_cloud_cafe/models/user_profile.dart';

class OrganizationProfile {
  String _displayName;
  int _storageSpace;
  int _storageStatus;
  Map<String, int> _foodTypes;
  int _clientsServed;
  bool _overflowStatus;

  OrganizationProfile(
      {String displayName,
      int storageSpace = 0,
      int storageStatus = 0,
      bool overflowStatus = false,
      Map<String, int> foodTypes,
      int clientsServed = 0})
      : _displayName = displayName,
        _storageSpace = storageSpace,
        _storageStatus = storageStatus,
        _overflowStatus = overflowStatus,
        _foodTypes = foodTypes,
        _clientsServed = clientsServed;

  String getDisplayName() {
    return _displayName;
  }

  int getStorageSpace() {
    return _storageSpace;
  }

  bool getOverflowStatus() {
    return _overflowStatus;
  }

  int getStorageStatus() {
    return _storageStatus;
  }

  int getClientsServed() {
    return _clientsServed;
  }

  Map<String, int> getFoodTypes() {
    return _foodTypes;
  }

  factory OrganizationProfile.fromJson(Map<String, dynamic> parsedJson) {
    return new OrganizationProfile(
      displayName: parsedJson['displayName'],
      storageSpace: parsedJson['storageSpace'],
      overflowStatus: parsedJson['overflowStatus'],
      storageStatus: parsedJson['storageStatus'],
      clientsServed: parsedJson['clientsServed'],
      foodTypes: parsedJson['foodTypes'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'displayName': this._displayName,
      'storageSpace': this._storageSpace,
      'storageStatus': this._storageStatus,
      'overflowStatus': this._overflowStatus,
      'clientsServed': this._clientsServed,
      'foodTypes': this._foodTypes
    };
  }
}
