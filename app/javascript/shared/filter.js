function changeFilterFormat() {
  const checkBox = event.target;
  const label = checkBox.parentNode.childNodes[3];
  label.classList.toggle("active");
}

function filter() {
  const roomFilters = document.querySelectorAll('.room-filter input');
  roomFilters.forEach(filter => filter.addEventListener('change', changeFilterFormat));
}

export { filter };
