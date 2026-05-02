/**
 * PromedioUBA — app.js
 * Calculadora de promedio ponderado para estudiantes de la FIUBA.
 *
 * Conceptos usados (nivel 2do año):
 *  - Arrays y objetos
 *  - Funciones puras y separación de responsabilidades
 *  - Manipulación del DOM
 *  - Eventos del navegador
 *  - Validaciones de formulario
 */

'use strict';

// ── Año en el footer ────────────────────────────────────────────────
document.getElementById('year').textContent = new Date().getFullYear();

// ── Estado de la aplicación ─────────────────────────────────────────
/**
 * Lista de materias cargadas por el usuario.
 * Cada materia es un objeto: { id, nombre, nota, creditos }
 */
let materias = [];
let nextId = 1;

// ── Referencias al DOM ───────────────────────────────────────────────
const form            = document.getElementById('form-materia');
const inputNombre     = document.getElementById('nombre-materia');
const inputNota       = document.getElementById('nota-materia');
const inputCreditos   = document.getElementById('creditos-materia');
const errorMsg        = document.getElementById('form-error');

const emptyState      = document.getElementById('empty-state');
const tableWrapper    = document.getElementById('table-wrapper');
const tablaBody       = document.getElementById('tabla-body');
const resultCard      = document.getElementById('result-card');

const resultadoScore  = document.getElementById('resultado-promedio');
const resultadoDesc   = document.getElementById('resultado-desc');
const statMaterias    = document.getElementById('stat-materias');
const statCreditos    = document.getElementById('stat-creditos');
const statMejor       = document.getElementById('stat-mejor');

const btnDemo         = document.getElementById('btn-demo');
const btnLimpiar      = document.getElementById('btn-limpiar');

// ── Lógica pura (sin DOM) ────────────────────────────────────────────

/**
 * Calcula el promedio ponderado de una lista de materias.
 * Fórmula: Σ(nota × créditos) / Σ(créditos)
 *
 * @param {Array} lista - Array de objetos { nota, creditos }
 * @returns {number} Promedio ponderado redondeado a 2 decimales
 */
function calcularPromedioPane(lista) {
  if (lista.length === 0) return 0;

  const sumaProductos  = lista.reduce((acc, m) => acc + m.nota * m.creditos, 0);
  const sumaCreditoss  = lista.reduce((acc, m) => acc + m.creditos, 0);

  return Math.round((sumaProductos / sumaCreditoss) * 100) / 100;
}

/**
 * Determina la clase CSS de color según la nota.
 * @param {number} nota
 * @returns {string} clase CSS
 */
function clasePorNota(nota) {
  if (nota >= 8)  return 'nota-alta';
  if (nota >= 6)  return 'nota-media';
  return 'nota-baja';
}

/**
 * Descripción textual del promedio.
 * @param {number} promedio
 * @returns {string}
 */
function descripcionPromedio(promedio) {
  if (promedio >= 9)   return '🎓 Excelente rendimiento académico';
  if (promedio >= 8)   return '✅ Muy buen promedio — ¡seguí así!';
  if (promedio >= 7)   return '📘 Buen promedio, hay margen de mejora';
  if (promedio >= 6)   return '⚠️  Promedio suficiente, pero ajustado';
  if (promedio >= 4)   return '🔴 Por debajo del promedio esperado';
  return '❌ Promedio insuficiente';
}

/**
 * Valida los datos del formulario antes de agregar una materia.
 * @param {string} nombre
 * @param {number} nota
 * @param {number} creditos
 * @returns {{ valido: boolean, mensaje: string }}
 */
function validarMateria(nombre, nota, creditos) {
  if (!nombre || nombre.trim().length < 2) {
    return { valido: false, mensaje: 'El nombre debe tener al menos 2 caracteres.' };
  }
  if (isNaN(nota) || nota < 1 || nota > 10 || !Number.isInteger(nota)) {
    return { valido: false, mensaje: 'La nota debe ser un número entero entre 1 y 10.' };
  }
  if (isNaN(creditos) || creditos < 1 || creditos > 20 || !Number.isInteger(creditos)) {
    return { valido: false, mensaje: 'Los créditos deben ser un entero entre 1 y 20.' };
  }
  return { valido: true, mensaje: '' };
}

// ── Funciones de renderizado (DOM) ───────────────────────────────────

/**
 * Muestra u oculta los elementos según si hay materias o no.
 */
function actualizarVisibilidad() {
  const hayMaterias = materias.length > 0;

  emptyState.hidden    =  hayMaterias;
  tableWrapper.hidden  = !hayMaterias;
  resultCard.hidden    = !hayMaterias;
}

/**
 * Renderiza una fila en la tabla para una materia dada.
 * @param {Object} materia - { id, nombre, nota, creditos }
 * @param {number} indice  - Posición en el array (para mostrar #)
 * @param {boolean} isNew  - Si es recién agregada (activa animación)
 */
