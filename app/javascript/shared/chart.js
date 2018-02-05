function addChart() {
  new Chartkick.ScatterChart("flat-chart", data, {legend: false, colors: ["#243059", "#20E8B6"], xtitle: "Prix", ytitle: "Surface"});
}

export { addChart };
