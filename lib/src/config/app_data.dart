import 'package:mercadinho/src/models/item_carrinho.dart';
import 'package:mercadinho/src/models/item_model.dart';
import 'package:mercadinho/src/models/pedidos_model.dart';
import 'package:mercadinho/src/models/user_model.dart';

ItemModel apple = ItemModel(
  description:
      'A melhor maçã da região e que conta com o melhor preço de qualquer quitanda. Este item conta com vitaminas essenciais para o fortalecimento corporal, resultando em uma vida saudável.',
  imgUrl: 'assets/images/apple.png',
  itemName: 'Maçã',
  price: 5.5,
  unit: 'kg',
);

ItemModel grape = ItemModel(
  imgUrl: 'assets/images/grape.png',
  itemName: 'Uva',
  price: 7.4,
  unit: 'kg',
  description:
      'A melhor uva da região e que conta com o melhor preço de qualquer quitanda. Este item conta com vitaminas essenciais para o fortalecimento corporal, resultando em uma vida saudável.',
);

ItemModel guava = ItemModel(
  imgUrl: 'assets/images/guava.png',
  itemName: 'Goiaba',
  price: 11.5,
  unit: 'kg',
  description:
      'A melhor goiaba da região e que conta com o melhor preço de qualquer quitanda. Este item conta com vitaminas essenciais para o fortalecimento corporal, resultando em uma vida saudável.',
);

ItemModel kiwi = ItemModel(
  imgUrl: 'assets/images/kiwi.png',
  itemName: 'Kiwi',
  price: 2.5,
  unit: 'un',
  description:
      'O melhor kiwi da região e que conta com o melhor preço de qualquer quitanda. Este item conta com vitaminas essenciais para o fortalecimento corporal, resultando em uma vida saudável.',
);

ItemModel mango = ItemModel(
  imgUrl: 'assets/images/mango.png',
  itemName: 'Manga',
  price: 2.5,
  unit: 'un',
  description:
      'A melhor manga da região e que conta com o melhor preço de qualquer quitanda. Este item conta com vitaminas essenciais para o fortalecimento corporal, resultando em uma vida saudável.',
);

ItemModel papaya = ItemModel(
  imgUrl: 'assets/images/papaya.png',
  itemName: 'Mamão papaya',
  price: 8,
  unit: 'kg',
  description:
      'O melhor mamão da região e que conta com o melhor preço de qualquer quitanda. Este item conta com vitaminas essenciais para o fortalecimento corporal, resultando em uma vida saudável.',
);

// Lista de produtos
List<ItemModel> items = [
  apple,
  grape,
  guava,
  kiwi,
  mango,
  papaya,
];

final List<String> categories = [
  'Frutas',
  'Grãos',
  'Verduras',
  'Tempedos',
  'Cerais',
];

List<CartItemModel> cartItems = [
  CartItemModel(
    item: papaya,
    quantity: 4,
  ),
  CartItemModel(
    item: kiwi,
    quantity: 2,
  ),
];

UserModel user = UserModel(
  name: 'Rodolpho Pinheiro',
  email: 'rehbpinheiro30@gmail.com',
  phone: '85992467098',
  cpf: '62641158353',
  password: '123456',
);

List<PedidosModel> pedidos = [
  PedidosModel(
    id: 'fflkfljflkjf',
    dataPedido: DateTime.parse('2024-05-06 13:27:00'),
    dataValidadeQrCode: DateTime.parse('2024-05-07 14:27:00'),
    items: [
      CartItemModel(
        item: kiwi,
        quantity: 2,
      ),
      CartItemModel(
        item: papaya,
        quantity: 5,
      ),
    ],
    sttatus: 'peding_payment',
    copiaECola: 'copiaECola',
    total: 45,
  ),
  PedidosModel(
    id: 'fflkfljflkjf',
    dataPedido: DateTime.parse('2024-05-06 13:27:00'),
    dataValidadeQrCode: DateTime.parse('2024-05-07 14:27:00'),
    items: [
      CartItemModel(
        item: kiwi,
        quantity: 2,
      ),
      CartItemModel(
        item: papaya,
        quantity: 5,
      ),
    ],
    sttatus: 'delivered',
    copiaECola: 'copiaECola',
    total: 45,
  ),
];
