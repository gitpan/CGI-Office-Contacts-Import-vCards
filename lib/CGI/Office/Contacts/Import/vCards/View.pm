package CGI::Office::Contacts::Import::vCards::View;

use CGI::Office::Contacts::Import::vCards::View::vCards;
use CGI::Office::Contacts::View::Person;

use Moose;

extends 'CGI::Office::Contacts::View::Base';

# Warning: import is a reserved word, so we use viewer.
# Error msg: Can't use string ("CGI::Office::Contacts::Import::v") as a HASH ref...

has person => (is => 'rw', isa => 'CGI::Office::Contacts::View::Person');
has viewer => (is => 'rw', isa => 'CGI::Office::Contacts::Import::vCards::View::vCards');

use namespace::autoclean;

our $VERSION = '1.01';

# -----------------------------------------------

sub BUILD
{
	my($self) = @_;

	$self -> person(CGI::Office::Contacts::View::Person -> new
	(
		config    => $self -> config,
		db        => $self -> db,
		logger    => $self -> logger,
		session   => $self -> session,
		tmpl_path => $self -> tmpl_path,
	) );

	$self -> viewer(CGI::Office::Contacts::Import::vCards::View::vCards -> new
	(
		config    => $self -> config,
		db        => $self -> db,
		logger    => $self -> logger,
		session   => $self -> session,
		tmpl_path => $self -> tmpl_path,
	) );

}	# End of BUILD.

# --------------------------------------------------

__PACKAGE__ -> meta -> make_immutable;

1;
