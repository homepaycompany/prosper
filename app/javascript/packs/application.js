import "bootstrap";
import "animate.css";

// Javascript for fadeing and fadeout effects on alerts
import { smoothAlert } from "../shared/alert.js"
smoothAlert();

// Javascript for animate.css when scrolling to identified sections
import "../shared/landing_page.js"

// Javascript for chart
import { chartJS } from "../shared/chart.js"
chartJS();

// Javascript for sliders
import { slider } from "../shared/slider.js"
slider();

// Javascript for Crisp chat
import { crisp } from "../shared/crisp.js"
crisp();
