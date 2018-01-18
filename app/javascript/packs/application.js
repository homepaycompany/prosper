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

