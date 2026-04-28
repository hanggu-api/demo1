# 🍔 Food Completo 4 - Sistema de Delivery Completo

Um ecossistema completo de delivery de comida integrado ao Firebase, inspirado no iFood mas com funcionalidades aprimoradas.

## 📱 Apps Incluídos

### 1. **user_app** - App do Cliente
- Catálogo de restaurantes e produtos
- Carrinho de compras
- Pedidos em tempo real
- Rastreamento de entrega com mapa
- Pagamento via PIX e Cartão (Mercado Pago)
- Histórico de pedidos
- Avaliações e reviews
- Endereços salvos
- Cupons e promoções

### 2. **seller_app** - App do Restaurante
- Gerenciamento de cardápio
- Recebimento de pedidos
- Atualização de status
- Relatórios de vendas
- Configuração de horários
- Gestão de entregadores próprios

### 3. **rider_app** - App do Motoboy
- Recebimento de corridas
- Navegação GPS integrada
- Roteirização inteligente
- Atualização de localização em tempo real
- Histórico de entregas
- Ganhos e repasses

### 4. **waiter_app** - App de Garçom (NOVO!)
- Comanda digital
- Lançamento de pedidos na mesa
- QR Code para pagamento
- Integração com cozinha
- Fechamento de conta

### 5. **admin_web_portal** - Portal Administrativo
- Dashboard completo
- Gestão de usuários
- Aprovação de restaurantes
- Monitoramento de pedidos
- Relatórios financeiros
- Configurações do sistema

## 🔥 Integrações Firebase

- **Authentication**: Login com email/senha, Google, Facebook
- **Firestore Database**: Banco de dados em tempo real
- **Storage**: Armazenamento de imagens
- **Cloud Messaging**: Notificações push
- **Security Rules**: Regras de segurança robustas

## 💳 Meios de Pagamento

### Mercado Pago Integration
- PIX com QR Code dinâmico
- Cartão de crédito
- Cartão de débito
- Saldo em conta
- Split de pagamento (restaurante/motoboy/plataforma)

## 🗺️ Geolocalização e Roteirização

- **Google Maps API**: Mapas e navegação
- **Geolocator**: Tracking em tempo real
- **Polyline Points**: Desenho de rotas
- **Directions API**: Cálculo de melhores rotas
- **Roteirização Inteligente**: Otimização de múltiplas entregas

## 🔐 Regras de Segurança

O sistema implementa regras de segurança granulares no Firestore:

- **Clientes**: Acesso apenas aos seus dados e pedidos
- **Restaurantes**: Gerenciam seu próprio cardápio e pedidos
- **Motoboys**: Atualizam localização e veem rotas
- **Garçons**: Acessam comandas do seu restaurante
- **Admins**: Acesso total ao sistema

## 📁 Estrutura do Projeto

```
food_completo_4-app-/
├── user_app/              # App do cliente
│   ├── lib/
│   │   ├── authentication/
│   │   ├── Home/
│   │   ├── mainScreens/
│   │   ├── maps/
│   │   ├── models/
│   │   └── ...
│   └── pubspec.yaml
├── seller_app/            # App do restaurante
├── rider_app/             # App do motoboy
├── waiter_app/            # App do garçom (NOVO!)
├── admin_web_portal/      # Portal admin
└── firestore.rules        # Regras de segurança
```

## 🚀 Como Configurar

### 1. Pré-requisitos
- Flutter SDK >= 2.19.6
- Firebase project criado
- Conta no Mercado Pago (sandbox ou produção)
- Google Maps API Key

### 2. Configuração do Firebase

Para cada app, adicione o arquivo `google-services.json` (Android) e `GoogleService-Info.plist` (iOS):

```bash
# User App
cp path/to/user-google-services.json user_app/android/app/google-services.json

# Seller App
cp path/to/seller-google-services.json seller_app/android/app/google-services.json

# Rider App
cp path/to/rider-google-services.json rider_app/android/app/google-services.json

# Waiter App
cp path/to/waiter-google-services.json waiter_app/android/app/google-services.json

# Admin Web
cp path/to/admin-google-services.json admin_web_portal/web/google-services.json
```

