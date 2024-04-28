$(document).ready(function () {
    getData();
});
function getData() {
    let localStorageData = localStorage.getItem("student");
    let studentObj = JSON.parse(localStorageData);
    console.log(studentObj);
    $("#FullName").text(studentObj.FullName);
    $("#Address").text(studentObj.Address);
}