import waypoints from 'waypoints/lib/noframework.waypoints.js';

function addAnimation(item) {
  item.classList.remove('hidden');
  item.classList.add('animated', 'fadeIn');
}

const productsWaypoint = new Waypoint({
  element: document.querySelector('.landing-studio'),
  handler: function() {
    const images = Array.from(document.querySelectorAll('.landing-products img'));
    images.forEach(image => addAnimation(image));
  }
})

export { waypoint };
