# Tetris en VHDL – FPGA

## Universidad Politécnica de Madrid (UPM)  
### ETSIDI – Escuela Técnica Superior de Ingeniería y Diseño Industrial  
**Asignatura:** Sistemas Electrónicos Digitales  
**Grupo:** EE-403  
**Tipo de trabajo:** Proyecto en grupo  
**Miembros:**  
- Felipe Arriero Serrano  
- Gonzalo Morcillo García  
- Iván Yankowich Oliver  

---

## 📌 Descripción del proyecto

Este repositorio contiene el desarrollo de un **juego Tetris implementado en VHDL**, diseñado para su ejecución en placas FPGA **Nexys4 DDR** y **Basys3**.

El juego se visualiza mediante **salida VGA** y se controla exclusivamente a través de los **pulsadores físicos de la placa**, sin necesidad de periféricos externos. El diseño incorpora lógica de control del juego, detección de colisiones, sistema de puntuación y diferentes estados de funcionamiento.

El proyecto ha sido desarrollado con fines **académicos**, siguiendo criterios de modularidad, claridad y correcto uso de los recursos hardware disponibles en la FPGA.

---

## 🎮 Funcionalidades del juego

- Representación gráfica del juego mediante **pantalla VGA**  
- Control del movimiento y rotación de las piezas en tiempo real  
- Detección de colisiones con el tablero y otras piezas  
- Eliminación automática de filas completas  
- **Sistema de puntuación dinámico**, visible en el display de 7 segmentos  
- Incremento progresivo de la **velocidad de caída de las piezas** según la puntuación  
- Gestión del flujo del juego mediante **máquina de estados**
- Pantallas diferenciadas de:
  - Juego en curso
  - **Game Over**
  - **Win**

Desde las pantallas de *Game Over* y *Win* es posible **volver a iniciar una partida sin resetear la placa**, pulsando el **botón central**.

---

## 🖥️ Visualización

- **Salida VGA**
  - Frecuencia de reloj de píxel: **25 MHz**
  - Resolución estándar compatible con las placas utilizadas
- Representación gráfica del tablero, las piezas y los estados finales del juego

---

## 🔘 Controles del juego

### Nexys4 DDR

| Botón | Función |
|------|--------|
| Botón Central | Rotar la pieza |
| Botón Inferior | Acelerar la caída de la pieza |
| Botón Derecho | Desplazar la pieza a la derecha |
| Botón Izquierdo | Desplazar la pieza a la izquierda |
| Botón Reset de la placa | Reset completo del juego |

---

### Basys3

| Botón | Función |
|------|--------|
| Botón Central | Rotar la pieza |
| Botón Inferior | Acelerar la caída de la pieza |
| Botón Derecho | Desplazar la pieza a la derecha |
| Botón Izquierdo | Desplazar la pieza a la izquierda |
| Botón Superior | Reset completo del juego |

---

## 🔢 Sistema de puntuación

- La puntuación se muestra mediante el **display de 7 segmentos** de la placa.
- Los puntos obtenidos dependen del **número de filas eliminadas en un mismo movimiento**:
  - A mayor número de filas eliminadas simultáneamente, mayor puntuación.
- A medida que se acumulan puntos:
  - Se incrementa la **velocidad de caída de las piezas**, aumentando progresivamente la dificultad del juego.

---

## 🏁 Condiciones de victoria y derrota

- **Victoria (Win):**  
  Se alcanza cuando el jugador consigue **9900 puntos**.
- **Derrota (Game Over):**  
  Ocurre cuando no es posible generar una nueva pieza sin que colisione o se superponga con piezas existentes en el tablero.

---

## 🛠️ Requisitos del sistema

- **Placas FPGA compatibles:**
  - Nexys4 DDR
  - Basys3
- **Lenguaje de descripción hardware:** VHDL
- **Herramienta de síntesis y programación:** Vivado Design Suite
- **Periféricos utilizados:**
  - Pantalla VGA
  - Pulsadores integrados en la placa.
  - Display de 7 segmentos integrado en la placa.

---
