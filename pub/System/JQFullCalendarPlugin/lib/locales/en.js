FullCalendar.globalLocales.push(function () {
  'use strict';

  var en = {
    code: 'en',
    week: {
      dow: 1, // Monday is the first day of the week.
      doy: 4, // The week that contains Jan 4th is the first week of the year.
    },
    buttonText: {
      prev: 'Previous',
      next: 'Next',
      today: 'Today',
      year: 'Year',
      month: 'Month',
      week: 'Week',
      day: 'Day',
      list: 'List',
    },
    weekTextLong: 'Week',
    allDayText: 'All day',
    buttonHints: {
      prev: 'Previous $0',
      next: 'Next $0',
      today: 'This $0',
    },
    viewHint: '$0 view',
    navLinkHint: 'Go to $0',
    moreLinkHint(eventCnt) {
      return `Show ${eventCnt} more event${eventCnt === 1 ? '' : 's'}`
    },
  };

  return en;

}());
