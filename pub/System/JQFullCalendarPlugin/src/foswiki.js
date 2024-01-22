/*
 * jqFullCalendar foswiki plugin 3.04
 *
 * Copyright (c) 2022-2024 Michael Daum http://michaeldaumconsulting.com
 *
 * Licensed under the GPL license http://www.gnu.org/licenses/gpl.html
 *
 */
"use strict";

jQuery(function($) {
  function getOrigin() {
    return (new URLSearchParams(window.location.search)).get("origin");
  }

  var defaults = {
    initialView: 'dayGridMonth',
    weekNumbers: true,
    nowIndicator: true,
    scrollTime: '08:00:00',
    scrollTimeReset: false,
    navLinks: true,
    businessHours: {
      daysOfWeek: [ 1, 2, 3, 4, 5 ], 
      startTime: '08:00', 
      endTime: '20:00'
    },
    customButtons: {
      close: {
        text: "Close",
        click: function() {
          window.location.assign(getOrigin());
        }
      },
      reload: {
	text: "Reload",
	click: function() {
	  var calendar = $(this).parents(".jqFullCalendar:first").data("calendar");
	  calendar.refetchEvents();
        }
      }
    },
    headerToolbar: {
      start: 'prev,next,today reload',
      center: 'title',
      end: 'dayGridMonth,timeGridWeek,timeGridDay,listWeek' + (getOrigin() ? ' close' : '')
    },
    eventClick: function(info) {
      var eventObj = info.event;

      if (eventObj.url) {
        window.open(eventObj.url, "_blank");
        info.jsEvent.preventDefault(); 
      }
    },
    loading: function(flag) {
      if (flag) {
        $.blockUI({message:""});
      } else {
        $.unblockUI();
      }
    }
  };

  $(".jqFullCalendar").livequery(function() {
    var $this = $(this), 
	lang = $("html").attr("lang") || "en",
        opts = $.extend({}, defaults, {locale: lang}, $this.data()),
        calendar;

     delete opts.validationKey;
     delete opts.web;
     calendar = new FullCalendar.Calendar(this, opts);
     calendar.render();

     $this.data("calendar", calendar);
  });
});
