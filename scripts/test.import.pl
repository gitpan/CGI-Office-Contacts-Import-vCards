#!/usr/bin/perl

use strict;
use warnings;

use CGI::Office::Contacts::Import::vCards::View;

# -----------------------------------------------

my($v) = CGI::Office::Contacts::Import::vCards::View -> new
(
	config    => 'config',
	db        => 'db',
	logger    => 'logger',
	session   => 'session',
	tmpl_path => '',
);
