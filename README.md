# Desarrollo seguro de aplicaciones: Un ejemplo de almacenamiento seguro de sesión en una aplicación móvil

## 1. Desarrollo conceptual

### 1.1. ¿Qué es el desarrollo seguro de aplicaciones?

El desarrollo seguro de aplicaciones consiste en integrar prácticas, principios y herramientas de seguridad durante todo el ciclo de vida del software, desde la fase de diseño hasta la implementación y mantenimiento. Este enfoque busca proteger la confidencialidad, integridad y disponibilidad de los datos, y evitar que las aplicaciones se conviertan en vectores de ataque.

Dado que se trata de un conjunto de prácticas, es posible adoptar tanto herramientas auxiliares que apoyen en este objetivo, como también técnicas de desarrollo que fortalezcan la seguridad del proyecto. Cualquier medida adicional que permita prevenir vulnerabilidades contribuye significativamente.

A diferencia de estrategias tradicionales, donde la seguridad se abordaba al final del proceso, hoy se considera un principio arquitectónico fundamental que debe guiar las decisiones técnicas desde el inicio del proyecto.

### 1.2. Principales amenazas en el desarrollo de aplicaciones

El panorama actual de ciberseguridad revela múltiples vectores de ataque que afectan tanto a aplicaciones web como móviles. Según OWASP (2023), algunas de las amenazas más comunes incluyen:

- **Almacenamiento inseguro de datos sensibles**
- **Falta de cifrado en la transmisión de datos**
- **Exposición de secretos o claves API en el código fuente**
- **Errores de validación de entradas del usuario**
- **Sesiones mal gestionadas o fácilmente predecibles**

Estas vulnerabilidades pueden derivar en la filtración de información personal, suplantación de identidad o ejecución de acciones no autorizadas en nombre del usuario. Aunque muchas veces estas amenazas pasan desapercibidas, los pequeños descuidos en el desarrollo son justamente los que generan mayores oportunidades para los atacantes.

### 1.3. Principios clave del desarrollo seguro

El desarrollo seguro debe regirse por principios sólidos para mitigar los riesgos mencionados. A continuación, se listan los más relevantes en relación con la demo que se presentará más adelante:

- **Minimizar la superficie de ataque**: eliminar funciones innecesarias o expuestas.
- **Cifrar datos sensibles tanto en reposo como en tránsito**.
- **Separar los secretos del código fuente** mediante variables de entorno o configuraciones externas.
- **Validar y sanear toda entrada del usuario** para prevenir inyecciones o manipulaciones.
- **Gestionar sesiones y tokens de forma robusta**, evitando almacenamientos inseguros o predecibles.

### 1.4. Almacenamiento seguro de sesión: ejemplo aplicado

Uno de los componentes clave en la seguridad de aplicaciones móviles es el almacenamiento de información de sesión, como los tokens de acceso. Guardar este tipo de información en texto plano (por ejemplo, usando `SharedPreferences` sin cifrado) representa un riesgo crítico.

En plataformas como Android e iOS existen soluciones nativas como **Keystore** (sistema seguro de claves en Android) y **Keychain** (gestor seguro de credenciales en iOS), que permiten almacenar información cifrada y accesible únicamente por la aplicación. Para apps multiplataforma como las desarrolladas en Flutter, se puede utilizar la librería `flutter_secure_storage`, que abstrae estas soluciones ofreciendo un almacenamiento cifrado de forma unificada.

> ✅ Ejemplo seguro: guardar un token de sesión con `flutter_secure_storage`  
> ❌ Ejemplo inseguro: guardar un token en `SharedPreferences` sin cifrar

Este tipo de enfoque permite proteger la persistencia de la sesión del usuario sin comprometer la seguridad de sus datos personales.

Cabe destacar que las soluciones nativas por sí solas no bastan para garantizar la seguridad de un proyecto; es necesario complementarlas con otras medidas y prácticas dentro del desarrollo.

### 1.5. Limitaciones del almacenamiento seguro

