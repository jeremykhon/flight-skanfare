const locationQuestion = document.getElementById("location-question");
console.log(locationQuestion)

const locationTokyo = document.getElementById("location-tokyo");

locationQuestion.addEventListener("click", event => {
  locationQuestion.style.display = "none";
  locationTokyo.style.display = "block";
})
