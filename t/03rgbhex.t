use Test::More tests => 3;
use Graphics::Color;

ok( Graphics::Color::_delta_v3( 
    Graphics::Color->new_RGBhex('#FFFFFF', space => 'Apple RGB')->as_XYZ(),
    [0.950466, 0.999999, 1.088969] 
) < 0.00005 );

ok( Graphics::Color::_delta_v3( 
    Graphics::Color->new_RGBhex('#FF00FF', space => 'Apple RGB')->as_XYZ(),
    [0.634215, 0.327965, 0.947785] 
) < 0.00005 );

ok( Graphics::Color->new_RGBhex('#A1B2C3', space => 'Apple RGB')->as_RGBhex() eq 'A1B2C3' );
