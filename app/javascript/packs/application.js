import "bootstrap";
import "animate.css";

// Javascript to calculate the investment return
import { showCookies } from "../shared/cookies_management.js"
showCookies();

// Javascript for fadeing and fadeout effects on alerts
import { smoothAlert } from "../shared/alert.js"
smoothAlert();

// Javascript for animate.css when scrolling to identified sections
import "../shared/landing_page.js"

// Javascript to add chart on Flat#show
import { addChart } from "../shared/chart.js"
if (document.querySelector('#flat-chart')) {
  addChart();
}

// Javascript to calculate the investment return for sliders on Flat#show
import { returnCalculation } from "../shared/slider.js"
if (document.querySelector('#flat-price-slider')) {
  returnCalculation();
}

// Javascript to show the assumptions undertaken for the calculation of investment return
import { showAssumptions } from "../shared/assumptions.js"
if (document.querySelector('#flat-price-slider')) {
  showAssumptions();
}

// Javascript to submit forms on Flat#index
import { formSubmit } from "../shared/submit.js"
formSubmit();

// Javascript to change the format of filter on Flat#Index
import { filter } from "../shared/filter.js"
filter();
