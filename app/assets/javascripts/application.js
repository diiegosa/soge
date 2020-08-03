// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require jquery
//= require turbolinks
//= require popper
//= require bootstrap
//= require admin-lte/dist/js/adminlte
//= require bootstrap-select/dist/js/bootstrap-select.min.js
//= require plugins/jquery.maskMoney.min
//= require toastr
//= require moment
//= require_tree .


// Corrigi o resize do active admin executado pelo turbolinks
document.addEventListener('turbolinks:load', () => $(window).trigger('resize'));

// Active menu items
$(document).ready(function () {
  if(!JSON.parse(localStorage.getItem('sidebar_collapsed'))) { $('body').addClass('sidebar-collapse'); }

  $('a.nav-link[data-widget="pushmenu"]').on("click", function(){
    localStorage.setItem('sidebar_collapsed', $('body').hasClass('sidebar-collapse'));
  });
  
  var url = window.location;
  // for sidebar menu entirely but not cover treeview
  $('ul.sidebar-menu a').filter(function () {
    return this.href == url;
  }).parent().addClass('active');

  // for treeview
  $('ul.treeview-menu a').filter(function () {
    return this.href == url;
  }).parentsUntil(".sidebar-menu > .treeview-menu").addClass('active');

  $('#reservationtime').daterangepicker({
    timePicker: true,
    timePicker24Hour: true,
    //autoUpdateInput: false,
    locale: {
      format: 'DD/MM/YYYY HH:mm',
      locale: 'pt-br',
      applyLabel: "Confirmar",
      cancelLabel: "Cancelar",
      separator: " - ",
      fromLabel: "De",
      toLabel: "Até",
    }
  })

  $('#reservationdate').daterangepicker({
    timePicker: false,
    timePicker24Hour: false,
    drops: 'up', 
    //autoUpdateInput: false,
    locale: {
      format: 'DD/MM/YYYY',
      locale: 'pt-br',
      applyLabel: "Confirmar",
      cancelLabel: "Cancelar",
      separator: " - ",
      fromLabel: "De",
      toLabel: "Até",
    }
  })

});

$(document).ready(function () {
  $(function () {
    $('.currency').maskMoney({
      thousands: '.',
      decimal: ',',
      prefix: 'R$ '
    }).maskMoney('mask')
  });

  $('.currency').each(function () {
    if (!$(this).val().match(/,/g)) {
      $(this).val($(this).val().replace(".", ","));
    }
  })
})
