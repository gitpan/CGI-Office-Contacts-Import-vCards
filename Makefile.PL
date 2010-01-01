use ExtUtils::MakeMaker;

# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# the contents of the Makefile that is written.

WriteMakefile
(
 ($] ge '5.005') ?
 (
  AUTHOR   => 'Ron Savage (ron@savage.net.au)',
  ABSTRACT => 'Import vCards for use by CGI::Office::Contacts',
 ) : (),
 clean =>
 {
	 FILES => 'blib/* Makefile MANIFEST CGI-Office-Contacts-Import-vCards*'
 },
 dist =>
 {
	 COMPRESS => 'gzip',
	 SUFFIX   => 'gz'
 },
 DISTNAME  => 'CGI-Office-Contacts-Import-vCards',
 NAME      => 'CGI::Office::Contacts::Import::vCards',
 PL_FILES  => {},
 PREREQ_PM =>
 {
	 CGI::Office::Contacts   => 0,
	 Text::DoubleMetaphone   => 0,
	 Text::GenderFromName    => 0,
	 Text::vFile::toXML      => 0, # For importing vCards.
	 XML::Handler::YAWriter  => 0, # For xmlpretty.
	 XML::SAX::Base          => 0,
	 XML::SAX::ParserFactory => 0,
 },
 VERSION_FROM	=> 'lib/CGI/Office/Contacts/Import/vCards.pm',
);
