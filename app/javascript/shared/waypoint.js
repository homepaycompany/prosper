import waypoints from 'waypoints/lib/noframework.waypoints.js';

const productsWaypoint = new Waypoint({
  element: document.querySelector('.landing-products'),
  handler: function() {
    document.querySelector('.landing-products img').classList.remove('hidden');
    document.querySelector('.landing-products img').classList.add('animated', 'slideInRight');
  }
})

export { waypoint };
