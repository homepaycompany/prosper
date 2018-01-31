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

// Javascript for chart
import { chartJS } from "../shared/chart.js"
chartJS();

// Javascript to calculate the investment return for sliders on Flat#show
import { returnCalculation } from "../shared/slider.js"
returnCalculation();

// Javascript to type automaticly
// import { loadDynamicBannerText } from '../shared/typed.js';
// loadDynamicBannerText();

// Javascript to submit forms on Flat#index
import { formSubmit } from "../shared/submit.js"
formSubmit();

// Javascript to submit forms on Flat#index
import { carouselFlat } from "../shared/carousel.js"
carouselFlat();
