use Test::More tests => 2;
use Graphics::Color;

ok( Graphics::Color::_delta_v3( 
    Graphics::Color->new_RGB([1,1,1], space => 'Apple RGB')->as_XYZ(),
    [0.950466, 0.999999, 1.088969] 
) < 0.00005 );

ok( Graphics::Color::_delta_v3( 
    Graphics::Color->new_RGB([1,0,1], space => 'Apple RGB')->as_XYZ(),
    [0.634215, 0.327965, 0.947785] 
) < 0.00005 );