Aunque el almacenamiento seguro es una herramienta poderosa, tiene ciertas limitaciones que deben tenerse en cuenta:

- No evita ataques si el dispositivo está comprometido (por ejemplo, si tiene **root** en Android o **jailbreak** en iOS, lo que otorga control total al usuario o atacante sobre el sistema).
- No protege si se **hardcodean** secretos (es decir, si se incluyen claves o tokens directamente en el código fuente).
- No reemplaza una arquitectura segura de extremo a extremo (es decir, que también considere el backend, la red y la autenticación del servidor).

Por eso, se recomienda utilizarlo dentro de una estrategia más amplia de seguridad que incluya el cifrado de datos en tránsito (HTTPS), autenticación segura y control de acceso desde el backend.

### 1.6. Casos de uso comunes

- Aplicaciones financieras o de banca móvil
- Apps de mensajería o salud
- Plataformas educativas con sesión persistente
- Aplicaciones de autenticación de doble factor (2FA)
- Cualquier app que maneje datos sensibles de usuario

## 2. Contexto de solución

### 2.1. Escenario propuesto

El presente ejemplo se enmarca dentro de una aplicación móvil educativa desarrollada con Flutter. Esta app permite a los usuarios iniciar sesión y conservar su estado de autenticación de forma persistente y segura.

Para ello, se aborda una problemática común: **¿Cómo almacenar de manera segura el token de sesión del usuario en un dispositivo móvil?**

En vez de usar mecanismos inseguros como `SharedPreferences` (Android) o `NSUserDefaults` (iOS), se implementa la librería `flutter_secure_storage`, que permite cifrar los datos almacenados, aprovechando los mecanismos nativos de seguridad de cada plataforma (Keystore en Android y Keychain en iOS).

El flujo de seguridad que se implementará es el siguiente:

1. El usuario inicia sesión correctamente.
2. El backend retorna un token (simulado).
3. El token se almacena de forma cifrada en el dispositivo usando `flutter_secure_storage`.
4. En sesiones futuras, se verifica automáticamente si el token sigue presente y válido, permitiendo el ingreso sin tener que volver a autenticarse.

Este ejemplo busca demostrar una **técnica sencilla y efectiva para proteger sesiones de usuario**, compatible con los principios del desarrollo seguro.

### 2.2. Objetivo de la solución

- Aplicar el principio de "almacenamiento seguro de información sensible".
- Mostrar una implementación multiplataforma con **Flutter** y la librería **flutter_secure_storage**.
- Concientizar sobre los riesgos del uso de almacenamiento no cifrado en aplicaciones móviles.
- Sentar las bases para implementar sesiones persistentes seguras y escalables.

### 2.3. Requisitos para la implementación

#### Tecnologías utilizadas

- **Flutter SDK** (3.19 o superior)
- **Dart**
- **Visual Studio Code** o **Android Studio**
- **Dispositivo físico o emulador Android/iOS**

#### Librerías necesarias

