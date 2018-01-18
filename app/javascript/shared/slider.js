import "bootstrap-slider/dist/css/bootstrap-slider.css";

function addSliders() {
  new Slider("input#flat-price-slider");
  new Slider("input#flat-contribution-slider");
  new Slider("input#flat-interest-slider");
  new Slider("input#flat-loan-duration-slider");
  new Slider("input#flat-refurbishment-slider");
  new Slider("input#flat-selling-price-slider");
}

export { addSliders };

