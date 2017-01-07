var cookieEnabled=(navigator.cookieEnabled)? true : false

if (typeof navigator.cookieEnabled=="undefined" && !cookieEnabled){ 
    document.cookie="testcookie"
    cookieEnabled=(document.cookie.indexOf("testcookie")!=-1)? true : false
}
 
 if (cookieEnabled == false) {
 alert("Sie müssen Cookies für diese Seite aktivieren, damit die Suche funktioniert.");
 }
