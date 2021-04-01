class _php {
    setPage(page) {
        this.page = page;
    }
    login(email, userid, displayname, onComplete) {
        ajax(true, "php/login.php", {email: email, userid: userid, displayname: displayname}, onComplete);
    }
    register(email, userid, displayname, onComplete) {
        ajax(true, "php/register.php", {email: email, userid: userid, displayname: displayname}, onComplete);
    }
    session(types, onComplete) {
        ajax(true, "php/session.php", {types: types}, onComplete);
    }
    logout(onComplete) {
        ajax(true, "php/logout.php", null, onComplete);
    }
    getOrganizations(onComplete) {
        ajax(true, "php/organization.php", {prep: "collect"}, onComplete);
    }
    getOrganization(name, onComplete) {
        ajax(true, "php/organization.php", {prep: "get", organization: name}, onComplete);
    }
    defineOrganization(name, address, city, zip, capacity, types, refrigeration, onComplete) {
        ajax(true, "php/organization.php",
            {prep: "register", name: name, address: address, city: city, zip: zip, capacity: capacity, types: types, refrigeration: refrigeration},
            onComplete);
    }
    sendMail(prep, organization, subject, message, onComplete) {
        ajax(true, "php/email/sendEmail.php", {prep: prep, organization: organization, subject: subject, message: message}, onComplete);
    }
}

export let php = new _php();

function ajax(async, url, data, onComplete) {
    if(php.page != null) {
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

