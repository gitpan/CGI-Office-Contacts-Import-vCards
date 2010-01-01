use Module::Build;

Module::Build -> new
(
 module_name    => 'CGI::Office::Contacts::Import::vCards',
 license        => 'artistic',
 dist_abstract  => 'Import vCards for use by CGI::Office::Contacts',
 dist_author    => 'Ron Savage <ron@savage.net.au>',
 build_requires =>
 {
	 Test::More => 0,
	 Test::Pod  => 0,
 },
 requires =>
 {
	 CGI::Office::Contacts   => 0,
	 Text::DoubleMetaphone   => 0,
	 Text::GenderFromName    => 0,
	 Text::vFile::toXML      => 0, # For importing vCards.
	 XML::Handler::YAWriter  => 0, # For xmlpretty.
	 XML::SAX::Base          => 0,
	 XML::SAX::ParserFactory => 0,
 },
) -> create_build_script();
