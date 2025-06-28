
# simple_calc

Uma calculadora simples desenvolvida com Flutter, com suporte a tema claro/escuro, histórico de operações armazenado localmente via Hive, e layout responsivo. Projeto focado em praticar gerenciamento de estado com Provider, persistência local e lógica de cálculo personalizada com precedência de operadores.

---

## 🚀 Funcionalidades

- ✏️ Entrada de expressões matemáticas básicas
- ➕➖✖️➗ Suporte a operações com precedência (`+`, `-`, `x`, `÷`)
- 🌗 Alternância entre tema claro e escuro
- 🕘 Histórico persistente de operações
- 🗑️ Limpeza de histórico com confirmação

---


## 🛠️ Tecnologias e pacotes

- [Flutter](https://flutter.dev/) (3.x)
- [Hive](https://pub.dev/packages/hive)
- [Provider](https://pub.dev/packages/provider)

---

## ▶️ Como rodar o projeto

### 1. Clone este repositório

```bash
git clone https://github.com/seu-usuario/simple_calc.git
cd simple_calc
````

### 2. Instale as dependências

```bash
flutter pub get
```

### 3. Execute o app

```bash
flutter run
```

---

## 🗂️ Estrutura do projeto

```bash
lib/
├── controller/          # Controllers (estado e lógica)
├── repository/          # Lógica de persistência Hive
├── view/                # Interfaces de usuário
└── main.dart            # Ponto de entrada
```

---


## 👨‍💻 Autor

* **[Pedro-Mesquitaa](https://github.com/Pedro-Mesquitaa)**

---

