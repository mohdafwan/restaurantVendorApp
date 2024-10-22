class Order {
  String title;
  String date;
  String status;
  String imgUrl;

  Order(this.title, this.date, this.imgUrl, this.status);

  // Sample data
  static List<Order> getOrderItems() {
    return [
      Order("KFC", "Today", "assets/historyimages/1.png", "Ready to pickup"),
      Order("Café Coffee Day", "Today", "assets/historyimages/2.png",
          "Preparing"),
      Order("McDonald's", "Yesterday", "assets/historyimages/3.png",
          "Delivered"),
      Order("Madras Coffee House", "Last week", "assets/historyimages/5.png",
          "Delivered"),
    ];
  }
}
