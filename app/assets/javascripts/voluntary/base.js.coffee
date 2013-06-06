$(document).ready ->
  $("a[rel=popover]").popover()
  $(".tooltip").tooltip()
  $("a[rel=tooltip]").tooltip() 

  $( '.accordions' ).each (k, v) ->
    $(v).accordion({ autoHeight: false });
    
  $('.tabs').each (k, v) ->
    $(v).tabs({ autoHeight: false });
    
  $('form').on 'click', '.remove_fields', (event) ->
    #$(this).prev('input[type=hidden]').val('1')
    $(this).closest('fieldset').remove()
    event.preventDefault()

  $('form').on 'click', '.add_fields', (event) ->
    time = new Date().getTime()
    regexp = new RegExp($(this).data('id'), 'g')
    target = $(this)
    
    if $(this).data('target')
      target = $('#' + $(this).data('target'))
      
    target.before($(this).data('fields').replace(regexp, time))
    event.preventDefault()
  
  $('input[data-autocomplete]').each (k, v) ->
    $(v).autocomplete({
      source: $(this).attr('data-autocomplete'),
      select: (event, ui) ->
        $(this).val(ui.item.value)
        
        if ($(this).attr('id_element'))
          $($(this).attr('id_element')).val(ui.item.id)
        
        return false;
    });
    
  $( ".datepicker" ).each (k, v) ->
    $(v).datepicker({ dateFormat: "yy-mm-dd", changeYear: true, yearRange: "c-100:c+10" });