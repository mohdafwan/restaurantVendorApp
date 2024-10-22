class CurrentOrderStatusModel {
  String restaurantName;
  String place;
  String status;

  CurrentOrderStatusModel(
      {required this.restaurantName,
      required this.place,
      required this.status});

  static List<CurrentOrderStatusModel> currentOrderItem() {
    return [
      CurrentOrderStatusModel(
          restaurantName: "KFC",
          place: "Anna Nagar",
          status: "Ready to pickup"),
      CurrentOrderStatusModel(
          restaurantName: "Café Coffee day",
          place: "Tambaram",
          status: "Preparing"),
      CurrentOrderStatusModel(
          restaurantName: "Mio Amore",
          place: "Garia",
          status: "Ready to pickup")
    ];
  }
}
