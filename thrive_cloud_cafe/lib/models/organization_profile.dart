import 'package:thrive_cloud_cafe/models/user_profile.dart';

class OrganizationProfile {
  String _displayName;
  int _storageSpace;
  int _storageStatus;
//  Map<String, List<FoodItem>> _foodTypes;
  List<dynamic> _foodItems = [];
  int _clientsServed;
  bool _overflowStatus;

  OrganizationProfile(
      {String displayName,
      int storageSpace = 0,
      int storageStatus = 0,
      bool overflowStatus = false,
//      List<dynamic> foodItems,
      int clientsServed = 0})
      : _displayName = displayName,
        _storageSpace = storageSpace,
        _storageStatus = storageStatus,
        _overflowStatus = overflowStatus,
//        _foodItems = foodItems,
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

//  Map<String, List<FoodItem>> getFoodTypes() {
//    return _foodTypes;
//  }

  List<dynamic> getFoodItems() {
    return _foodItems;
  }

  List<dynamic> getFoodItemsWithKey(String foodType) {
    return _foodItems.where((element) => element.foodType == foodType).toList();
  }

  // Test this function
  // Make this into a map of String quantity
  List<String> getFoodTypes() {
    // Possible error of type casting from dynamic to String
    List<String> list = [];
    _foodItems.forEach((element) {
      if (!list.contains(element.foodType)) {
        list.add(element.foodType);
      }
    });

    return list;
  }

  Map<String, int> getFoodTypes1() {
    Map<String, int> foodTypes = {};
    _foodItems.forEach((element) {
      if (foodTypes.containsKey(element.foodType)) {
        foodTypes[element.foodType] += element.quantity;
      } else {
        foodTypes[element.foodType] = element.quantity;
      }
    });

    return foodTypes;
  }

  void updateFoodItem(FoodItem newItem) {
    final item = _foodItems.firstWhere(
        (element) => newItem.name == element.name,
        orElse: () => null);
    if (item != null) {
      item.quantity = newItem.quantity;
      updateStorageStatus();
    }
  }

  void updateStorageStatus() {
    int finalValue = 0;

    // Adds each of the food item's quantity
    _foodItems.forEach((element) {
      finalValue += element.quantity;
    });

//    _foodTypes.forEach((foodType, foodItem) {
//      foodItem.forEach((key, value) {
//        finalValue += value;
//      });
//    });

    _storageStatus = finalValue;
    checkOverflow();
  }

  void checkOverflow() {
    if (_storageStatus > _storageSpace) {
      _overflowStatus = true;
    }
  }

  void setClientsServed(String value) {
    _clientsServed = int.parse(value);
  }

  factory OrganizationProfile.fromJson(Map<String, dynamic> parsedJson) {
    List<dynamic> list = [];
    Map<dynamic, dynamic> set = parsedJson["foodItems"];
    // Map
    set.forEach((key, value) {
      // List
      value.forEach((foodItem) {
        // Map
        list.add(FoodItem.fromMap(foodItem, key));
      });
    });

    OrganizationProfile organizationProfile = OrganizationProfile(
      displayName: parsedJson['displayName'],
      storageSpace: parsedJson['storageSpace'],
      overflowStatus: parsedJson['overflowStatus'],
      storageStatus: parsedJson['storageStatus'],
      clientsServed: parsedJson['clientsServed'],
    );

    // Setting the food items to the list
    organizationProfile._foodItems = list;

    return organizationProfile;
  }

  Map<String, dynamic> toJson() {
    return {
      'displayName': this._displayName,
      'storageSpace': this._storageSpace,
      'storageStatus': this._storageStatus,
      'overflowStatus': this._overflowStatus,
      'clientsServed': this._clientsServed,
      'foodItems': _customSets(_foodItems
          .map((e) => e.foodType)
          .toList()) // Passing a list of food types
    };
  }

  // Creates a nested map of string and dynamic key-value pairs for Firestore
  // Private member function
  Map<String, dynamic> _customSets(List<dynamic> types) {
    Map<String, dynamic> customSet = {};
    types.forEach((foodType) {
      List<Map<String, dynamic>> set = [];
      _foodItems.forEach((foodItem) {
        if (foodItem.foodType == foodType) {
          set.add(foodItem.toMap());
        }
      });
      customSet[foodType] = set;
    });
    return customSet;
  }
}

class FoodItem {
  final String name;
  int quantity;
  final String foodType;

  FoodItem(this.name, this.quantity, this.foodType);

  FoodItem.fromMap(Map<dynamic, dynamic> map, String newFoodType)
      : name = map['name'],
        quantity = map['quantity'],
        foodType = newFoodType;

  Map<String, dynamic> toMap() =>
      {'name': this.name, 'quantity': this.quantity};

  @override
  bool operator ==(dynamic item) {
    return (this.name == item.name &&
        this.foodType == item.foodType &&
        this.quantity == item.quantity);
  }
}
