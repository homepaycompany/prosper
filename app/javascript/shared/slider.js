import "bootstrap-slider/dist/css/bootstrap-slider.css";

// Definition of sliders
const priceSlider = document.querySelector("#flat-price-slider");
const contributionSlider = document.querySelector("#flat-contribution-slider");
const interestSlider = document.querySelector("#flat-interest-slider");
const loanDurationSlider = document.querySelector("#flat-loan-duration-slider");
const refurbishmentSlider = document.querySelector("#flat-refurbishment-slider");
const sellingPriceSlider = document.querySelector("#flat-selling-price-slider");

// Functions to format numbers (from floats to texts and vice versa)
function numberToString(number) {
  var nStr = number.toString()
  var remainder = nStr.length % 3;
  return (nStr.substr(0, remainder) + nStr.substr(remainder).replace(/(\d{3})/g, ' $1')).trim();
}
function stringToNumber(string) {
  return parseFloat(string.replace(/\s/g, ''));
}

// Function to calculate investment return
function calculateReturn() {
  // Definition of variables taken into account in the return calculation
  const price = priceSlider.dataset.value;
  const contribution = contributionSlider.dataset.value;
  const interest = interestSlider.dataset.value;
  const loanDuration = loanDurationSlider.dataset.value;
  const refurbishment = refurbishmentSlider.dataset.value;
  const sellingPrice = sellingPriceSlider.dataset.value;

  const currentMargin = document.querySelector("#flat-return").innerHTML;

  var size = stringToNumber(document.querySelector("#js-size").innerHTML);
  var interests = interest / 100 * (price - contribution) * loanDuration / 12 ;
  var refurbishmentCosts = refurbishment * size;
  var notarialCosts = sellingPrice * 0.025 ;
  var margin = sellingPrice - price - interests - refurbishmentCosts - notarialCosts;
  if (margin > 0) {
    var margin_rate = Math.pow((margin / price), (loanDuration / 12));
  } else {
    var margin_rate = - Math.pow(-(margin / price), (loanDuration / 12));
  }
  return [margin, margin_rate];
}

// Function to update returns on Flat#show
function updateReturn() {
  // Definition of variables to update
  const marginHeader = document.querySelector("#flat-return");
  const marginText = document.querySelector('#js-return');
  const marginRateText = document.querySelector('#js-return-rate');

  // Definition of variables with margin and margin rate
  const margin = calculateReturn()[0];
  const margin_rate = calculateReturn()[1];

  // Update the new margin rate in the header and change the class if necessary
  marginHeader.innerHTML = `${(margin_rate * 100).toFixed(1)}%`
  if ((margin_rate > 0) && (marginHeader.classList.value === "show-flat-negative-return")) {
    marginHeader.classList.toggle("show-flat-positive-return");
    marginHeader.classList.toggle("show-flat-negative-return");
  } else if ((margin_rate < 0) && (marginHeader.classList.value === "show-flat-positive-return")) {
    marginHeader.classList.toggle("show-flat-positive-return");
    marginHeader.classList.toggle("show-flat-negative-return");
  }

  // Update the margin in the detail of margin calculation
    marginText.innerHTML = numberToString(margin.toFixed(0));
    marginRateText.innerHTML = `${(margin_rate * 100).toFixed(1)}%`;
}

// Function to set values when values on sliders change
function setValue() {
  // Definition of the event target
  const eventSlider = event.target.parentNode.id;

  // Definition of variables taken into account in the return calculation
  const price = priceSlider.dataset.value;
  const contribution = contributionSlider.dataset.value;
  const interest = interestSlider.dataset.value;
  const loanDuration = loanDurationSlider.dataset.value;
  const refurbishment = refurbishmentSlider.dataset.value;
  const size = stringToNumber(document.querySelector("#js-size").innerHTML);
  const sellingPrice = sellingPriceSlider.dataset.value;
  const financingCosts = (-interest * (price - contribution) * loanDuration / 12).toFixed(0);
  const refurbishmentCosts = - refurbishment * size;
  const notarialCosts = - sellingPrice * 0.025;

  // Definition of assumptions in calculation detail
  const priceText = document.querySelectorAll('#js-price');
  const contributionText = document.querySelectorAll('#js-contribution');
  const refurbishmentText = document.querySelectorAll('#js-refurbishment');
  const loanDurationText = document.querySelector('#js-loan-duration');
  const financingText = document.querySelectorAll('#js-financing-costs');
  const interestText = document.querySelector('#js-interest');
  const notarialText = document.querySelectorAll('#js-notarial-costs');
  const primeCostsText = document.querySelectorAll('#js-prime-costs');
  const sellingPriceText = document.querySelectorAll('#js-selling-price');


  // Show the new assumption undertaken by the user
  if (eventSlider == "flatPriceSlider") {
    priceText.forEach(element => element.innerHTML = numberToString(price)) ;
    // Define a new maximum for the contribution slider
    // contributionSlider.dataset.sliderMax = price;

  } else if (eventSlider == "flatContributionSlider") {
    contributionText.forEach(element => element.innerHTML = numberToString(contribution)) ;

  } else if (eventSlider == "flatInterestSlider") {
    interestText.forEach(element => element.innerHTML = `${(interest * 100).toFixed(1)}%`);
    financingText.forEach(element => element.innerHTML = numberToString(financingCosts));

  } else if (eventSlider == "flatLoanSlider") {
    loanDurationText.forEach(element => element.innerHTML = numberToString(loanDuration));
    financingText.forEach(element => element.innerHTML = numberToString(financingCosts));

  } else if (eventSlider == "flatRefurbishmentSlider") {
    refurbishmentText.forEach(element => element.innerHTML = numberToString(refurbishmentCosts));

  } else if (eventSlider == "flatSellingPriceSlider") {
    sellingPriceText.forEach(element => element.innerHTML = numberToString(sellingPrice));
    notarialText.forEach(element => element.innerHTML = numberToString(notarialCosts));
  }

  // Calculate and show the new return
  updateReturn();
}

// Function to listen events on sliders
function returnCalculation() {
  // Creation of sliders if on page Flat#show
  const priceSliderObject = new Slider("input#flat-price-slider");
  const contributionSliderObject = new Slider("input#flat-contribution-slider");
  const interestSliderObject = new Slider("input#flat-interest-slider");
  const loanDurationSliderObject = new Slider("input#flat-loan-duration-slider");
  const refurbishmentSliderObject = new Slider("input#flat-refurbishment-slider");
  const sellingPriceSliderObject = new Slider("input#flat-selling-price-slider");

  priceSliderObject.on('slide', setValue);
  contributionSliderObject.on('slide', setValue);
  interestSliderObject.on('slide', setValue);
  loanDurationSliderObject.on('slide', setValue);
  refurbishmentSliderObject.on('slide', setValue);
  sellingPriceSliderObject.on('slide', setValue);
}

export { returnCalculation };
