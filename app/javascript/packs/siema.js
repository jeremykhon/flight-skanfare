import Siema from 'siema';
const mySiema = new Siema({
  draggable: true,
  duration: 600,
  loop: true,
});
document.querySelector('.prev').addEventListener('click', () => mySiema.prev());
document.querySelector('.next').addEventListener('click', () => mySiema.next());

// listen for keydown event
setInterval(() => mySiema.next(), 4000)
