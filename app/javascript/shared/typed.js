import Typed from 'typed.js';

function loadDynamicBannerText() {
  new Typed('#banner-typed-text', {
    strings: ["Bonjour Pierre, je viens de finir ma recherche dans Paris, tu trouveras tout en haut de cette page les meilleurs deals de la journée d'après mes calculs :-)."],
    typeSpeed: 50,
    loop: false,
    showCursor: true,
    cursorChar: '|',
    autoInsertCss: true,
  });
}

export { loadDynamicBannerText };
