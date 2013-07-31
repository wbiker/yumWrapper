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
	
	# parse output and look for the name
	my @lines = split('\n', $yumout);
	
	my $headerfound;
	my @programs;
	for my $line (@lines) {
		if($line =~ /\A=+/) {
			# header found. the next lines are names of programs
			$headerfound = 1;
		}
		elsif($headerfound) {
			# header was found in one of the last lines. Look for program names
			if($headerfound && $line =~ /\A\Z/)  {
				# empty line is end of the program list
				say "found end";
				last;
			}
			elsif($line =~ /\A(.*?)\s:/) {
				say "found '$1' in $line";
				push(@programs, $1);
			}
			
		}
	} # for my
}
1;