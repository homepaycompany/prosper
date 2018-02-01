function submit() {
  const formNumber = event.currentTarget.dataset.form;
  const form = document.querySelector(`form[data-form="${formNumber}"]`);
  form.submit();
}

function formSubmit() {
  const forms = document.querySelectorAll(".flat-card-form");
  forms.forEach(form => form.addEventListener('click', submit));
}

export { formSubmit };
