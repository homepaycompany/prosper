const clicky = document.getElementById("clicker");
clicky.addEventListener("click", (event) => {
  event.currentTarget.classList.remove("fa-heart-o")
  event.currentTarget.classList.toggle("fa-heart")
});


