$( document ).ready(function() {
    console.log("teste")
    $(".sub-categoria-titulo button").click(function() {

        var value = $(this).attr("aria-expanded")
        $(".sub-categoria-titulo button").each(function( index ) {

            $(this).css("font-weight","normal");
            $(this).find(".fa-angle-down").hide()
            $(this).find(".fa-angle-right").show()
            $(this).attr("aria-expanded", "false");


            $(this).parent().parent().parent().find(".item-holder").each(function( index ) {
                $(this).children("a").css("font-weight","normal");
                
            });
        });
        if(value == "false"){
            $(this).css("font-weight","Bold");
            $(this).find(".fa-angle-down").show()
            $(this).find(".fa-angle-right").hide()

            $(this).parent().parent().parent().find(".item-holder").each(function( index ) {
                $(this).children("a").css("font-weight","Bold");
            });
        }else{
            $(this).css("font-weight","normal");
            $(this).find(".fa-angle-down").hide()
            $(this).find(".fa-angle-right").show()
            $(this).parent().parent().parent().find(".item-holder").each(function( index ) {
                $(this).children("a").css("font-weight","normal");
            });

        }
        
            
    });
}); 