### 3. Configuração do Mercado Pago

Crie um arquivo `lib/config/mercadopago_config.dart` em cada app:

```dart
class MercadoPagoConfig {
  static const String accessToken = 'YOUR_ACCESS_TOKEN';
  static const String publicKey = 'YOUR_PUBLIC_KEY';
}
```

### 4. Configuração do Google Maps

Adicione no `AndroidManifest.xml` de cada app:

```xml
<meta-data
    android:name="com.google.android.geo.API_KEY"
    android:value="YOUR_GOOGLE_MAPS_API_KEY"/>
```

### 5. Instalar Dependências

```bash
cd user_app && flutter pub get
cd ../seller_app && flutter pub get
cd ../rider_app && flutter pub get
cd ../waiter_app && flutter pub get
cd ../admin_web_portal && flutter pub get
```

### 6. Deploy das Regras de Segurança

```bash
cd admin_web_portal
firebase deploy --only firestore:rules
```

## 📊 Coleções do Firestore

```
users/                    # Dados dos clientes
sellers/                  # Restaurantes
  └─ menus/
  └─ items/
riders/                   # Entregadores
  └─ location/           # Localização em tempo real
waiters/                  # Garçons
admins/                   # Administradores
orders/                   # Pedidos
  └─ tracking/           # Rastreamento
comandas/                 # Comandas digitais (garçom)
  └─ items/
addresses/                # Endereços dos clientes
payments/                 # Histórico de pagamentos
reviews/                  # Avaliações
notifications/            # Notificações
delivery_routes/          # Rotas otimizadas
coupons/                  # Cupons promocionais
settings/                 # Configurações do sistema
tokens/                   # Tokens de sessão
```

## 🔑 Funcionalidades Principais

### Para o Cliente
- ✅ Busca de restaurantes por categoria
- ✅ Filtros avançados (preço, avaliação, tempo)
- ✅ Carrinho compartilhado entre restaurantes
- ✅ Agendamento de pedidos
- ✅ Rastreamento em tempo real no mapa
- ✅ Chat com restaurante/entregador
- ✅ Múltiplos endereços
- ✅ Favoritos
- ✅ Histórico completo

### Para o Restaurante
- ✅ Cardápio ilimitado com categorias
- ✅ Modificadores e adicionais
- ✅ Controle de estoque
- ✅ Tempo de preparo dinâmico
- ✅ Aceite/recusa de pedidos
- ✅ Impressão de cupons
- ✅ Relatórios de vendas
- ✅ Promoções e combos

### Para o Motoboy
- ✅ Modo online/offline
- ✅ Aceite de corridas
- ✅ Navegação turn-by-turn
- ✅ Múltiplas paradas
- ✅ Comprovante de entrega
- ✅ Extrato de ganhos
- ✅ Gorjetas

### Para o Garçom
- ✅ Scan de QR Code da mesa
- ✅ Lançamento rápido de itens
- ✅ Envio para cozinha
- ✅ Divisão de conta
- ✅ Pagamento na mesa
- ✅ Histórico de mesas

## 🛠️ Tecnologias Utilizadas

- **Frontend**: Flutter 3.x
- **Backend**: Firebase (Serverless)
- **Pagamentos**: Mercado Pago SDK
- **Mapas**: Google Maps Platform
- **Notificações**: Firebase Cloud Messaging
- **Estado**: Provider
- **Armazenamento Local**: SharedPreferences

## 📝 Próximos Passos

1. Configurar credenciais do Firebase para cada app
2. Adicionar chaves de API do Google Maps
3. Configurar conta do Mercado Pago
4. Personalizar logos e cores da marca
5. Testar fluxo completo de pedido
6. Configurar ambientes de sandbox
7. Implementar testes automatizados
8. Preparar para publicação nas stores

## 📄 Licença

MIT License - veja o arquivo LICENSE para detalhes.

## 👨‍💻 Suporte

Para dúvidas e suporte, abra uma issue no repositório.

---

**Desenvolvido com ❤️ usando Flutter e Firebase**
