# 🥬 App Básica Gestión de Verduras

Una aplicación móvil desarrollada en Flutter para la gestión de verduras, implementando una arquitectura MVC (Modelo-Vista-Controlador) que consume una API REST para realizar operaciones CRUD completas.

## 📋 Descripción del Proyecto

Esta aplicación permite gestionar un inventario de verduras con las siguientes funcionalidades:
- **Listar** todas las verduras disponibles
- **Agregar** nuevas verduras al inventario
- **Editar** información de verduras existentes
- **Eliminar** verduras del inventario

Cada verdura cuenta con los siguientes atributos:
- **Código**: Identificador único numérico
- **Descripción**: Nombre o descripción de la verdura
- **Precio**: Valor monetario de la verdura

## 🏗️ Arquitectura

El proyecto sigue el patrón **MVC (Modelo-Vista-Controlador)**:

### 📁 Estructura de Carpetas
```
lib/
├── main.dart                    # Punto de entrada de la aplicación
├── modelo/
│   └── verduras_modelo.dart     # Modelo de datos (Verdura)
├── vista/
│   └── verduras_vista.dart      # Interfaz de usuario
└── controlador/
    └── verduras_controlador.dart # Lógica de negocio y API calls
```

### 🔧 Componentes

#### Modelo (`verduras_modelo.dart`)
- Clase `Verdura` con propiedades: codigo, descripcion, precio
- Métodos `fromJson()` y `toJson()` para serialización

#### Vista (`verduras_vista.dart`)
- Interfaz gráfica con Material Design
- Lista de verduras con cards estilizadas
- Diálogos para agregar/editar verduras
- Validación de formularios
- Confirmaciones para eliminación

#### Controlador (`verduras_controlador.dart`)
- Gestión de peticiones HTTP a la API REST
- Métodos CRUD completos:
  - `fetchVerduras()` - Obtener todas las verduras
  - `fetchVerdura(codigo)` - Obtener verdura específica
  - `addVerdura(verdura)` - Agregar nueva verdura
  - `updateVerdura(codigo, verdura)` - Actualizar verdura
  - `deleteVerdura(codigo)` - Eliminar verdura

## 🌐 API REST

La aplicación consume una API REST local que debe ejecutarse en:
```
http://localhost:5000/verduras
```

### Endpoints utilizados:
- `GET /verduras` - Obtener todas las verduras
- `GET /verduras/{codigo}` - Obtener verdura por código
- `POST /verduras` - Crear nueva verdura
- `PUT /verduras/{codigo}` - Actualizar verdura
- `DELETE /verduras/{codigo}` - Eliminar verdura

## 🛠️ Tecnologías y Dependencias

- **Flutter SDK**: ^3.5.4
- **Dart**: Lenguaje de programación principal
- **http**: ^1.3.0 - Para peticiones HTTP a la API
- **Material Design**: Para el diseño de la interfaz

## 🚀 Instalación y Configuración

### Prerrequisitos
- Flutter SDK instalado
- Dart SDK
- API REST ejecutándose en `localhost:5000`

### Pasos de instalación

1. **Clonar el repositorio**
   ```bash
   git clone <url-del-repositorio>
   cd gallegos_examen_gestionverduras
   ```

2. **Instalar dependencias**
   ```bash
   flutter pub get
   ```

3. **Ejecutar la aplicación**
   ```bash
   flutter run
   ```

## 📱 Funcionalidades de la Interfaz

### Pantalla Principal
- **AppBar**: Título "Verduras"
- **Lista de Verduras**: Cards con información de cada verdura
- **FloatingActionButton**: Botón verde para agregar nuevas verduras

### Cada Card de Verdura incluye:
- **Icono**: Ícono de planta (local_florist)
- **Descripción**: Nombre de la verdura en negrita
- **Precio**: Valor monetario formateado
- **Botones de acción**:
  - ✏️ Editar (azul)
  - 🗑️ Eliminar (rojo)

### Diálogos
- **Agregar/Editar**: Formulario con validación para código, descripción y precio
- **Eliminar**: Confirmación antes de la eliminación
- **Error**: Mensajes informativos para errores de API

## 🎨 Diseño Visual

- **Tema**: Material Design con colores verdes
- **Colores principales**:
  - Verde para elementos principales
  - Verde claro para fondos de cards
  - Azul para edición
  - Rojo para eliminación

## 📚 Recursos Adicionales

Para más información sobre Flutter:
- [Documentación oficial de Flutter](https://docs.flutter.dev/)
- [Lab: Escribe tu primera app en Flutter](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Ejemplos útiles de Flutter](https://docs.flutter.dev/cookbook)
