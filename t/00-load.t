#!perl

use Test::More tests => 1;

BEGIN {
    use_ok( 'CatalystX::Navigation::Role' );
}

diag( "Testing CatalystX::Navigation::Role $Catalyst::Navigation::Role::VERSION, Perl $], $^X" );
