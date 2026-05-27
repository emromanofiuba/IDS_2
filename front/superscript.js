document.addEventListener('DOMContentLoaded', function() {
    const agregarItem = document.getElementById("boton");
    const lista = document.getElementById("lista");

    agregarItem.addEventListener('click', function() {
        const nuevoItem = document.createElement("li");
        nuevoItem.textContent = "Nuevo Item";
        lista.appendChild(nuevoItem);
    });
}); 
