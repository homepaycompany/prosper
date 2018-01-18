function showCookies() {
  window.addEventListener("load", function(){
  window.cookieconsent.initialise({
    "palette": {
      "popup": {
        "background": "#132b49",
        "text": "#ffffff"
      },
      "button": {
        "background": "#1acea1",
        "text": "#ffffff"
      }
    },
    "content": {
      "message": "Ce site utilise des cookies afin de vous offrir la meilleure expérience possible.",
      "dismiss": "Accepter les cookies",
      "link": "En savoir plus"
    }
  })});
}

export { showCookies };

