function addChart() {
  new Chartkick.ScatterChart(
    "flat-chart",
    data,
    { legend: false,
      xtitle: "Prix (€)",
      ytitle: "Surface (m²)",
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
  new Chartkick.ScatterChart(
    "flat-chart-size",
    data2,
    { legend: false,
      xtitle: "Prix (€/m²)",
      ytitle: "Surface (m²)",
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

export { addChart };
