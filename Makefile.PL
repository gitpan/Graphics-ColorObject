#!perl

	use ExtUtils::MakeMaker;

WriteMakefile (
	NAME		=>	"Graphics::ColorObject",
	VERSION		=>	"0.3a2",
	AUTHOR		=>	"areibens\@cpan.org",
	ABSTRACT	=>	"Color Object",
	dist		=>	{
		ZIP		=>	"zip ",
		ZIPFLAGS	=>	" -v -o -r -9 ",
		COMPRESS	=>	"gzip -9 -f ",
	},
	MAN1PODS	=>	{},
	MAN3PODS	=>	{},
	BINARY_LOCATION	=>  "Graphics-ColorObject-0.3a2-ppd.tar.gz",
);

sub MY::postamble
{
    my $self = shift;
    return <<"EOT";

ppdist: all ppd pm_to_blib
	tar zcvf Graphics-ColorObject-0.3a2-ppd.tar.gz blib
	\$(MV) Graphics-ColorObject.ppd Graphics-ColorObject-0.3a2.ppd

distme: all dist ppd ppdist

EOT
}

exit;

__END__
