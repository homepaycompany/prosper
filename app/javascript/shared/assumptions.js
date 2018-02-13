function showReturnFormula() {
  const items = document.querySelectorAll('#js-return-item');
  items.forEach(item => item.classList.toggle('hidden'));
  console.log("Coucou");
}

function showAssumption() {
  const items = document.querySelectorAll('#js-assumption-item');
  items.forEach(item => item.classList.toggle('hidden'));
  console.log("Coucou");
}

function showAssumptions() {
  const returnList = document.querySelector('#js-return-list');
  const assumptionList = document.querySelector('#js-assumption-list');
  returnList.addEventListener('click', showReturnFormula);
  assumptionList.addEventListener('click', showAssumption);
}

export { showAssumptions };
