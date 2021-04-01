import { php } from "../util.ajax.js";

class _navbar {
    update() {
        navbar_update();
    }
    addTab(tab) {
        addTab(tab);
    }
    setCurrentTab(name) {
        if(!Object.values(tabs).includes(name.toLowerCase()))
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

function init() {
    $(".main-navbar").load("html/assets/navbar.html .ref", function () {
        $("#logout").click(function () {
            navbar_logout();
        })

        $("#nav-account").hide();
        var navbar = new _navbar();
        navbar.fadeIn(150);
        navbar.update();

        if(nav_element.func !== null) {
            nav_element.func(navbar);
        }
    });
}

function navbar_update() {
    php.session(["displayname", "organization"], function(data) {
        if(data["displayname"] == null)
            return;
        $("#navbarDropdown").html(data["displayname"] + " ");
        if(data["organization"]) {
            if(data["organization"] !== "pending") {
                $("#drop-organization").html(data["organization"]);
            }
        }
        $("#nav-account").show();
        $("#nav-login").hide();
        $("#panelModal").modal('hide');
    });
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
    php.logout(function(data) {
        window.location.replace("index.html");
    })
}