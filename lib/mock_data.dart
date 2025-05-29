class Shoe {
  final String name;
  final String image;
  final String price;
  final String brand;
  final String type;
  final String description;
  final String color;

  Shoe({
    required this.name,
    required this.image,
    required this.price,
    required this.brand,
    required this.type,
    required this.description,
    required this.color,
  });
}

// Mock data
List<Shoe> mockShoes = [
  Shoe(
    name: "Air Max 270",
    image: "assets/shoe0.png",
    price: "\$150",
    brand: "Nike",
    type: "Running",
    color: "0xFFda5a65",
    description: "The Nike Air Max 270 delivers visible cushioning under every step with the tallest Air unit yet, featuring a large 270-degree Air unit in the heel for maximum impact protection. Built with engineered mesh upper for breathability and a sleek, modern aesthetic that transitions seamlessly from workout to street style. The durable rubber outsole provides excellent traction on various surfaces.",
  ),
  Shoe(
    name: "Ultraboost 22",
    image: "assets/ultraboost.png",
    price: "\$190",
    brand: "Adidas",
    type: "Running",
    color: "0xFF863ac5",
    description: "Experience endless energy return with responsive BOOST cushioning and Primeknit upper that adapts to your foot's natural movement. The Continental rubber outsole delivers extraordinary grip in wet and dry conditions, while the innovative Linear Energy Push system provides a smooth, propulsive ride. Perfect for long-distance running and daily training sessions with superior comfort and performance.",
  ),
  Shoe(
    name: "Chuck Taylor All Star",
    image: "assets/chuck.png",
    price: "\$65",
    brand: "Converse",
    type: "Casual",
    color: "0xFFFF0000",
    description: "The iconic canvas sneaker that started it all and has remained virtually unchanged since its debut in 1957. Featuring a timeless high-top silhouette with durable canvas construction, metal eyelets, and the signature rubber toe cap. This versatile shoe pairs perfectly with any outfit and represents decades of authentic street style and cultural significance across generations.",
  ),
  Shoe(
    name: "Old Skool",
    image: "assets/vans.png",
    price: "\$65",
    brand: "Vans",
    type: "Skateboarding",
    color: "0xFF31514F",
    description: "The classic side-stripe shoe with durable canvas and suede construction, reinforced toe caps, and padded collars for support and flexibility. Originally designed for skateboarding, the waffle outsole provides superior grip and board feel. Features the iconic Vans stripe and has become a cultural symbol of creativity, authenticity, and individual expression in skateboarding and street fashion.",
  ),
  Shoe(
    name: "Gel-Kayano 29",
    image: "assets/gel.png",
    price: "\$160",
    brand: "ASICS",
    type: "Running",
    color: "0xFFcca333",
    description: "Advanced stability running shoe engineered for overpronators with superior GEL cushioning technology in the heel and forefoot for shock absorption. Features Dynamic DuoMax support system and Trusstic System technology for enhanced structural integrity. The FlyteFoam Propel technology provides lightweight bounce back, while the OrthoLite X-55 sockliner improves step-in comfort for long-distance running.",
  ),
  Shoe(
    name: "Air Jordan 1 Retro",
    image: "assets/jordan1.png",
    price: "\$170",
    brand: "Jordan",
    type: "Basketball",
    color: "0xFF3a2f0f",
    description: "The legendary basketball shoe that changed sneaker culture forever, originally designed for Michael Jordan in 1985. Features premium leather construction, classic colorways, and the iconic Wings logo. This high-top silhouette revolutionized basketball footwear with its bold design and superior performance features, becoming a timeless symbol of basketball excellence and streetwear fashion that transcends sports.",
  ),
  Shoe(
    name: "Classic Leather",
    image: "assets/reebokClassic.png",
    price: "\$75",
    brand: "Reebok",
    type: "Casual",
    color: "0xFF5e6a69",
    description: "Timeless leather sneaker with vintage appeal and all-day comfort, featuring soft full-grain leather upper and classic silhouette that never goes out of style. The die-cut EVA midsole provides lightweight cushioning, while the high abrasion rubber outsole ensures durability. Originally designed as a running shoe, it has evolved into a versatile lifestyle sneaker perfect for casual wear and everyday activities.",
  ),
  Shoe(
    name: "Suede Classic",
    image: "assets/pumaClassic.png",
    price: "\$70",
    brand: "Puma",
    type: "Casual",
    color: "0xFF835718",
    description: "The original B-boy shoe with rich suede upper and iconic PUMA formstrip, first introduced in 1968 as a basketball shoe. Features premium suede construction with a low-profile silhouette and rubber outsole for durability. This timeless design has become a cultural icon, worn by hip-hop legends and fashion enthusiasts alike, representing the intersection of sport, culture, and street style.",
  ),
  Shoe(
    name: "574 Core",
    image: "assets/core.png",
    price: "\$80",
    brand: "New Balance",
    type: "Lifestyle",
    color: "0xFF2d719e",
      description: "Heritage running shoe with ENCAP midsole technology that combines lightweight foam with a durable polyurethane rim for support and cushioning. Features premium suede and mesh upper construction with the classic 574 silhouette that has remained popular for decades. The rubber outsole provides reliable traction, while the timeless design makes it perfect for both athletic activities and casual everyday wear.",
  ),
  Shoe(
    name: "Blazer Mid '77",
    image: "assets/blazer.png",
    price: "\$100",
    brand: "Nike",
    type: "Casual",
    color: "0xFFae2418",
    description: "Vintage basketball shoe reimagined with modern comfort and classic style, originally released in 1973. Features premium leather upper with the iconic Swoosh logo and classic mid-top silhouette. The autoclave construction provides durability, while the rubber cupsole offers excellent traction. This retro design captures the essence of '70s basketball culture with contemporary comfort for today's lifestyle.",
  ),
  Shoe(
    name: "Stan Smith",
    image: "assets/smith.png",
    price: "\$85",
    brand: "Adidas",
    type: "Tennis",
    color: "0xFF153353",
    description: "The world's most popular tennis shoe with clean, minimalist design that has remained virtually unchanged since the 1970s. Features premium white leather upper with perforated 3-Stripes, green accents, and Stan Smith's portrait on the tongue. This iconic court shoe represents timeless elegance and versatility, making it suitable for tennis, casual wear, and fashion-forward styling across all age groups.",
  ),
  Shoe(
    name: "React Infinity Run",
    image: "assets/infinity.png",
    price: "\$160",
    brand: "Nike",
    type: "Running",
    color: "0xFF4c0c25",
    description: "Designed to help reduce injury with soft, responsive Nike React foam that provides smooth, lightweight cushioning for long-distance running. Features a wider forefoot for enhanced stability and Flyknit upper that adapts to your foot. The innovative rocker-shaped sole promotes a natural running gait, while the durable rubber outsole with strategic traction patterns ensures grip on various surfaces and weather conditions.",
  ),
];
