class Posts {
  late String title;
  late String content;
  late String year;
  late bool hasImage;
  late DateTime created;
  late String objectId;

  Posts(String title, String content, String year, bool hasImage,
      DateTime created, String objectId) {
    this.title = title;
    this.content = content;
    this.year = year;
    this.hasImage = hasImage;
    this.created = created;
    this.objectId = objectId;
  }
}
