class DescriptiveProduct {
  String name;
  String description;
  String price;
  String imageurl;

  DescriptiveProduct(
      {required this.name,
      required this.description,
      required this.price,
      required this.imageurl});
}

List<DescriptiveProduct> desProductList = [

  DescriptiveProduct(
      name: "Roadster",
      description: "Jackets",
      price: '-4000/-',
      imageurl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTjLpKroy7CpJ0RV_5_ypmfP4uj8rP7bRMKZw&usqp=CAU "),
  DescriptiveProduct(
      name: "Puma",
      description: "Casual Shoes",
      price: '-3000/-',
      imageurl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQiKqNKHoXgQz_0siVDoaNkpuuubbUqCBAJ-Z6B_GxbFG5sMC_S0uIbBZM3kkHeq5L5VyM&usqp=CAU "),
  DescriptiveProduct(
      name: "Tommy Hilfiger",
      description: "Sweat Shirts ",
      price: '-6500/-',
      imageurl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTXd7EghRmAPb8emBFtfaB84m6kNuG5qvFS3A&usqp=CAU "),

  DescriptiveProduct(
      name: "adidas",
      description: "Casual Shoes",
      price: '-2999/-',
      imageurl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQpIQd9qfSlHAQojK37U2sqMfFpEgWLKJkN1A&usqp=CAU "),
];
