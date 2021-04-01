import { page } from "../main.js";

page.ready(function (page) {
    var ui = new firebaseui.auth.AuthUI(firebase.auth());
    var uiConfig = {
        callbacks: {
            signInFailure: function (error) {
                // For merge conflicts, the error.code will be
                // 'firebaseui/anonymous-upgrade-merge-conflict'.
                if (error.code !== 'firebaseui/anonymous-upgrade-merge-conflict') {
                    return Promise.resolve();
                }
                // The credential the user tried to sign in with.
                var cred = error.credential;
                // Copy data from anonymous user to permanent user and delete anonymous
                // user.
                // ...
                // Finish sign-in after data is copied.
                return firebase.auth().signInWithCredential(cred);
            },
            signInSuccessWithAuthResult: function (authResult, redirectUrl) {
                var user = firebase.auth().currentUser;
                page.php.login(user.email, user.uid, user.displayName, function (data) {
                    console.log(data);
                    if (data == null) {
                        page.php.register(user.email, user.uid, user.displayName, function (data) {
                            page.navbar.update();
                            page.stopLoadingAnimation();
                        });
                    } else {
                        page.navbar.update();
                        page.stopLoadingAnimation();
                    }
                });
                // User successfully signed in.
                // Return type determines whether we continue the redirect automatically
                // or whether we leave that to developer to handle.
                return false;
            },
            uiShown: function () {
                // The widget is rendered.
                // Hide the loader.
                //document.getElementById('loader').style.display = 'none';
                page.stopLoadingAnimation();
            }
        },
        //signInSuccessUrl: 'https://localhost/hungersol/',
        signInOptions: [
            firebase.auth.EmailAuthProvider.PROVIDER_ID
        ]
    }

    ui.start('#firebaseui-auth-container', uiConfig);
});

$(document).ready(function () {
    firebase.initializeApp(firebaseConfig);
});

$('#exampleModal').on('shown.bs.modal', function () {
    $(document).off('focusin.modal');
});
