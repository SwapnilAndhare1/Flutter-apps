$(document).ready(function () {
    $("#btnAddStudent").click(function () {
        function getStudentData() {
            let student = {
                FullName: $("#FullName").val(),
                Address: $("#Address").val(),
            };
            return student;
        }
        function storeDataToLocalStorage() {
            if (!localStorage.getItem("student")) {
                localStorage.setItem("student", JSON.stringify(getStudentData()));
            } else {
                localStorage.removeItem("student");
                localStorage.setItem("student", JSON.stringify(getStudentData()));
            }
        }
        storeDataToLocalStorage();
        window.location.href="display.html"
    });
});