import Siema from 'siema';
const mySiema = new Siema({
  draggable: true,
  duration: 900,
  loop: true,
  perPage: 2,
});
document.querySelector('.prev').addEventListener('click', () => mySiema.prev());
document.querySelector('.next').addEventListener('click', () => mySiema.next());

// listen for keydown event
// setInterval(() => mySiema.next(), 5500)
