package CGI::Office::Contacts::Import::vCards;

use strict;
use warnings;

our $VERSION = '1.01';

# -----------------------------------------------

1;

=head1 NAME

C<CGI::Office::Contacts::Import::vCards> - Import vCards for use by CGI::Office::Contacts

=head1 Synopsis

The scripts discussed here, I<vcards.cgi> and I<vcards>, are shipped with this module.

A classic CGI script, I<vcards.cgi>:

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

A fancy FCGI script, I<vcards>:

	use strict;
	use warnings;

	use CGI::Application::Dispatch;
	use CGI::Fast;
	use FCGI::ProcManager;

	# ---------------------

	my($proc_manager) = FCGI::ProcManager -> new({processes => 2});

	$proc_manager -> pm_manage;

	my($cgi);

	while ($cgi = CGI::Fast -> new)
	{
		$proc_manager -> pm_pre_dispatch();

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

		$proc_manager -> pm_post_dispatch;
	}

=head1 Description

C<CGI::Office::Contacts::Import::vCards> implements importing vCards for use by C<CGI::Office::Contacts>.

C<CGI::Office::Contacts::Import::vCards> uses C<Moose>.

=head1 Distributions

This module is available as a Unix-style distro (*.tgz).

See http://savage.net.au/Perl-modules/html/installing-a-module.html for
help on unpacking and installing distros.

=head1 Installation Pre-requisites

The primary pre-requisite is C<CGI::Office::Contacts>. You should study the documentation for that
module before proceeding.

=head1 Installing the module

Note: Neither I<Build.PL> nor I<Makefile.PL> refer to C<FCGI::ProcManager>.
If you are only going to use the classic CGI script 'contacts.cgi',
you don't need C<FCGI::ProcManager>.

Install C<CGI::Office::Contacts::Import::vCards> as you would for any C<Perl> module:

Run I<cpan>: shell>sudo cpan CGI::Office::Contacts::Import::vCards

or unpack the distro, and then either:

	perl Build.PL
	./Build
	./Build test
	sudo ./Build install

or:

	perl Makefile.PL
	make (or dmake)
	make test
	make install

Either way, you'll need to install all the other files which are shipped in the distro.

=head2 Install the C<HTML::Template> files.

Copy the distro's htdocs/assets/ directory to your web server's doc root.

Specifically, my doc root is /var/www/, so I end up with /var/www/assets/.

=head2 Install the trivial CGI script

Copy the distro's httpd/cgi-bin/office/ directory to your web server's cgi-bin/ directory,
and make I<vacrds.cgi> executable.

So, I end up with /usr/lib/cgi-bin/office/import/vcards.cgi.

Now I can run http://127.0.0.1/cgi-bin/office/import/vcards.cgi.

=head2 Install the fancy FCGI script (optional)

Copy the distro's htdocs/office/ directory to your web server's doc root,
and make I<vcards> executable.

So, I end up with /var/www/office/import/vcards.

Now I can run http://127.0.0.1/office/import/vcards.

For C<FCGID>, see http://fastcgi.coremail.cn/.

C<FCGID> is a replacement for the older C<FastCGI>. For C<FastCGI>, see http://www.fastcgi.com/drupal/.

=head2 Start testing

Point your broswer at http://127.0.0.1/cgi-bin/import/vcards.cgi (trivial script), or
http://127.0.0.1/office/import/vcards (fancy script).

=head1 FAQ

=over 4

=item Does the import code guess any values?

Yes, both gender and title are derived from the data, rather than being just pieces
of data. This means neither of these 2 values are guaranteed to be correct.

=back

=head1 Support

Log bug reports with RT.

The mailing list details are:

	Mail list: cgi-office@X
	Help address: cgi-office-help@X
	Subscription address: cgi-office-subscribe@X
	Unsubscription address: cgi-office-unsubscribe@X

where X is as per my email address at the bottom of my home page (below).

On-line help for ezmlm: http://www.ezmlm.org/manual/

=head1 Author

C<CGI::Office::Contacts::Import::vCards> was written by Ron Savage I<E<lt>ron@savage.net.auE<gt>> in 2009.

Home page: http://savage.net.au/index.html

=head1 Copyright

Australian copyright (c) 2009, Ron Savage. All rights reserved.

	All Programs of mine are 'OSI Certified Open Source Software';
	you can redistribute them and/or modify them under the terms of
	The Artistic License, a copy of which is available at:
	http://www.opensource.org/licenses/index.html

=cut
