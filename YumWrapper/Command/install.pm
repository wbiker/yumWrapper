package YumWrapper::Command::install;
use YumWrapper -command;

use feature 'say';

sub abstract {
	return "installs a program case insensitive";
}

sub usage_desc {
	return "Installes a program, case insensitive. That means it search for the right name and installs it if found.";
}

sub opt_spec {
	my ($self, $opt, $args) = @_;
	
	return (
		[ "name|n=s", "Name of the program to be installed."]
	);
}

sub validate_args {
	my ($self, $opt, $args) = @_;
	
	$self->usage_error("Program name must be set") unless $opt->{name};
}

sub execute {
	my ($self, $opt, $args) = @_;
	
	# first search for the program name
	my $yumout = `yum search $opt->{name}`;
	
	say $yumout;
}
1;