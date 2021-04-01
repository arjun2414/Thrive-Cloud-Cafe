import {page} from "../main.js";

$(".alert-warning").hide();

page.ready(function (page) {
    page.php.session(["organization"], function (data) {
        console.log(data);
        if (data["organization"] == null) {
            // no organization
            $(".organization-form").load("html/assets/forms/organization_create.html #form-ref", function () {
                $('#inputTypes').selectpicker();

                $("#btn-register").click(function () {
                    const name = $("#inputName").val();
                    const address = $("#inputAddress").val();
                    const city = $("#inputCity").val();
                    const zip = $("#inputZip").val();
                    const capacity = $("#inputCapacity").val();
                    const types = $("#inputTypes").val();
                    const refrigeration = $("#refrigerationCheck").is(':checked');

                    var flag = false;

                    $(".invalid-feedback").hide();

                    if (!name) {
                        flag = true;
                        $("#invalid-name").show();
                    }
                    if (!address) {
                        flag = true;
                        $("#invalid-addr").show();
                    }
                    if (!city) {
                        flag = true;
                        $("#invalid-city").show();
                    }
                    if (!zip) {
                        flag = true;
                        $("#invalid-zip").show();
                    }
                    if (!capacity) {
                        flag = true;
                        $("#invalid-capacity").show();
                    }
                    if (!types) {
                        flag = true;
                        $("#invalid-types").show();
                    }

                    if (flag) {
                        return;
                    }

                    page.php.sendMail("organization-form", name,name + " - Organization Submission Request",
                        "-------------------------------<br />" +
                        "<b>Organization Name:</b> " + name + "<br />" +
                        "<b>Address: </b>" + address + ", " + city + ", " + zip + "<br />" +
                        "<b>Storage Capacity: </b>" + capacity + "<br />" +
                        "<b>Food Types: </b>" + types + "<br />" +
                        "<b>Refrigeration Available: </b>" + refrigeration, function (data) {
                            console.log(data);
                            page.php.defineOrganization(name, address, city, zip, capacity, types, refrigeration, function (data) {
                                console.log(data);
                                if (data != null) {
                                    alert("Success!");
                                    location.reload();
                                }
                            });
                        });
                });

                page.stopLoadingAnimation();
                alert("You are not part of an organization. Register one or contact the support team.")
            });
        } else if(data["organization"] === "pending") {
            $(".alert-warning").show();
        } else {
            $(".organization-form").load("html/assets/forms/organization_info.html #form-ref", function () {
                page.php.getOrganization(data["organization"], function(data) {
                    console.log(data);
                    $("#titleOrganization").html(data["organizationName"]);
                    $("#street").html(data["streetAddress"]);
                    $("#city").html(data["city"]);
                    $("#zip").html(data["zip"]);
                    $("#capacity").html(data["capacity"]);
                    const tags = data["types"].join(", ");
                    $("#food-tags").html(tags);
                    drawBasic();


                    page.stopLoadingAnimation();
                });
            });
        }
    });
});

google.charts.load('current', {packages: ['corechart', 'line']});
google.charts.setOnLoadCallback(drawBasic);

function drawBasic() {
    var data = new google.visualization.DataTable();
    data.addColumn('number', 'X');
    data.addColumn('number', 'Overall Stock');

    data.addRows([
        [0, 170],   [1, 155],  [2, 130],  [3, 121],  [4, 151],  [5, 123],
        [6, 111],  [7, 98],  [8, 150],  [9, 133],  [10, 126], [11, 117],
        [12, 101], [13, 87], [14, 170], [15, 163], [16, 161], [17, 150],
        [18, 123], [19, 117], [20, 165], [21, 143], [22, 124], [23, 117],
        [24, 98], [25, 76], [26, 155], [27, 143], [28, 126], [29, 114],
        [30, 103], [31, 164]
    ]);

    var options = {
        hAxis: {
            title: 'Days'
        },
        vAxis: {
            title: 'Stock'
        }
    };

    var chart = new google.visualization.LineChart(document.getElementById('chart_div'));

    chart.draw(data, options);
}