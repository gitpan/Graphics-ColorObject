use Graphics::ColorObject;
use Image::Magick;

$img = Image::Magick->new;
($w, $h) = (400, 400);
$img->Set(size=>$w .'x'. $h);
$img->ReadImage('xc:black');

foreach my $x (0..$w-1)
{
	foreach my $y (0..$h-1)
	{
		$hx_old = '000000';
		foreach my $l (1..100)
		{
			$c = Graphics::ColorObject->new_Lab([100*($l/100),400*($x/$w-0.5), 400*(-$y/$h+0.5)], space=>'Adobe');
			#$c = Graphics::Color->new_xyY([($x/$w), ($y/$h), 0.4], space=>'WideGamut');
			#$c = Graphics::Color->new_XYZ([($x/$w), 0.8, ($y/$h)], space=>'Adobe');
			#$c = Graphics::Color->new_HSL([360*($x/$w), ($y/$h), 0.5], space=>'Adobe');
			#$c = Graphics::Color->new_LCHab([75, 100*($x/$w), 6.24*($y/$h)], space=>'Adobe');
			$hx = $c->as_RGBhex();
			last if ($hx eq '000000' && $hx_old ne '000000');
			$hx_old = $hx;
		}
		#if ($X++ % 50 == 0) { print $c->as_RGBhex(), "\n"; }
		$img->Set("pixel[$x, $y]" => '#'.$hx_old);
	}
}

$img->Write('test-lab.png');

1;
