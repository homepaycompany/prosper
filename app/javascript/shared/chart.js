// Function to identify the minimum of an array
Array.min = function( array ){
  return Math.min.apply( Math, array );
};

// Minimum value to show on the chart
const minValues = data.map(function(item) {
                    return item.data[0][1];
                  });
const minY = Array.min(minValues);
const minValues2 = data2.map(function(item) {
                    return item.data[0][1];
                  });
const minY2 = Array.min(minValues2);

// Function to add charts on Flat#show
function addChart() {
  console.log(minValues);
  console.log(minY);
  new Chartkick.ScatterChart(
    "flat-chart",
    data,
    { legend: false,
      xtitle: "Prix (€)",
      ytitle: "Surface (m²)",
      library: {
        yAxis: {
          min: minY
        },
        tooltip: {
          enabled: true,
          useHTML: true,
          style: { pointerEvents: 'auto' },
          formatter: function() {
            return `<a href="${this.series.name}">Voir l'annonce</a>`;
          }
        }
      }
    });
  new Chartkick.ScatterChart(
    "flat-chart-size",
    data2,
    { legend: false,
      xtitle: "Prix (€/m²)",
      ytitle: "Surface (m²)",
      library: {
        yAxis: {
          min: minY2
        },
        tooltip: {
          enabled: true,
          useHTML: true,
          style: { pointerEvents: 'auto' },
          formatter: function() {
            return `<a href="${this.series.name}">Voir l'annonce</a>`;
          }
        }
      }
    });
}

export { addChart };
