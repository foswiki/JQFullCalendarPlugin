# Plugin for Foswiki - The Free and Open Source Wiki, http://foswiki.org/
#
# Copyright (C) 2009-2022 Michael Daum, http://michaeldaumconsulting.com
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version. For
# more details read LICENSE in the root of this distribution.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
#
package Foswiki::Plugins::JQFullCalendarPlugin;
use strict;
use warnings;

our $VERSION = '3.01';
our $RELEASE = '23 Aug 2022';
our $SHORTDESCRIPTION = '<nop>FullCalendar widget for Foswiki';
our $NO_PREFS_IN_TOPIC = 1;

use Foswiki::Plugins::JQueryPlugin ();
use Foswiki::Plugins::JQFullCalendarPlugin::FULLCALENDAR ();

sub initPlugin {
  my ($topic, $web, $user) = @_;

  Foswiki::Plugins::JQueryPlugin::registerPlugin('FullCalendar', 'Foswiki::Plugins::JQFullCalendarPlugin::FULLCALENDAR');

  Foswiki::Func::registerTagHandler('FULLCALENDAR', sub {
    return getCore(shift)->FULLCALENDAR(@_);
  });

  return 1;
}

sub getCore {
  return Foswiki::Plugins::JQueryPlugin::createPlugin("FullCalendar");
}

1;
