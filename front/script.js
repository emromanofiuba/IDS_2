const lista = document.getElementById("lista")
const elementos = ["primero", "segundo", "tercero"]
const titulo = document.getElementById('titulo')
const boton = document.getElementsByTagName('button')

titulo.textContent = 'aguante java'
titulo.style.color = 'blue'
titulo.classList.add('nombre_clase')

elementos.forEach(texto => {
    const li = document.createElement('li');
    li.textContent = texto;
    lista.appendChild(li);
})

boton.addEventListener('click', () => {
    function irASlack() {
        window.location.href = "https://app.slack.com/client/T06N39C4AB1/C06P6L28R9N";
        boton.style.width = '200px';
        boton.style.height = '100px';
    }
    irASlack();
});