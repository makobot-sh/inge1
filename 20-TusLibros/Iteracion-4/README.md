# Setup
Es necesario cargar **en una imagen limpia** (recordar que los paquetes `WebClient.pck.st`, `Morphic-Misc1-pckt.st` y `Morhic-Widgets-Extras.pkt.st`) los `.st` en el siguiente orden:
- TusLibros-Model.st
- TusLibros-Tests.st
- TusLibros-Graphics.st

# Modo de uso de la interfaz gráfica TusLibros

Para evaluar la interfaz gráfica y ver toda la funcionalidad implementada, recomendamos seguir el siguiente recorrido, corriendo los snippets de código presentados desde un Workspace una vez cargados los `.st` en el orden indicado arriba.

## Notas
Recomendamos correr
```
TusLibrosRestAPIInterface allInstancesDo: [:i | i destroy.].
```
Cada vez que se termine de hacer una prueba para que no se utilice sin querer un servidor anterior con la sesión expirada.

## Levantar servidor y abrir interfaz de login
Correr el siguiente código (pegar en un workspace, seleccionarlo todo y presionar `ctrl+d`):
```
| test |
test _ TusLibrosRestAPIInterfaceTest new.
test startTestServerAndLoginInterface.
```

### Login exitoso
Para probar un inicio de sesión exitoso, utilizar las credenciales 
```
username: admin 
password: admin
```
Si el login es exitoso la ventana de inicio de sesión se cerrará y se abrirá la interfaz de compras.

### Login fallido
Para probar un login fallido utilizar cualquier par de credenciales que no sea el dado anteriormente. Un mensaje en rojo aparecerá en la parte inferior de la ventana de login y no se abrirá la interfaz de compras.

## Levantar servidor y abrir interfaz de compras
Las próximas pruebas se pueden hacer utlizando la interfaz de compras abierta en las pruebas anteriores o corriendo el siguiente código (previo `destroy` del servidor anterior con el código dado en la sección `Notas`)
```
| test |
test _ TusLibrosRestAPIInterfaceTest new.
test startTestServerAndShopInterface.
```

### Compra exitosa
Una vez abierta la interfaz de compras, En la sección izquierda (catálogo) utilizar las flechas o escribir un número en las casillas correspondientes para seleccionar cuantos libros comprar. Una vez hecho esto presionar el botón `Add to cart` para actualizar el carrito (sección derecha). Si no hay problemas al agregar los libros, estos aparecerán como una lista a la derecha.

En este punto podemos volver a agregar libros (notar que los contadores se habrán reiniciado) y la lista se actualizará de nuevo de forma acorde al presionar `Add to cart` (notar que si agregamos más del mismo libro se agrega a la cantidad seleccionada anteriormente).

Una vez contentos con nuestra compra podemos presionar `Checkout` para completar la compra. Se cerrará la ventana de compras y se abrirá una nueva que indicará el total gastado por libro y en la compra total. Podemos presionar `logout` para terminar la sesión y volver a la ventana de login o `New purchase` para volver a abrir la interfaz de compras y continuar comprando.

Recomendamos presionar `New purchase` y realizar otra compra como antes para poder ver mejor los resultados en la siguiente prueba. Hacer logout y luego iniciar sesión de nuevo (sin haber destruido el server en el entretanto) también sirve.

### Purchase history
Una vez que volvimos a la interfaz de compras, presionar el botón `Purchase history`. Se abrirá una ventana que muestre todas las compras realizadas por el usuario hasta el momento. Si nunca destruimos el servidor, veremos la combinación de todas las compras que realizamos anteriormente, incluso si hicimos `Logout` en el medio.

### Logout y login
Si no se hizo aún, recomendamos hacer `Logout` y luego vovler a iniciar sesión con las mismas credenciales de antes para comprobar que el `Purchase history` persiste a través de sesiones.

### Carrito expirado
Recomendamos hacer esta prueba primera o última ya que requiere que primero se destruya la instancia del servidor creada anteriormente y se levante una nueva (ver código para destruir instancias en sección `Notas`).

Correr el siguiente snippet de código en un Workspace:
```
| test |
test _ TusLibrosRestAPIInterfaceTest new.
test startTestServerAndShopInterface.
test advanceTimeToExpireSession.
```

Ahora cuando se abra la interfaz de compras, al intentar presionar el botón `Add to cart` o `Checkout` veremos que aparecen mensajes de error que indican que el carrito no se puede continuar utilizando tras 30 minutos de inactividad!

Si hacemos logout y volvemos a iniciar sesión con las credenciales válidas de más arriba, veremos que podemos continuar realizando compras de forma normal (ya que el carrito ahora no está expirado).