function renderizarFila(materia, indice, isNew = false) {
  const tr = document.createElement('tr');
  if (isNew) tr.classList.add('new-row');

  const claseNota = clasePorNota(materia.nota);

  tr.innerHTML = `
    <td class="num-col">${indice + 1}</td>
    <td class="nombre-col" title="${materia.nombre}">${materia.nombre}</td>
    <td class="${claseNota}">${materia.nota}</td>
    <td>${materia.creditos}</td>
    <td>
      <button
        class="btn btn--icon-only"
        aria-label="Eliminar ${materia.nombre}"
        data-id="${materia.id}"
      >✕</button>
    </td>
  `;

  return tr;
}

/**
 * Re-renderiza toda la tabla desde cero con el estado actual de `materias`.
 */
function renderizarTabla(idNuevo = null) {
  tablaBody.innerHTML = '';

  materias.forEach((materia, indice) => {
    const isNew = materia.id === idNuevo;
    const fila  = renderizarFila(materia, indice, isNew);
    tablaBody.appendChild(fila);
  });
}

/**
 * Actualiza la tarjeta de resultado con el promedio calculado.
 */
function actualizarResultado() {
  const promedio      = calcularPromedioPane(materias);
  const totalCreditos = materias.reduce((acc, m) => acc + m.creditos, 0);
  const mejorNota     = materias.length > 0
    ? Math.max(...materias.map(m => m.nota))
    : null;

  // Actualizar número con animación "pop"
  resultadoScore.classList.remove('pop');
  void resultadoScore.offsetWidth; // reflow para reiniciar animación
  resultadoScore.classList.add('pop');

  resultadoScore.textContent = promedio.toFixed(2);
  resultadoDesc.textContent  = descripcionPromedio(promedio);

  statMaterias.textContent = materias.length;
  statCreditos.textContent = totalCreditos;
  statMejor.textContent    = mejorNota !== null ? mejorNota : '—';

  // Color del borde izquierdo según promedio
  resultCard.classList.remove('nota-danger', 'nota-warning');
  if (promedio < 6)       resultCard.classList.add('nota-danger');
  else if (promedio < 8)  resultCard.classList.add('nota-warning');
}

/**
 * Renderiza la UI completa: tabla + resultado + visibilidad.
 * @param {number|null} idNuevo - ID de la última materia agregada (para animación)
 */
function renderizar(idNuevo = null) {
  actualizarVisibilidad();
  renderizarTabla(idNuevo);
  if (materias.length > 0) actualizarResultado();
}

// ── Manejadores de eventos ───────────────────────────────────────────

/**
 * Maneja el submit del formulario: valida, agrega y renderiza.
 */
form.addEventListener('submit', function (evento) {
  evento.preventDefault();
  errorMsg.textContent = '';

  const nombre   = inputNombre.value.trim();
  const nota     = parseInt(inputNota.value,     10);
  const creditos = parseInt(inputCreditos.value, 10);

  const { valido, mensaje } = validarMateria(nombre, nota, creditos);

  if (!valido) {
    errorMsg.textContent = mensaje;
    return;
  }

  // Crear objeto materia y agregarlo al array
  const nuevaMateria = { id: nextId++, nombre, nota, creditos };
  materias.push(nuevaMateria);

  // Renderizar con animación en la nueva fila
  renderizar(nuevaMateria.id);

  // Limpiar formulario y hacer foco en el nombre
  form.reset();
  inputNombre.focus();
});

/**
 * Maneja el clic en botones de eliminar (delegación de eventos).
 * En lugar de poner un listener a cada botón, ponemos uno solo en el tbody.
 */
tablaBody.addEventListener('click', function (evento) {
  const boton = evento.target.closest('[data-id]');
  if (!boton) return;

  const id = parseInt(boton.dataset.id, 10);

  // Filtrar el array eliminando la materia con ese id
  materias = materias.filter(m => m.id !== id);

  renderizar();
});

/**
 * Carga datos de ejemplo para que el usuario entienda cómo funciona.
 */
btnDemo.addEventListener('click', function () {
  materias = [
    { id: nextId++, nombre: 'Algoritmos y Programación I',  nota: 8,  creditos: 6 },
    { id: nextId++, nombre: 'Álgebra I',                    nota: 7,  creditos: 6 },
    { id: nextId++, nombre: 'Análisis Matemático I',        nota: 6,  creditos: 6 },
    { id: nextId++, nombre: 'Física I',                     nota: 9,  creditos: 6 },
    { id: nextId++, nombre: 'Introducción al Desarrollo',   nota: 10, creditos: 4 },
  ];
  renderizar();
});

/**
 * Limpia todas las materias del estado y la UI.
 */
btnLimpiar.addEventListener('click', function () {
  if (materias.length === 0) return;

  const confirmar = window.confirm('¿Seguro que querés borrar todas las materias?');
  if (!confirmar) return;

  materias = [];
  renderizar();
});

// ── Inicio de la app ─────────────────────────────────────────────────
// Renderizado inicial (sin materias → muestra estado vacío)
renderizar();
