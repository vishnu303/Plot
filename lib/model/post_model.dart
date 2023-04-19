class Post {
  final String uid;
  final String username;
  final String userAvatarUrl;
  final String title;
  final String postId;
  final String thumbnailUrl;
  final String itemCategory;
  final List? imageUrls;
  final DateTime datePublished;
  final int price;
  final String description;
  final String location;
  final String phoneNo;

  Post({
    required this.uid,
    required this.username,
    required this.userAvatarUrl,
    required this.itemCategory,
    required this.title,
    required this.postId,
    required this.thumbnailUrl,
    required this.imageUrls,
    required this.datePublished,
    required this.price,
    required this.description,
    required this.location,
    required this.phoneNo,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'username': username,
      'userAvatarUrl': userAvatarUrl,
      'title': title,
      'postId': postId,
      'itemCategory': itemCategory,
      'thumbnailUrl': thumbnailUrl,
      'imageUrls': imageUrls,
      'datePublished': datePublished,
      'price': price,
      'description': description,
      'location': location,
      'phoneNo': phoneNo,
    };
  }

  factory Post.fromMap(Map<String, dynamic> map) {
    return Post(
      itemCategory: map['itemCategory'],
      uid: map['uid'],
      username: map['username'],
      userAvatarUrl: map['userAvatarUrl'],
      title: map['title'],
      postId: map['postId'],
      thumbnailUrl: map['thumbnailUrl'],
      imageUrls: map['imageUrls'],
      datePublished: map['datePublished'],
      price: map['price'],
      description: map['description'],
      location: map['location'],
      phoneNo: map['phoneNo'],
    );
  }
}
