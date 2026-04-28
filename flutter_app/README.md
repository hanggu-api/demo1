# Enatega Flutter - Multi-Vendor Food Delivery App

Aplicativo Flutter completo para delivery de comida multi-vendor, integrado com Firebase.

## 🚀 Funcionalidades

### Autenticação
- Login com email/senha
- Registro de novos usuários (Cliente, Restaurante, Entregador)
- Recuperação de senha
- Persistência de sessão

### Cliente
- Browse de restaurantes
- Visualização de cardápios
- Carrinho de compras
- Pedidos em tempo real
- Histórico de pedidos
- Endereços salvos

### Restaurante
- Gerenciamento de cardápio
- Recebimento de pedidos
- Atualização de status
- Dashboard de vendas

### Entregador
- Recebimento de entregas
- Atualização de localização
- Histórico de entregas
- Ganho por entrega

## 📁 Estrutura do Projeto

```
flutter_app/
├── lib/
│   ├── core/
│   │   ├── constants/      # Constantes da aplicação
│   │   ├── theme/          # Temas e cores
│   │   └── utils/          # Utilitários
│   ├── data/
│   │   ├── models/         # Modelos de dados
│   │   ├── repositories/   # Repositórios
│   │   └── services/       # Serviços (Firebase, API)
│   ├── features/
│   │   ├── auth/           # Autenticação
│   │   ├── home/           # Home
│   │   ├── orders/         # Pedidos
│   │   ├── restaurants/    # Restaurantes
│   │   └── profile/        # Perfil
│   └── main.dart           # Ponto de entrada
├── assets/
│   ├── images/             # Imagens
│   └── fonts/              # Fontes customizadas
└── pubspec.yaml            # Dependências
```

## 🔧 Configuração

### 1. Instalar dependências
```bash
cd flutter_app
flutter pub get
```

### 2. Configurar Firebase

#### Android
1. Baixe `google-services.json` do Firebase Console
2. Coloque em `android/app/google-services.json`
3. Em `android/build.gradle`:
```gradle
buildscript {
    dependencies {
        classpath 'com.google.gms:google-services:4.3.15'
    }
}
```
4. Em `android/app/build.gradle`:
```gradle
apply plugin: 'com.google.gms.google-services'
```

#### iOS
1. Baixe `GoogleService-Info.plist` do Firebase Console
2. Coloque em `ios/Runner/GoogleService-Info.plist`
3. Em `ios/Runner/AppDelegate.swift`:
```swift
import FirebaseCore

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  func application(_ application: UIApplication, 
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    FirebaseApp.configure()
    return true
  }
}
```

### 3. Configurar variáveis de ambiente

Edite `lib/core/constants/app_constants.dart`:
```dart
static const String baseUrl = 'YOUR_CLOUD_FUNCTIONS_URL';
```

## 🛠️ Tecnologias

- **Flutter** - Framework UI
- **Provider** - Gerenciamento de estado
- **Firebase Auth** - Autenticação
- **Cloud Firestore** - Banco de dados
- **Firebase Storage** - Armazenamento de arquivos
- **Firebase Messaging** - Push notifications
- **Google Maps** - Mapas e localização
- **Stripe** - Pagamentos

## 🏃 Rodando o App

### Android
```bash
flutter run
```

### iOS
```bash
flutter run
```

### Build de Produção

#### Android APK
```bash
flutter build apk --release
```

#### Android App Bundle
```bash
flutter build appbundle --release
```

#### iOS
```bash
flutter build ios --release
```

## 📦 Backend Firebase

O backend está localizado na pasta `firebase-backend/` e inclui:
- Cloud Functions para lógica de negócios
- Regras de segurança do Firestore
- Índices otimizados
- Triggers para notificações

Para fazer deploy:
```bash
cd firebase-backend/functions
npm install
firebase login
firebase deploy --only functions
```

## 🎨 Customização

### Cores
Edite `lib/core/theme/app_colors.dart` para mudar as cores do app.

### Tema
Edite `lib/core/theme/app_theme.dart` para customizar o tema.

### Fontes
Adicione fontes em `assets/fonts/` e atualize `pubspec.yaml`.

## 📝 Próximos Passos

- [ ] Implementar tela de restaurantes
- [ ] Implementar carrinho de compras
- [ ] Implementar checkout
- [ ] Integração com Google Maps
- [ ] Implementar chat
- [ ] Sistema de avaliações
- [ ] Push notifications
- [ ] Pagamentos com Stripe

## 🤝 Contribuindo

1. Faça um fork do projeto
2. Crie uma branch para sua feature (`git checkout -b feature/AmazingFeature`)
3. Commit suas mudanças (`git commit -m 'Add some AmazingFeature'`)
4. Push para a branch (`git push origin feature/AmazingFeature`)
5. Abra um Pull Request

## 📄 Licença

Este projeto está sob a licença MIT.

## 👥 Equipe

Desenvolvido como parte da migração do projeto React Native/NestJS para Flutter.

---

**Status:** Em desenvolvimento 🚧
