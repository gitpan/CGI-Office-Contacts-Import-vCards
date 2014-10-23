package CGI::Office::Contacts::Import::vCards::Util::Config;

use Moose;

extends 'CGI::Office::Contacts::Util::Config';

use namespace::autoclean;

our $VERSION = '1.00';

# -----------------------------------------------

sub BUILD
{
	my($self) = @_;
	my($name) = '.htoffice.import.vcards.conf';

	my($path);

	for (keys %INC)
	{
		next if ($_ !~ m|CGI/Office/Contacts/Import/vCards/Util/Config.pm|);

		($path = $INC{$_}) =~ s|Util/Config.pm|$name|;
	}

	$self -> init($path);

} # End of BUILD.

# --------------------------------------------------

__PACKAGE__ -> meta -> make_immutable;

1;
