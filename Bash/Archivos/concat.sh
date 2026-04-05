concatenar_archivos() {
    local archivo_pirulo=$1
    local archivo_jaimito=$2
    cat archivo1 archivo2 > concatenados.txt
}
concatenacion=$(concatenar_archivos archivojamito archivopirulo)