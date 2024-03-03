$(document).ready(function () {
    $("#btnAddStudent").click(function () {
        function getStudentData() {
            
            let student = {
                firstName: $("#firstName").val(),
                lastName: $("#lastName").val(),
                gender: $("input[name='gender']:checked").val(),
                age: $("#age").val(),
                Result:"",

            };
            if(($("#age").val())>=18){
                Object.assign(student, {Result: "eligible for voting"});
                
            }else{
                Object.assign(student, {Result: "not eligible for voting"});
            }
            

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