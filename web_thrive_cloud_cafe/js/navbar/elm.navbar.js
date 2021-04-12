import {php} from "../util.ajax.js";

class _navbar {
    update() {
        navbar_update();
    }

    addTab(tab) {
        addTab(tab);
    }

    setCurrentTab(name) {
        if (!Object.values(tabs).includes(name.toLowerCase()))
            addTab(name);
        setCurrentTab(name.toLowerCase());
    }

    logout() {
        navbar_logout();
    }

    fadeIn(delay) {
        let div = $("#nav-ref");
        div.hide();
        div.fadeIn(delay);
    }

    fadeOut(delay) {
        $("#nav-ref").fadeOut(delay);
    }
}

class _element {
    ready(func) {
        this.func = func;
        init();
    }
}

export let tabs = {
    DATABASE: "database",
    MENU: "menu",
    HOME: "home"
}

export let nav_element = new _element();

var timer = null;
var organization = null;
var displayname = null;
var pending_organization = false;


function init() {
    $(".main-navbar").load("html/assets/navbar.html .ref", function () {
        $("#logout").click(function () {
            navbar_logout();
        })

        $("#nav-account").hide();
        var navbar = new _navbar();
        navbar.fadeIn(150);
        navbar.update();

        if (nav_element.func !== null) {
            nav_element.func(navbar);
        }

        timer = setInterval(navbar_update, 15000);
    });
}


function navbar_update() {
    if (organization == null) {
        php.session(["organization"], true, false, function (data) {
            if (data["organization"]) {
                if (data["organization"] === "\\0") {
                    pending_organization = true;
                    return;
                }
                organization = data["organization"];
                $("#drop-organization").html(organization);
                if(pending_organization) {
                    alert("Your organization has been approved.");
                    pending_organization = false;
                }
            }
        });
    }
    if (displayname == null) {
        php.session(["displayname"], false, false, function (data) {
            if (data["displayname"] == null)
                return;
            displayname = data["displayname"];
            $("#navbarDropdown").html(displayname + " ");

            $("#nav-account").show();
            $("#nav-login").hide();
            $("#panelModal").modal('hide');
        });
    }
}

function addTab(tab) {
    $('#nav-tablist').append("" +
        "            <li id=\"" + tab.toLowerCase() + "\" class=\"nav-item\">\n" +
        "                <a class=\"nav-link\" href=\"#\">" + tab + "</a>\n" +
        "            </li>");
}

function setCurrentTab(tab) {
    $('#' + tab).addClass("active");
    for (let t in tab) {
        if (t === tab) {
            continue;
        }
        $("#" + t).removeClass("active");
    }
}

function navbar_logout() {
    php.logout(function (data) {
        window.location.replace("index.html");
    })
    if (timer)
        clearInterval(timer);
}