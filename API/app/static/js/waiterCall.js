$( document ).ready(function() {
    $( "#callWaiter" ).unbind('click').bind('click', function (e) {
        $(".callWaiter.pedir-btn").show();
        $("#modalTitle").show();
        $(".messageInfo").hide()

        $('#waiterCall').modal('show');
        e.preventDefault();
        $( ".callWaiter.pedir-btn" ).unbind('click').bind('click', function (e) {
            e.preventDefault();
            var requestUrl = $("#siteRoot").val() + "/frontoffice/callWaiter/"
            
            $.ajax({
                type: "GET",
                url: requestUrl,
                dataType: "json",
                success: function (msg) {
                },
            }).done(function() {
            });
            
            $(".callWaiter.pedir-btn").hide();
            $("#modalTitle").hide();
            $(".messageInfo").show();       
        });
    });     
}); 