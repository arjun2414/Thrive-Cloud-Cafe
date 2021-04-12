import {php} from "./util.ajax.js";
import { nav_element } from "./navbar/elm.navbar.js";
import { tabs } from "./navbar/elm.navbar.js";

class _page {
    constructor() {
        this.php = php;
        this.tabs = tabs;
        this.php.setPage(page);
    }
    ready(func) {
        this.func = func;
    }
    startLoadingAnimation() {
        startLoadingAnimation();
    }
    stopLoadingAnimation() {
        stopLoadingAnimation();
    }
}

class _pagemeta {
    constructor(navbar) {
        this.navbar = navbar;
        this.php = php;
        this.tabs = tabs;
        this.php.setPage(page);
    }
    startLoadingAnimation() {
        startLoadingAnimation();
    }
    stopLoadingAnimation() {
        stopLoadingAnimation();
    }
}

export var page = new _page();

page.startLoadingAnimation();

let session_whitelist = ["index.html"];
let page_tabs = new Map();

page_tabs[""] = tabs.HOME;
page_tabs["index.html"] = tabs.HOME;
page_tabs["organization.html"] = "Organization";
page_tabs["database.html"] = "Database"

let src = window.location.pathname.split("/").pop();
if(!session_whitelist.includes(src)) {
    php.session(["user_id"], false, true, function(data) {
        if(data["user_id"] == null) {
            // user not logged in
            window.location.replace("index.html");
        }
    });
}

$(".main-navbar").after("" +
    "<div id=\"spinner-main\" class=\"spinner text-center\">\n" +
    "    <div class=\"spinner-border\" style=\"width: 3rem; height: 3rem;\" role=\"status\"></div>\n" +
    "</div>");

nav_element.ready(function(navbar) {
    navbar.setCurrentTab(page_tabs[src]);
    $(".footer").load("html/assets/footer.html .ref", function () {
        if(page.func != null) {
            page.func(new _pagemeta(navbar));
        }
    });
});

function startLoadingAnimation() {
    $("#spinner-main").fadeIn(500);
}

function stopLoadingAnimation() {
    $("#spinner-main").fadeOut(500);
}