package CGI::Office::Contacts::Import::vCards::Controller::Initialize;

use base 'CGI::Office::Contacts::Import::vCards::Controller';
use strict;
use warnings;

# We don't use Moose because we isa CGI::Application.

our $VERSION = '1.01';

# -----------------------------------------------

sub about
{
	my($self, $user_id) = @_;

	$self -> log(debug => 'Entered about');

	my($config)   = $self -> param('config');
	my($template) = $self -> load_tmpl('table.even.odd.tmpl', loop_context_vars => 1);
	my($user)     = $user_id ? $self -> param('db') -> person -> get_person($user_id, $user_id) : [{name => 'N/A'}];
	$user         = $$user[0]{'name'} ? $$user[0]{'name'} : 'No-one is logged on';

	my(@tr);

	push @tr, {left_td => 'Program', right_td => "$$config{'program_name'} $$config{'program_version'}"};
	push @tr, {left_td => 'Author',  right_td => $$config{'program_author'} };
	push @tr, {left_td => 'Help',    right_td => qq|<a href="$$config{'program_faq_url'}">FAQ</a>|};
	#push @tr, {left_td => 'Current user', right_td => $user_id};

	$template -> param(tr_loop => \@tr);

	# Make YUI happy by turning the HTML into 1 long line.

	$template = $template -> output;
	$template =~ s/\n//g;

	return $template;

} # End of about.

# -----------------------------------------------

sub build_head_init
{
	my($self) = @_;

	$self -> log(debug => 'Entered build_head_init');

	my($about)              = $self -> about;
	my($import_vcards_form) = $self -> param('view') -> viewer -> build_import_vcards_form;

	# These things are called by YAHOO.util.Event.onDOMReady(init).

	my($head_init) = <<EJS;
import_tab = new YAHOO.widget.Tab
({
	label: "Import",
	content: '$import_vcards_form',
	active: true
});
tab_set.addTab(import_tab);
import_tab.addListener('click', make_vfile_name_focus);

about_tab = new YAHOO.widget.Tab
({
	label: "About",
	content: '$about'
});
tab_set.addTab(about_tab);

// Add tab set to document.

tab_set.appendTo("container");

make_vfile_name_focus();
EJS

	return $head_init;

} # End of build_head_init.

# -----------------------------------------------

sub build_head_js
{
	my($self) = @_;

	$self -> log(debug => 'Entered build_head_js');

	my($import_vcards_js) = $self -> param('view') -> viewer -> build_import_vcards_js;

	# These things are being declared globally within the web page.

	my($head_js) = <<EJS;
$import_vcards_js

function make_vfile_name_focus(eve)
{
	document.import_vcards_form.vfile_name.focus();
}

var tab_set = new YAHOO.widget.TabView();

var about_tab;
var import_tab;
EJS

	return $head_js;

} # End of build_head_js.

# -----------------------------------------------

sub display
{
	my($self) = @_;

	$self -> log(debug => 'Entered display');

	# Generate the web page itself. This is not loaded by sub cgiapp_init(),
	# because, with AJAX, we only need it the first time the script is run.

	my($page) = $self -> load_tmpl('web.page.tmpl');

	$page -> param(head_init => $self -> build_head_init);
	$page -> param(head_js   => $self -> build_head_js);
	$page -> param(yui_url   => ${$self -> param('config')}{'yui_url'});

	return $page -> output;

} # End of display.

# -----------------------------------------------

1;
