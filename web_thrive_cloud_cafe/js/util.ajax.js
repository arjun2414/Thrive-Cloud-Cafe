class _php {
    setPage(page) {
        this.page = page;
    }
    login(email, userid, displayname, onComplete) {
        ajax(true, "php/login.php", {email: email, userid: userid, displayname: displayname}, true, onComplete);
    }
    register(email, userid, displayname, onComplete) {
        ajax(true, "php/register.php", {email: email, userid: userid, displayname: displayname}, true, onComplete);
    }
    session(types, update, animation, onComplete) {
        ajax(true, "php/session.php", {update: update, types: types}, animation, onComplete);
    }
    logout(onComplete) {
        ajax(true, "php/logout.php", null, true, onComplete);
    }
    getOrganizations(onComplete) {
        ajax(true, "php/organization.php", {prep: "collect"}, true, onComplete);
    }
    getOrganization(name, onComplete) {
        ajax(true, "php/organization.php", {prep: "get", organization: name}, true, onComplete);
    }
    defineOrganization(name, address, city, zip, capacity, types, refrigeration, onComplete) {
        ajax(true, "php/organization.php",
            {prep: "register", name: name, address: address, city: city, zip: zip, capacity: capacity, types: types, refrigeration: refrigeration},
            true, onComplete);
    }
    /*beginSessionListen(onEvent) {
        ajax(true, "php/session_listener.php", null, false, onEvent);
    }*/
    sendMail(prep, organization, subject, message, onComplete) {
        ajax(true, "php/email/sendEmail.php", {prep: prep, organization: organization, subject: subject, message: message}, true, onComplete);
    }
}

export let php = new _php();

function ajax(async, url, data, animation, onComplete) {
    if(php.page != null && animation) {
        php.page.startLoadingAnimation();
    }
    $.ajax({
        async: async,
        dataType: "json",
        url: url,
        type: "post",
        data: data,
        success: function (data) {
            onComplete(data);
            if(php.page != null) {
                php.page.stopLoadingAnimation();
            }
        },
        error: function (xhr, desc, err) {
            console.log("Error");
            console.log(xhr.responseText);
            console.log("Details: " + desc + "\nError: " + err);
            onComplete(null);
            if(php.page != null) {
                php.page.stopLoadingAnimation();
            }
        }
    });
}

