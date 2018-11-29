// console.log('running image_animate.js');

// const image = document.querySelector('.fullscreen');
// // console.log(image);
// // image.style.backgroundImage = '';
// // image.style.background = 'pink';

// console.log('background')

// ------ begining of former function ----------

// $(function() {
//   var body = $('.fullscreen');
//   const gradient = "linear-gradient(-225deg, rgba(0,101,168,0.3) 0%, rgba(0,36,61,0.4) 50%)"
//   var backgrounds = body.data("photos");
//   var current = backgrounds.length - 1;

//   function sleep(milliseconds) {
//     var start = new Date().getTime();
//     for (var i = 0; i < 1e7; i++) {
//       if ((new Date().getTime() - start) > milliseconds){
//         break;
//       }
//     }
//   }

//   function nextBackground() {
//     body.animate({opacity: 0}, 500);
//     setTimeout( function(){
//         body.css(
//           'background-image',
//           `${gradient}, url("${backgrounds[current = ++current % backgrounds.length]}")`);
//         body.animate({opacity: 1}, 500).delay(100);
//       }, 500);

//     setTimeout(nextBackground, 7000);
//   }

//   nextBackground();
// });
// ------ end of former function ----------

