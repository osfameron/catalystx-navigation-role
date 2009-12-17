use strict;
use warnings;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME                => 'CatalystX::Navigation::Role',
    AUTHOR              => q{osfameron <osfameron@cpan.org>},
    VERSION_FROM        => 'lib/CatalystX/Navigation/Role.pm',
    ABSTRACT_FROM       => 'lib/CatalystX/Navigation/Role.pm',
    ($ExtUtils::MakeMaker::VERSION >= 6.3002
      ? ('LICENSE'=> 'perl')
      : ()),
    PL_FILES            => {},
    PREREQ_PM => {
        'Test::More' => 0,
    },
    dist                => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    clean               => { FILES => 'CatalystX-Navigation-Role-*' },
);
