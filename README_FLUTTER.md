# Enatega Multi-Vendor Food Delivery - Flutter

Aplicativo completo de delivery de comida multi-vendor desenvolvido em Flutter, com suporte para 3 aplicativos: **Cliente**, **Restaurante** e **Entregador**.

## 📱 Aplicativos

### 1. Customer App (`customer_app/`)
Aplicativo para clientes finais fazerem pedidos em restaurantes.

**Funcionalidades:**
- ✅ Autenticação (Email/Senha e Google Sign-In)
- ✅ Navegação por restaurantes e cozinhas
- ✅ Busca e filtros avançados
- ✅ Carrinho de compras
- ✅ Múltiplos endereços de entrega
- ✅ Acompanhamento de pedidos em tempo real
- ✅ Histórico de pedidos
- ✅ Avaliações e comentários
- ✅ Pagamento via Stripe
- ✅ Notificações push

### 2. Restaurant App (`restaurant_app/`)
Aplicativo para restaurantes gerenciarem seus negócios.

**Funcionalidades:**
- ✅ Gestão de cardápio (CRUD de produtos)
- ✅ Gerenciamento de categorias
- ✅ Recebimento de pedidos em tempo real
- ✅ Atualização de status dos pedidos
- ✅ Dashboard com métricas
- ✅ Configurações do restaurante
- ✅ Horário de funcionamento
- ✅ Relatórios de vendas

### 3. Rider App (`rider_app/`)
Aplicativo para entregadores realizarem entregas.

**Funcionalidades:**
- ✅ Recebimento de solicitações de entrega
- ✅ Aceitar/recusar corridas
- ✅ Navegação GPS integrada
- ✅ Rota otimizada
- ✅ Histórico de entregas
- ✅ Ganhos e estatísticas
- ✅ Status de disponibilidade
- ✅ Contato com cliente e restaurante

## 🏗️ Arquitetura

```
├── customer_app/          # App do Cliente
├── restaurant_app/        # App do Restaurante  
├── rider_app/             # App do Entregador
└── shared/                # Código compartilhado
    ├── models/            # Modelos de dados
    └── services/          # Serviços compartilhados
```

## 📦 Estrutura de Pastas (Cada App)

```
lib/
├── config/               # Configurações (temas, rotas, constantes)
├── models/               # Modelos específicos do app
├── providers/            # Gerenciamento de estado (Provider)
├── screens/              # Telas da aplicação
│   ├── auth/            # Telas de autenticação
│   ├── home/            # Tela inicial
│   ├── orders/          # Pedidos
│   └── profile/         # Perfil
├── services/             # Serviços (API, Firebase, etc.)
├── widgets/              # Widgets reutilizáveis
└── main.dart            # Ponto de entrada
```

## 🔥 Backend Firebase

O projeto utiliza Firebase como backend:

- **Authentication**: Login e registro de usuários
- **Firestore**: Banco de dados NoSQL em tempo real
- **Storage**: Armazenamento de imagens
- **Cloud Messaging**: Notificações push
- **Cloud Functions**: Lógica de negócio serverless

### Coleções Firestore

| Coleção | Descrição |
|---------|-----------|
| `users` | Dados dos usuários (clientes, restaurantes, riders) |
| `restaurants` | Informações dos restaurantes |
| `products` | Cardápio dos restaurantes |
| `orders` | Pedidos dos clientes |
| `notifications` | Notificações push |
| `reviews` | Avaliações de restaurantes |
| `riders` | Dados dos entregadores |

## 🚀 Como Rodar

### Pré-requisitos

- Flutter SDK >= 3.0.0
- Dart >= 3.0.0
- Firebase CLI
- Conta no Firebase

### 1. Clonar Repositório

```bash
git clone https://github.com/hanggu-api/demo1.git
cd demo1
```

### 2. Configurar Firebase

Para cada aplicativo:

1. Crie um projeto no [Firebase Console](https://console.firebase.google.com/)
2. Adicione apps Android e iOS
3. Baixe os arquivos de configuração:
   - `google-services.json` (Android)
   - `GoogleService-Info.plist` (iOS)
4. Coloque os arquivos nas pastas apropriadas de cada app

### 3. Instalar Dependências

```bash
# Customer App
cd customer_app
flutter pub get

# Restaurant App
cd ../restaurant_app
flutter pub get

# Rider App
cd ../rider_app
flutter pub get

# Shared
cd ../shared
flutter pub get
```

### 4. Executar

```bash
# Customer App
cd customer_app
flutter run

# Restaurant App
cd ../restaurant_app
flutter run

# Rider App
cd ../rider_app
flutter run
```

## 🛠️ Tecnologias Utilizadas

- **Flutter** - Framework UI
- **Provider** - Gerenciamento de estado
- **Firebase** - Backend completo
- **GoRouter** - Navegação declarativa
- **Google Maps** - Mapas e rotas
- **Stripe** - Pagamentos
- **Google Sign-In** - Autenticação social

## 📋 Modelos de Dados Principais

- `UserModel` - Usuários (clientes, restaurantes, riders)
- `Restaurant` - Restaurantes
- `Product` - Produtos do cardápio
- `Order` - Pedidos
- `OrderItem` - Itens do pedido
- `DeliveryAddress` - Endereços
- `Notification` - Notificações
- `Review` - Avaliações

## 🔐 Segurança

Regras de segurança do Firestore devem ser configuradas para:
- Clientes só podem ver/editar seus próprios dados
- Restaurantes só gerenciam seus produtos e pedidos
- Riders só veem pedidos atribuídos
- Admin tem acesso total

## 📱 Builds

### Android

```bash
flutter build apk --release
flutter build appbundle --release
```

### iOS

```bash
flutter build ios --release
```

## 🤝 Contribuição

1. Faça um fork do projeto
2. Crie uma branch para sua feature (`git checkout -b feature/AmazingFeature`)
3. Commit suas mudanças (`git commit -m 'Add some AmazingFeature'`)
4. Push para a branch (`git push origin feature/AmazingFeature`)
5. Abra um Pull Request

## 📄 Licença

Este projeto está sob a licença MIT. Veja o arquivo [LICENSE](LICENSE) para mais detalhes.

## 👥 Equipe

Desenvolvido pela equipe Enatega.

## 📞 Suporte

Para suporte, envie um email para support@enatega.com ou abra uma issue no repositório.

---

Made with ❤️ using Flutter
