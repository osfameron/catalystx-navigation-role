use strict;
use warnings;
use inc::Module::Install;

name        'CatalystX::Navigation';
all_from    'lib/CatalystX/Navigation.pm';

requires 'Catalyst';
requires 'Catalyst::Plugin::Authentication';
requires 'Catalyst::ActionRole::ACL';

test_requires 'Catalyst::View::TT';

license     'perl';
author      'osfameron';

auto_install;
WriteAll;
