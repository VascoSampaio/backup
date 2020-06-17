$( document ).ready(function() {
    $(".minus").click(function() {
        console.log("minus")
        if(parseInt($(".input-qnt").val()) > 1)
            $(".input-qnt").val(parseInt($(".input-qnt").val()) - 1)
    });
    $(".plus").click(function() {
        $(".input-qnt").val(parseInt($(".input-qnt").val()) + 1)
        $(".input-qnt").attr("value", parseInt($(".input-qnt").val()))
    }); 
    $('input[type=radio]').change(function() {
        $("input").attr("disabled", false);
        $(".pedir-btn").css("opacity", "1") 
    }); 
 

    if($('input[type=radio]').length == 0){
        $("input").attr("disabled", false); 
        $(".pedir-btn").css("opacity", "1")
    }
    

    $( "#pedido-form" ).submit(function( event ) {
        //event.preventDefault();
        var data = $("#pedido-form :input:not('.input-qnt')").serializeArray();
        
        var object = {};
        var options = [];

        for(var i = 0; i < data.length; i++){
            options.push(data[i])
        }
        object['id'] = $("#pedido-form").attr("artigo-id")
        object['qnt'] = parseInt($(".input-qnt").val())
        object['options'] = options;


        value_or_null = (document.cookie.match(/^(?:.*;)?\s*pedidos\s*=\s*([^;]+)(?:.*)?$/)||[,null])[1]
        
        //Se já existir cookie
        if(value_or_null != null && document.cookie.indexOf('pedidos=') != -1){
            var values = $.parseJSON(value_or_null)
            
            values.artigos.push(object)
            console.log(values) 
            
            document.cookie = "pedidos=" + JSON.stringify(values)
        }
        //Caso Contrário
        else{
            var obj = {}
            obj["artigos"] = [object]
            document.cookie = "pedidos=" + JSON.stringify(obj)
        }
        console.log(document.cookie)

        //window.location.replace($("#pedido-form".attr("action")));
    });
}); 

