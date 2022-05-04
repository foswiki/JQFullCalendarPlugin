# Plugin for Foswiki - The Free and Open Source Wiki, http://foswiki.org/
#
# Copyright (C) 2006-2022 Michael Daum, http://michaeldaumconsulting.com
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
# GNU General Public License for more details, published at
# http://www.gnu.org/copyleft/gpl.html

package Foswiki::Plugins::JQFullCalendarPlugin::FULLCALENDAR;
use strict;
use warnings;

use Foswiki::Validation ();
use Foswiki::Plugins ();
use JSON ();
use Foswiki::Plugins::JQueryPlugin::Plugin();
our @ISA = qw( Foswiki::Plugins::JQueryPlugin::Plugin );

sub new {
  my $class = shift;
  my $session = shift || $Foswiki::Plugins::SESSION;

  my $this = bless(
    $class->SUPER::new(
      $session,
      name => 'FullCalendar',
      version => '5.10.1',
      author => 'Adam Shaw',
      homepage => 'http://fullcalendar.io/',
      puburl => '%PUBURLPATH%/%SYSTEMWEB%/JQFullCalendarPlugin',
      css => ['build/pkg.css'],
      javascript => ['build/pkg.js'],
      dependencies => ['blockui'],
      #dependencies => ['ui', 'moment'],
    ),
    $class
  );

  $this->{_session} = $session;
  return $this;
}

sub DESTROY {
  my $this = shift;
  undef $this->{_json};
  undef $this->{_session};
}

sub init {
  my $this = shift;

  return unless $this->SUPER::init();

  my $langTag = $this->{_session}->i18n->language() // 'en';
  my $langPath = $Foswiki::cfg{SystemWebName} . '/JQFullCalendarPlugin/lib/locales/' . $langTag . '.js';

  my $langFile = $Foswiki::cfg{PubDir} . '/' . $langPath;
  #print STDERR "langFile=$langFile\n";
  if (-f $langFile) {
    Foswiki::Func::addToZone("script", "JQFULLCALENDARPLUGIN::LANG", <<"HERE", "JQUERYPLUGIN::FULLCALENDAR");
<script src='$Foswiki::cfg{PubUrlPath}/$langPath'></script>
HERE
  } else {
    print STDERR "no translations for '$langTag'\n";
  }
}

sub FULLCALENDAR {
  my ($this, $params, $topic, $web) = @_;

  my $id = $params->{_DEFAULT} // $params->{id};
  $id = 'fullCalendar' . Foswiki::Plugins::JQueryPlugin::Plugins::getRandom() unless defined $id;

  my @class = ();
  push @class, "jqFullCalendar";
  push @class, split(/\s*,\*s/, $params->{class}) if $params->{class};

  my $nonce = $this->getValidationKey();
  $params->{"validation_key"} = "?".$nonce if $nonce;

  return "<div class='" . join(" ", @class) . "' " . $this->toHtml5Data($params) . " id='$id'></div>";
}

sub getValidationKey {
  my $this = shift;

  my $request  = $this->{_session}{request};
  my $useStrikeOne = ($Foswiki::cfg{Validation}{Method} eq 'strikeone');
  my $cgis = $this->{_session}->getCGISession();
  return unless $cgis;

  my $context = $request->url( -full => 1, -path => 1, -query => 1 ) . time();
  return Foswiki::Validation::generateValidationKey($cgis, $context, $useStrikeOne);
}

sub toHtml5Data {
  my ($this, $params) = @_;

  my @data = ();
  foreach my $key (sort keys %$params) {
    next if $key =~ /^_/;
    my $val = $params->{$key};
    $key =~ s/_/-/g;

    if (ref($val)) {
      $val = $this->json->encode($val);
    } else {
      $val = Foswiki::entityEncode($val);
    }

    push @data, "data-$key='$val'";
  }

  return join(" ", @data);
}

sub json {
  my $this = shift;

  unless (defined $this->{_json}) {
    $this->{_json} = JSON->new; 
  }

  return $this->{_json};
}

1;
