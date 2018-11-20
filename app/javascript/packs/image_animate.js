// console.log('running image_animate.js');

// const image = document.querySelector('.fullscreen');
// // console.log(image);
// // image.style.backgroundImage = '';
// // image.style.background = 'pink';

// console.log('background')

$(function() {
  var body = $('.fullscreen');
  var backgrounds = new Array(
  'url("https://images.pexels.com/photos/1141853/pexels-photo-1141853.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940")',
  'url("https://images.pexels.com/photos/351774/pexels-photo-351774.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940")',
  'url("https://images.pexels.com/photos/113727/pexels-photo-113727.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260")'
  );
  var current = 0;

  function nextBackground() {
    body.css(
      'background-image',
      backgrounds[current = ++current % backgrounds.length]);
    // ).animate({opacity: 0}, 3000)

    setTimeout(nextBackground, 6000);
  }

  setTimeout(nextBackground, 6000);
  body.css('background-image', backgrounds[0]);
});
