import "bootstrap-slider/dist/css/bootstrap-slider.css";


// Creation of sliders
const priceSlider = new Slider("input#flat-price-slider");
const contributionSlider = new Slider("input#flat-contribution-slider");
const interestSlider = new Slider("input#flat-interest-slider");
const loanDurationSlider = new Slider("input#flat-loan-duration-slider");
const refurbishmentSlider = new Slider("input#flat-refurbishment-slider");
const sellingPriceSlider = new Slider("input#flat-selling-price-slider");

// Function to add spaces for thousands
function numberToString(number) {
  var nStr = number.toString()
  var remainder = nStr.length % 3;
  return (nStr.substr(0, remainder) + nStr.substr(remainder).replace(/(\d{3})/g, ' $1')).trim();
}
function stringToNumber(string) {
  return parseFloat(string.replace(/\s/g, ''));
}

// Function to calculate investment return
function calculateReturn(price, contribution, interest, loanDuration, refurbishment, sellingPrice) {
  const currentMargin = document.querySelector("#flat-return").innerHTML;
  var interests = 0;
  var refurbishmentCosts = 0;
  var notarialCosts = 0;
  var margin = sellingPrice - price;
  // console.log(sellingPrice);
  // console.log(price);
  // console.log(margin);
  // var margin = sellingPrice - price - refurbishmentCosts - interests - notarialCosts;
  var margin_rate = margin / price;
  ;
  // console.log(sellingPrice.replace(/\s/g, '').to_f);

  // Show the new margin rate and change the class if necessary
  document.querySelector("#flat-return").innerHTML = `${(margin_rate * 100).toFixed(1)}%`
  if (margin_rate > 0 && currentMargin < 0) {
    document.querySelector("#flat-return").toggleClass("flat-positive-return");
    document.querySelector("#flat-return").toggleClass("flat-negative-return");
  } else if (margin_rate < 0 && currentMargin > 0) {
    document.querySelector("#flat-return").toggleClass("flat-positive-return");
    document.querySelector("#flat-return").toggleClass("flat-negative-return");
  }
}

// Function to set values when values on sliders change
function setValue() {
  const eventSlider = event.target.parentNode.id;
  const price = document.querySelector('#js-assumption-price');
  const contribution = document.querySelector('#js-assumption-contribution');
  const interest = document.querySelector('#js-assumption-interest');
  const loanDuration = document.querySelector('#js-assumption-loan-duration');
  const refurbishment = document.querySelector('#js-assumption-refurbishment');
  const sellingPrice = document.querySelector('#js-assumption-selling-price');
  const priceN = stringToNumber(price.innerHTML);
  const contributionN = stringToNumber(contribution.innerHTML);
  const interestN = stringToNumber(interest.innerHTML);
  const loanDurationN = stringToNumber(loanDuration.innerHTML);
  const refurbishmentN = stringToNumber(refurbishment.innerHTML);
  const sellingPriceN = stringToNumber(sellingPrice.innerHTML);

  // Show the new price, define a new maximum for the contribution slider and calculate the new return
  if (eventSlider == "flatPriceSlider") {
    var newPrice = priceSlider.getValue();
    price.innerHTML = numberToString(newPrice);
    // contribution.dataset.sliderMax = newPrice;
    calculateReturn(newPrice, contributionN, interestN, loanDurationN, refurbishmentN, sellingPriceN)

  // Show the new contribution and calculate the new return
  } else if (eventSlider == "flatContributionSlider") {
    var newContribution = contributionSlider.getValue();
    contribution.innerHTML = numberToString(newContribution);
    calculateReturn(priceN, newContribution, interestN, loanDurationN, refurbishmentN, sellingPriceN)

  // Show the new interest and calculate the new return
  } else if (eventSlider == "flatInterestSlider") {
    var newInterest = interestSlider.getValue();
    interest.innerHTML = `${(newInterest * 100).toFixed(1)}%` ;
    calculateReturn(priceN, contributionN, newInterest, loanDurationN, refurbishmentN, sellingPriceN)

  // Show the new loan duration and calculate the new return
  } else if (eventSlider == "flatLoanSlider") {
    var newLoanDuration = loanDurationSlider.getValue();
    loanDuration.innerHTML = numberToString(newLoanDuration);
    calculateReturn(priceN, contributionN, interestN, newLoanDuration, refurbishmentN, sellingPriceN)

  // Show the new loan duration and calculate the new return
  } else if (eventSlider == "flatRefurbishmentSlider") {
    var newRefurbishment = refurbishmentSlider.getValue();
    refurbishment.innerHTML = numberToString(newRefurbishment);
    calculateReturn(priceN, contributionN, interestN, loanDurationN, newRefurbishment, sellingPriceN)

  // Show the new loan duration and calculate the new return
  } else if (eventSlider == "flatSellingPriceSlider") {
    var newSellingPrice = sellingPriceSlider.getValue();
    sellingPrice.innerHTML = numberToString(newSellingPrice);
    calculateReturn(priceN, contributionN, interestN, loanDurationN, refurbishmentN, newSellingPrice)
  }
}

// Function to listen events on sliders
function returnCalculation() {
  priceSlider.on('slide', setValue);
  contributionSlider.on('slide', setValue);
  interestSlider.on('slide', setValue);
  loanDurationSlider.on('slide', setValue);
  refurbishmentSlider.on('slide', setValue);
  sellingPriceSlider.on('slide', setValue);
}

export { returnCalculation };
