mkcd() {
  mkdir -p "$1"
  cd "$1"
}

extract() {
  tar -xf "$1"
}