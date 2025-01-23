import 'package:flutter/material.dart';
import '../controlador/verduras_controlador.dart';
import '../modelo/verduras_modelo.dart';

class VerdurasVista extends StatefulWidget {
  @override
  _VerdurasVistaState createState() => _VerdurasVistaState();
}

class _VerdurasVistaState extends State<VerdurasVista> {
  final VerdurasControlador _controlador = VerdurasControlador();
  late Future<List<Verdura>> _futureVerduras;

  @override
  void initState() {
    super.initState();
    _futureVerduras = _controlador.fetchVerduras();
  }

  void _showEditDialog({Verdura? verdura}) {
    final _codigoController = TextEditingController(text: verdura?.codigo.toString() ?? '');
    final _descripcionController = TextEditingController(text: verdura?.descripcion ?? '');
    final _precioController = TextEditingController(text: verdura?.precio.toString() ?? '');
    final _formKey = GlobalKey<FormState>();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(verdura == null ? 'Agregar Verdura' : 'Editar Verdura'),
          content: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: _codigoController,
                  decoration: InputDecoration(labelText: 'Código'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingrese un código';
                    }
                    if (int.tryParse(value) == null) {
                      return 'Por favor ingrese un número válido';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _descripcionController,
                  decoration: InputDecoration(labelText: 'Descripción'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingrese una descripción';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _precioController,
                  decoration: InputDecoration(labelText: 'Precio'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingrese un precio';
                    }
                    if (double.tryParse(value) == null) {
                      return 'Por favor ingrese un número válido';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancelar'),
            ),
            TextButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  final codigo = int.parse(_codigoController.text);
                  final descripcion = _descripcionController.text;
                  final precio = double.parse(_precioController.text);

                  try {
                    if (verdura == null) {
                      await _controlador.addVerdura(
                        Verdura(codigo: codigo, descripcion: descripcion, precio: precio),
                      );
                    } else {
                      await _controlador.updateVerdura(
                        verdura.codigo,
                        Verdura(codigo: codigo, descripcion: descripcion, precio: precio),
                      );
                    }

                    setState(() {
                      _futureVerduras = _controlador.fetchVerduras();
                    });

                    Navigator.of(context).pop();
                  } catch (e) {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text('Error'),
                          content: Text(e.toString()),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(),
                              child: Text('OK'),
                            ),
                          ],
                        );
                      },
                    );
                  }
                }
              },
              child: Text('Guardar'),
            ),
          ],
        );
      },
    );
  }

  void _showDeleteDialog(int codigo) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Eliminar Verdura'),
          content: Text('¿Estás seguro de que deseas eliminar esta verdura?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancelar'),
            ),
            TextButton(
              onPressed: () async {
                await _controlador.deleteVerdura(codigo);

                setState(() {
                  _futureVerduras = _controlador.fetchVerduras();
                });

                Navigator.of(context).pop();
              },
              child: Text('Eliminar'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Verduras'),
      ),
      body: FutureBuilder<List<Verdura>>(
        future: _futureVerduras,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No verduras found'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final verdura = snapshot.data![index];
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: ListTile(
                    contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    tileColor: Colors.green[50],
                    leading: Icon(Icons.local_florist, color: Colors.green),
                    title: Text(
                      verdura.descripcion,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.green[800],
                      ),
                    ),
                    subtitle: Text(
                      'Precio: \$${verdura.precio}',
                      style: TextStyle(
                        color: Colors.green[600],
                      ),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit, color: Colors.blue),
                          onPressed: () => _showEditDialog(verdura: verdura),
                        ),
                        IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: () => _showDeleteDialog(verdura.codigo),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showEditDialog(),
        child: Icon(Icons.add),
        backgroundColor: Colors.green,
      ),
    );
  }
}