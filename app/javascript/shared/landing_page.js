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

function fadeInRight(item) {
  item.classList.remove('hidden');
  item.classList.add('animated', 'fadeInRight');
}

function zoomIn(item) {
  item.classList.remove('hidden');
  item.classList.add('animated', 'zoomIn');
}

// Javascript to launch animation effects when scrolling to identified sections
const realEstateWaypoint = new Waypoint({
  element: document.querySelector('.landing-real-estate'),
  handler: function() {
    const image = document.querySelector('#landing-real-estate-media img');
    fadeInRight(image);
  },
  offset: 300
})

const studioWaypoint = new Waypoint({
  element: document.querySelector('.landing-studio'),
  handler: function() {
    const image = document.querySelector('#landing-studio-media img');
    fadeInLeft(image);
  },
  offset: 300
})

const productsWaypoint = new Waypoint({
  element: document.querySelector('.landing-products'),
  handler: function() {
    const images = Array.from(document.querySelectorAll('#landing-products-media img'));
    images.forEach(image => fadeIn(image));
  },
  offset: 300
})

const teamWaypoint = new Waypoint({
  element: document.querySelector('.landing-team'),
  handler: function() {
    const images = Array.from(document.querySelectorAll('#landing-team-media img'));
    images.forEach(image => fadeIn(image));
  },
  offset: 600
})
