$( document ).ready(function() {
    if($("#erroCodigo").attr("show") == "true"){
        $('#erroCodigo').modal('show'); 
        $(this).val("")
    }
    $(".codigoMesa-input").on('input',function(e){
        console.log($( this ).val().length)
        if($( this ).val().length == 5){
            $( "#formulario" ).submit()
            //$(".codigoMesa-value").text($(this).val())
        }
    });
});  
if ( window.history.replaceState ) {
    window.history.replaceState( null, null, window.location.href );
} 