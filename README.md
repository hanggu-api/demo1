# Enatega Multi-Vendor Food Delivery - Flutter

Aplicativo completo de delivery de comida multi-vendor desenvolvido em Flutter com backend Firebase.

## 📱 Aplicativos Incluídos

### 1. Customer App (cliente_app)
- Catálogo de restaurantes
- Busca e filtros
- Carrinho de compras
- Pedidos em tempo real
- Rastreamento de entrega
- Histórico de pedidos
- Perfil do usuário
- Endereços salvos
- Pagamento integrado

### 2. Restaurant App (restaurant_app)
- Gestão de cardápio
- Recebimento de pedidos
- Atualização de status
- Gestão de horários
- Relatórios de vendas

### 3. Rider App (rider_app)
- Recebimento de entregas
- Navegação GPS
- Atualização de status
- Histórico de entregas
- Ganhos

### 4. Admin Web (admin_app)
- Gestão de usuários
- Gestão de restaurantes
- Gestão de entregadores
- Monitoramento de pedidos
- Relatórios e analytics

## 🔥 Backend Firebase

O projeto inclui um backend completo em Firebase com:

- **Authentication**: Login com email/senha e Google
- **Firestore Database**: Banco de dados NoSQL em tempo real
- **Cloud Functions**: Lógica de negócio serverless
- **Firebase Storage**: Armazenamento de imagens
- **Firebase Messaging**: Notificações push
- **Security Rules**: Regras de segurança robustas

## 🚀 Funcionalidades do Backend

### Cloud Functions Implementadas
- Criação automática de perfil de usuário
- Notificações de novo pedido
- Atualização de status de pedido
- Atribuição de entregador
- Cálculo de rotas
- Processamento de pagamentos
- Gestão de estoque

## 📦 Estrutura do Projeto

```
food-delivery-multivendor/
├── customer_app/          # App do cliente
│   ├── lib/
│   │   ├── main.dart
│   │   ├── models/
│   │   ├── services/
│   │   ├── providers/
│   │   ├── screens/
│   │   └── widgets/
│   └── pubspec.yaml
├── restaurant_app/        # App do restaurante
│   └── ...
├── rider_app/            # App do entregador
│   └── ...
├── admin_app/            # Painel admin
│   └── ...
└── firebase_backend/     # Backend Firebase
    ├── functions/
    ├── firestore.rules
    └── storage.rules
```

## 🛠️ Instalação

### Pré-requisitos
- Flutter SDK >= 3.0.0
- Firebase CLI
- Node.js >= 18.0.0
- Conta Firebase

### Configuração do Flutter

```bash
# Customer App
cd customer_app
flutter pub get
flutter run

# Restaurant App
cd restaurant_app
flutter pub get
flutter run

# Rider App
cd rider_app
flutter pub get
flutter run
```

### Configuração do Firebase

1. Crie um projeto no [Firebase Console](https://console.firebase.google.com)
2. Adicione apps Android e iOS para cada aplicativo
3. Baixe os arquivos `google-services.json` e `GoogleService-Info.plist`
4. Coloque-os nas pastas apropriadas de cada app

```bash
# Deploy das Cloud Functions
cd firebase_backend/functions
npm install
firebase login
firebase deploy --only functions,firestore,storage
```

## 🔐 Configuração de Segurança

As regras de segurança do Firestore e Storage já estão configuradas no projeto. Certifique-se de aplicá-las:

```bash
firebase deploy --only firestore:rules
firebase deploy --only storage:rules
```

## 📝 Variáveis de Ambiente

Crie um arquivo `.env` na raiz de cada app com:

```
FIREBASE_API_KEY=sua_api_key
FIREBASE_APP_ID=seu_app_id
FIREBASE_MESSAGING_SENDER_ID=seu_sender_id
FIREBASE_PROJECT_ID=seu_project_id
GOOGLE_MAPS_API_KEY=sua_google_maps_key
STRIPE_PUBLISHABLE_KEY=sua_stripe_key
```

## 🎨 Personalização

Para personalizar o aplicativo:

1. Altere as cores em `lib/main.dart`
2. Substitua os assets em `assets/`
3. Modifique os textos nos arquivos de localização

## 📄 Licença

MIT License

## 👥 Suporte

Para dúvidas e suporte, abra uma issue no GitHub.
