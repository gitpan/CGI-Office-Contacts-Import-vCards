#!/usr/bin/perl
#
# Name:
# vards.cgi.
#
# Note:
# Need use lib here because CGI scripts don't have access to
# the PerlSwitches used in Apache's httpd.conf.
# Also, it saves having to install the module repeatedly during testing.

use lib '/home/ron/perl.modules/CGI-Office-Contacts/lib';
use lib '/home/ron/perl.modules/CGI-Office-Contacts-Import-vCards/lib';
use strict;
use warnings;

use CGI;
use CGI::Application::Dispatch;

# ---------------------

my($cgi) = CGI -> new;

CGI::Application::Dispatch -> dispatch
(
 args_to_new => {QUERY => $cgi},
 prefix      => 'CGI::Office::Contacts::Import::vCards::Controller',
 table       =>
 [
  ''         => {app => 'Initialize', rm => 'display'},
  ':app'     => {rm => 'display'},
  ':app/:rm' => {},
 ],
);
