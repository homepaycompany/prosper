import waypoints from 'waypoints/lib/noframework.waypoints.js';

// Javascript to add animation effects from animate.css library
function fadeIn(item) {
  item.classList.remove('hidden');
  item.classList.add('animated', 'fadeIn');
}

function fadeInLeft(item) {
  item.classList.remove('hidden');
  item.classList.add('animated', 'fadeInLeft');
}

// Javascript to launch animation effects when scrolling to identified sections
const studioWaypoint = new Waypoint({
  element: document.querySelector('.landing-studio'),
  handler: function() {
    const image = document.querySelector('#landing-studio-media img');
    fadeInLeft(image);
  },
  offset: 200
})

const productsWaypoint = new Waypoint({
  element: document.querySelector('.landing-products'),
  handler: function() {
    const images = Array.from(document.querySelectorAll('#landing-products-media img'));
    images.forEach(image => fadeIn(image));
  },
  offset: 200
})
