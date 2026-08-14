class CategoryModel {
  final String title;
  final String bookCount;
  final String image;

  CategoryModel({
    required this.title,
    required this.bookCount,
    required this.image,
  });
}
final List<CategoryModel> categoriesList = [
  CategoryModel(
    title: "History",
    bookCount: "1,240",
    image: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS4lmR6Y6p6FYbU9_OyOPmWoxCVxz3mr84OeJki_jZQ5cF6dboMmoTdr4w&s=10"
  ),
  CategoryModel(
    title: "Science",
    bookCount: "850",
    image: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQFn9QynbyKhsfNcymdX1sns8VD7AWq0eldBrgh2zbr9Wa2YBqx6bDVeYr9&s=10"
  ),
  CategoryModel(
    title: "Novel",
    bookCount: "120",
    image: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQubxeQBfjaI_qmG5rrQdZUi75oCJY9DKxTSiFyK0DkM74wSPKKNENfTxt5&s=10"
  ),
  CategoryModel(
    title: "Arts",
    bookCount: "430",
    image: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTMDb2NCkP84kyzL5T6p2WrhzFx7K8ZLppVpZwrKUK-OGGAgrhL8DEfdtk&s=10"
  ),
  CategoryModel(
    title: "Philosophy",
    bookCount: "310",
    image: "https://student-cms.prd.timeshighereducation.com/sites/default/files/styles/default/public/philosophy_statue.jpg?itok=fK7ZI-C2"
  ),
  CategoryModel(
    title: "Technology",
    bookCount: "2100",
    image: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTQCphfFY6XcY610FSMZ-4-xTF3C8IvVsrcou8oqhKVhl4NQHgIQrDCt0k&s=10"
  ),
];