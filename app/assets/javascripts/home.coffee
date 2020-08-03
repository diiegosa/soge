# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


$ ->
    form_password_update = $("form#form-password-update")

    form_password_update.on 'ajax:send', (event) ->
        form_password_update.find('.overlay').css({'opacity': 0.5, 'display': 'flex'});

    form_password_update.on 'ajax:complete', (event) ->
        form_password_update.find('.overlay').css({'opacity': 0.0, 'display': 'none'});

    form_password_update.on 'ajax:success', (event) ->
        data = event.originalEvent.detail.shift();
        toastr.success("Sua senha foi alterada!");
        form_password_update.trigger("reset");
        $("#modal-password-update").modal('hide');

    form_password_update.on 'ajax:error', (event) ->
        data = event.originalEvent.detail.shift()
        
        for error in data
            do ->
                toastr.error(error);
        
