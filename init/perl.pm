if (! defined $ENV{MODULE_VERSION} ) {
	$ENV{"MODULE_VERSION_STACK"}="3.2.10";
	$ENV{"MODULE_VERSION"}="3.2.10";
} else {
	$ENV{"MODULE_VERSION_STACK"}=$ENV{"MODULE_VERSION"};
}

sub module {
	local ($exec_prefix);
	$exec_prefix = "/usr/share/modules/".$ENV{"MODULE_VERSION"};
	eval `$exec_prefix/bin/modulecmd perl @_`;

}

$ENV{"MODULESHOME"} = "/usr/share/modules";

if (! defined $ENV{"MODULEPATH"} ) {
	open(IN, "$ENV{'MODULESHOME'}/init/.modulespath") || die "cannot open '.modulespath' file: $!\n";
	$ENV{"MODULEPATH"} = join(":", grep(/\S/, map { s/^\s*//g; s/[\s#].*$//g; $_ } <IN>));
	close IN;
}

if (! defined $ENV{"LOADEDMODULES"} ) {
	$ENV{"LOADEDMODULES"} = "";
}

1;
