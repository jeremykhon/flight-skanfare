import swal from 'sweetalert';

function bindSweetAlertButton() {
 const swalButton = document.querySelector('.create-alert-button');
 const userSignedIn = swalButton.dataset.user
 if (swalButton) {
   swalButton.addEventListener('click', (e) => {
    if (userSignedIn === "true") {
     swal({
           title: "Alert created!",
           text: "You can view all your alerts on the Manage Alerts page",
           icon: "success",
           timer: 5000,
           buttons: false,
         })
    }

    })
  }
}

console.log('Running sweetalert')

bindSweetAlertButton()

// export {bindSweetAlertButton}
