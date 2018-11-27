// console.log('running image_animate.js');

// const image = document.querySelector('.fullscreen');
// // console.log(image);
// // image.style.backgroundImage = '';
// // image.style.background = 'pink';

// console.log('background')

$(function() {
  var body = $('.fullscreen');
  const gradient = "linear-gradient(-225deg, rgba(0,101,168,0.3) 0%, rgba(0,36,61,0.4) 50%)"
  var backgrounds = new Array(
  'url("https://images.pexels.com/photos/1141853/pexels-photo-1141853.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=540")',
  'url(https://i.redd.it/1h4ppy7xpljy.png)',
  'url("https://images.pexels.com/photos/351774/pexels-photo-351774.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=540")',
  // 'url("https://images.pexels.com/photos/113727/pexels-photo-113727.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=540")'
  );
  var current = 0;

  function nextBackground() {
    body.css(
      'background-image',
      `${gradient}, ${backgrounds[current = ++current % backgrounds.length]}`);

    setTimeout(nextBackground, 7000);
  }

  setTimeout(nextBackground, 7000);
  body.css('background-image', `${gradient}, ${backgrounds[0]}`);
});
