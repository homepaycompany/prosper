function addChart() {
  // var scatterData = [{
  //        name: "Female",
  //        data: [[174.0, 73.6], [162.6, 61.4], [174.0, 55.5], [162.6, 63.6], [161.3, 60.9]]
  //        }, {
  //          name: "Male",
  //          data: [[174.0, 80.0], [176.5, 82.3], [180.3, 73.6], [167.6, 74.1], [188.0, 85.9]]
  //      }];
   new Chartkick.ScatterChart("flat-chart", data, {"colors": ["#243059", "#20E8B6"]}, {"xtitle": "Price"}, {"ytitle": "Size"}, {"legend": false});
}

export { addChart };
