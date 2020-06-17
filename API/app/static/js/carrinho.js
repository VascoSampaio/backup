$( document ).ready(function() {
    $(".plus").click(function() {
        var orderItemId = $(this).attr('orderitemid')
        console.log(orderItemId)
    });
    $(".pedir-btn").click(function() {
        window.location.href = $("#pagamento").attr("pagamentoUrl");
    });

});    

if ( window.history.replaceState ) {
    window.history.replaceState( null, null, window.location.href );
} 