- [`flutter_secure_storage`](https://pub.dev/packages/flutter_secure_storage): Almacenamiento seguro
- [`flutter/material.dart`](https://api.flutter.dev/): Interfaz de usuario

#### Instalación del paquete


flutter pub add flutter_secure_storage


## 3. Demo

### 3.1. Escenario propuesto

Para demostrar el concepto de almacenamiento seguro en una aplicación móvil, se desarrolló una app simple en **Flutter** que simula un flujo muy básico de login. Al autenticarse, se guarda un token de sesión en el dispositivo de forma segura utilizando la librería `flutter_secure_storage`. Este token se persiste incluso si la aplicación se reinicia, pero se elimina al cerrar sesión.

Esto permite representar un flujo de sesión seguro, evitando almacenar datos sensibles en texto plano o en espacios vulnerables como `SharedPreferences`.

---

### 3.2. Estructura general

El proyecto está compuesto por los siguientes archivos clave:

/lib

└── main.dart → Pantalla principal con login simulado y botón de logout
/test

└── widget_test.dart → Test básico de funcionalidad

/pubspec.yaml → Declaración de dependencias



---

### 3.3. Código fuente (main.dart)

```dart
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final secureStorage = const FlutterSecureStorage();

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Secure Session App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: FutureBuilder<String?>(
        future: secureStorage.read(key: 'token'),
        builder: (context, snapshot) {
          final token = snapshot.data;
          if (token != null) {
            return HomePage(secureStorage: secureStorage);
          } else {
            return LoginPage(secureStorage: secureStorage);
          }
        },
      ),
    );
  }
}

class LoginPage extends StatelessWidget {
  final FlutterSecureStorage secureStorage;

  const LoginPage({super.key, required this.secureStorage});

  void _login(BuildContext context) async {
    await secureStorage.write(key: 'token', value: 'abc123');
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => HomePage(secureStorage: secureStorage)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Center(
        child: ElevatedButton(
          onPressed: () => _login(context),
          child: const Text('Iniciar sesión'),
        ),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  final FlutterSecureStorage secureStorage;

  const HomePage({super.key, required this.secureStorage});

  void _logout(BuildContext context) async {
    await secureStorage.delete(key: 'token');
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginPage(secureStorage: secureStorage)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Inicio')),
      body: Center(
        child: ElevatedButton(
          onPressed: () => _logout(context),
          child: const Text('Cerrar sesión'),
        ),
      ),
    );
  }
}

```
---
### 3.4. Test básico de funcionalidad

Se incluye un test básico generado por defecto en Flutter que verifica si el contador de la aplicación incrementa correctamente al presionar el botón con ícono "+". Esto permite comprobar que el entorno de pruebas está configurado correctamente y que la estructura general del widget principal responde a interacciones.

#### Código del test (ubicado en `/test/widget_test.dart`):

```dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:secure_login_app/main.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Construye la app y lanza el primer frame
    await tester.pumpWidget(MyApp());

    // Verifica que el contador empieza en 0
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Toca el ícono de "+" y actualiza la UI
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verifica que el contador ahora muestra 1
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });
}

```

#### Nota técnica:

Este test fue adaptado para la versión flutter_secure_storage: ^9.2.4. Para evitar errores de compatibilidad en el entorno de pruebas, se eliminó la palabra clave const en la línea:

await tester.pumpWidget(MyApp()); // sin `const`

Esto se debe a que el constructor MyApp() ya no puede ser constante si su contenido depende de librerías o estructuras no constantes, como es el caso de las que acceden a almacenamiento seguro o a contextos externos en tiempo de ejecución.

### Cómo ejecutar el emulador en Android Studio

1. Abrir **Android Studio**.
2. Ir a la pestaña **Device Manager** (en la barra lateral derecha).
3. Localizar el emulador configurado, por ejemplo: `Pixel 5 API 33 (Tiramisu)`.
4. Haz clic en el ícono de **play ▶️** para iniciarlo.
5. Una vez iniciado el emulador, ejecuta el proyecto desde VS Code o Android Studio con:

```bash
flutter run
```

Tambien se recomienda ejecutar:
```bash
flutter doctor
```

antes de ejecutar todo y adicionalmente se recomienda ejecutar 2 veces flutter run para resolver la instalación de dependencias.




### 3.5. Repositorio y ejecución

El enlace al código completo es:
([Repositorio](https://github.com/DmitriVurb/Informe_Individual_ArquiSoft1051.git))

Para correr el proyecto localmente:

```

git clone https://github.com/tu-grupo/secure-login-app

cd secure-login-app

flutter pub get

flutter run

```

Asimismo se recomienda poner en "Modo desarrollador" el Sistema




## 📚 Fuentes

- OWASP Foundation. (2023). [OWASP Mobile Top 10](https://owasp.org/www-project-mobile-top-10/)
- Flutter. (s.f.). [flutter_secure_storage](https://pub.dev/packages/flutter_secure_storage)
- Android Developers. (s.f.). [Keystore system](https://developer.android.com/training/articles/keystore)
- Apple Developer. (s.f.). [Keychain Services](https://developer.apple.com/documentation/security/keychain_services)