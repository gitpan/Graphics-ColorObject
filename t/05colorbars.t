use Test::More tests => 392;
use Graphics::Color;
#require 'Color.pm';

foreach $s1 (&Graphics::Color::list_colorspaces())
{
	foreach $s2 (&Graphics::Color::list_colorspaces())
	{
		foreach $rgb (
					  [1, 1, 1],
					  [1, 1, 0],
					  [0, 1, 1],
					  [0, 1, 0],
					  [1, 0, 1],
					  [1, 0, 0],
					  [0, 0, 1],
					  [0, 0, 0]
					  )
		{
			$rgb = &Graphics::Color::_mult_m33_v3([[3/4,0,0],[0,3/4,0],[0,0,3/4]], $rgb);
			#&roundtrip_convert($rgb, $s1, $s2);
			ok( &roundtrip_convert($rgb, $s1, $s2), "$s1 -> $s2 -> $s1" );
		}
	}
}

sub roundtrip_convert
{
	my ($rgb, $s1, $s2) = @_;
	my ($c1, $c2, $c1_copy, $rgb_copy);

	eval '$c1 = Graphics::Color->new_RGB($rgb, space=>"NTSC")->as_'.$s1.'()';         # rgb -> s1
	eval '$c2 = Graphics::Color->new_'.$s1.'($c1, space=>"NTSC")->as_'.$s2.'()';      # s1 -> $s2
	eval '$c1_copy = Graphics::Color->new_'.$s2.'($c2, space=>"NTSC")->as_'.$s1.'()'; # s2 -> $s1
	eval '$rgb_copy = Graphics::Color->new_'.$s2.'($c2, space=>"NTSC")->as_RGB()';    # s2 -> rgb
	my $result = (&Graphics::Color::_delta_v3( $rgb, $rgb_copy ) < 0.000005);
	#(&Graphics::Color::_delta_v3( $c1, $c1_copy ) < 0.001 * ($c1->[0]+$c1->[1]+$c1->[3]));

	#print STDERR "$s1 -> $s2 -> $s1 : ", ($result  ? 'ok' : 'not ok'), "\n";
	if (! $result)
	{
		print STDERR "[ $c1->[0], $c1->[1], $c1->[2] ] -> ";
		print STDERR "[ $c2->[0], $c2->[1], $c2->[2] ] -> ";
		print STDERR "[ $c1_copy->[0], $c1_copy->[1], $c1_copy->[2] ]";
		print STDERR "\n";
	}

	return $result;
}
