import { page } from "../main.js";


function display(data){
  console.log(data);
  var tbl = document.getElementById("org-table");
  data.forEach(element => {
    var row = tbl.insertRow();
    var cell1 = row.insertCell();
    var cell2 = row.insertCell();
    var cell3= row.insertCell();
    var cell4 = row.insertCell();
    var cell5 = row.insertCell();
    cell1.innerHTML = element.organizationName;
    cell2.innerHTML = element.streetAddress;
    cell3.innerHTML = element.city;
    cell4.innerHTML = element.capacity;

    var type = element.types;
    var c = 0;
    type.forEach(tp => {
      if (c == 0){
        cell5.innerHTML = cell5.innerHTML + tp;
        c = c + 1;
      }
      else{
        cell5.innerHTML = cell5.innerHTML + ', ' + tp;
      }

    });
  });
}

// $("#btn-load").click(function() {
//     myFunction();
// });

page.ready(function (page) {
  page.php.getOrganizations(function(data) {
    display(data);
    page.stopLoadingAnimation();
  });
});

