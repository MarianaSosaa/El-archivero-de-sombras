# El-archivero-de-sombras
Proyecto personal

GDD

1.	Visión general. 
 
•	Juego de puzles narrativo y lógica espacial en 2D donde el jugador asume el rol de restaurador de objetos de un museo sumido en la penumbra. El objetivo es recomponer artefactos misteriosos y fragmentados utilizando diferentes tipos de fuentes de luz, sombras proyectadas y patrones de encaje geométrico para revelar la memoria oculta de cada objeto. Descubre la historia que esconde un objeto roto a través de la luz y la posición desde la que lo miras. 
•	Género: Puzle / Investigación. 
•	Plataforma: PC. 
•	Público objetivo: Jugadores apasionados por la lógica espacial, la investigación y la narrativa de misterio. 
•	Motor de videojuegos: Godot.
•	Estilo visual: Pixel art estilizado con alto contraste entre luces y sombras. 
 
2.	Mecánicas de juego. 
 
•	Mecánicas principales. 
  o	Manipulación y rotación 3D. El jugador toma un fragmento del artefacto y lo rota libremente en el espacio de trabajo, la orientación cambia tanto la posición del objeto físico como la sombra proyectada en el fondo. 
  o	Alineación por proyección de sombra. Orientar dos fragmentos hasta que sus sombras individuales encajen en la silueta dibujada en la pared, al lograr esta superposición exacta durante un tiempo determinado, las piezas se unen físicamente. 
  o	Conmutación de iluminación (filtros de luz). Cambiar entre la lámpara de luz cálida (luz directa) y la linterna de luz ultravioleta (UV); la luz cálida permite trabajar con las sombras y la física; la luz UV revela pistas invisibles, glifos, grietas estructurales o números ocultos en la superficie del objeto. 
 
•	Mecánicas secundarias. 
  o	Inspección e interacción con mecanismos internos. Interactuar con elementos móviles en los objetos (diales, cerrojos, botones); desbloquear partes atrapadas o cambiar el centro de gravedad del artefacto para permitir nuevos ángulos de rotación. 
  o	Manejo de varias fuentes de luz. Mover o encender una segunda fuente de iluminación en la mesa de trabajo genera sombras dobles o cruzadas que requieren posicionar las piezas en un ángulo relativo a ambas luces para formar la figura completa. 
  o	Herramientas de limpieza y preparación. Usar un pincel o bisturí para retirar capas de polvo, óxido o cera de los puntos de unión de las piezas; preparar la superficie, si no se limpia la junta, la pieza no hará clic, aunque la sombra esté alineada. 
 
3.	Sistema de inventario y diario del archivero.

•	Inspección de pistas en el diario. Abrir la libreta de anotaciones para revisar los bocetos de las sombras objetivo, notas del antiguo restaurador o traducciones de inscripciones. 
•	Uso de ítems de apoyo (Consumibles / Limitadores). Utilizar pegamento de precisión o sellos de fijación; si se incluye un límite de intentos o recursos por nivel, el jugador debe decidir dónde aplicar fijaciones temporales antes de la prueba final.

4.	Flujo de niveles y progresión.

•	Fase 1 (Tutorial): Artefactos simples de 3 a 4 piezas con una sola fuente de luz.
•	Fase 2: Introducción de luz ultravioleta y de engranajes mecánicos internos.
•	Fase 3: Puzles de doble sombra (dos fuentes de luz que deben alinearse simultáneamente).
 

