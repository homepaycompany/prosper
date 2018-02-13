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

  var size = stringToNumber(document.querySelector("#js-assumption-size").innerHTML);
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
  const sellingPrice = sellingPriceSlider.dataset.value;

  // Definition of assumptions undertaken by the user (DOM)
  const priceT = document.querySelector('#js-assumption-price');
  const contributionT = document.querySelector('#js-assumption-contribution');
  const interestT = document.querySelector('#js-assumption-interest');
  const loanDurationT = document.querySelector('#js-assumption-loan-duration');
  const refurbishmentT = document.querySelector('#js-assumption-refurbishment');
  const sellingPriceT = document.querySelector('#js-assumption-selling-price');

  // Definition of assumptions in calculation detail
  const priceText = document.querySelector('#js-price');
  const contributionText = document.querySelector('#js-contribution');
  const refurbishmentText = document.querySelector('#js-refurbishment');
  const financingText = document.querySelector('#js-financing-costs');
  const notarialText = document.querySelector('#js-notarial-costs');
  const primeCostsText = document.querySelector('#js-prime-costs');
  const sellingPriceText = document.querySelector('#js-selling-price');

  // Definition of the flat size
  const size = stringToNumber(document.querySelector("#js-assumption-size").innerHTML);

  // Show the new assumption undertaken by the user
  if (eventSlider == "flatPriceSlider") {
    priceT.innerHTML = numberToString(price);
    priceText.innerHTML = numberToString(price);
    // Define a new maximum for the contribution slider
    // contributionSlider.dataset.sliderMax = price;

  } else if (eventSlider == "flatContributionSlider") {
    contributionT.innerHTML = numberToString(contribution);
    contributionText.innerHTML = numberToString(contribution);

  } else if (eventSlider == "flatInterestSlider") {
    interestT.innerHTML = `${(interest * 100).toFixed(1)}%` ;
    financingText.innerHTML = numberToString((-interest * (price - contribution) * loanDuration / 12).toFixed(0));

  } else if (eventSlider == "flatLoanSlider") {
    loanDurationT.innerHTML = numberToString(loanDuration);
    financingText.innerHTML = numberToString((-interest * (price - contribution) * loanDuration / 12).toFixed(0));

  } else if (eventSlider == "flatRefurbishmentSlider") {
    refurbishmentT.innerHTML = numberToString(refurbishment);
    refurbishmentText.innerHTML = numberToString(newRefurbishment * size);

  } else if (eventSlider == "flatSellingPriceSlider") {
    sellingPriceT.innerHTML = numberToString(sellingPrice);
    sellingPriceText.innerHTML = numberToString(sellingPrice);
    notarialText.innerHTML = numberToString(newSellingPrice * 0.025);
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
