$ ->
        $(".toggle").click ->
                $($(this).data("target")).toggle()
        $(window).resize ->
                if($(window).width() > 500)
                        $(".navbar-list.main").show()
                if($(window).width() <= 500)
                        $(".navbar-list.more").hide()
