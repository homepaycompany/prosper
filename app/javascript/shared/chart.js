function addChart() {
  if (document.querySelector('#flat-chart')) {
    new Chartkick.ScatterChart(
      "flat-chart",
      data,
      { legend: false,
        xtitle: "Prix",
        ytitle: "Surface",
        library: {
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
  if (document.querySelector('#flat-chart-size')) {
    new Chartkick.ScatterChart(
      "flat-chart-size",
      data2,
      { legend: false,
        xtitle: "Prix",
        ytitle: "Surface",
        library: {
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
}

export { addChart };
