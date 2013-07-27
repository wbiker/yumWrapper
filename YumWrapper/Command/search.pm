package YumWrapper::Command::search;
use YumWrapper -command;

sub abstract {
	return "search for  a keyword";
}

sub usage_desc {
	return "Searched for an keyword";
}

sub opt_spec {
	my ($self, $opt, $args) = @_;
	
	return (
		[ "search|s=s", "key word that is used to search"]
	);
}

sub validate_args {
	my ($self, $opt, $args) = @_;
	
	$self->usage_error("search must be set to a keyword") unless $opt->{search};
}

sub execute {
	my ($self, $opt, $args) = @_;
	
	
}
1;