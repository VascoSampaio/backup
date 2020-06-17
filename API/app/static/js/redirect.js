$( document ).ready(function() {
    //console.log($("#menuUrl").attr("menuUrl"))
    setInterval(myTimer, 4000);
    function myTimer() {
        window.location.href = $("#menuUrl").attr("menuUrl"); 
    }
    
});  