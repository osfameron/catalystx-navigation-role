use MooseX::Declare;

class CatalystX::Navigation {
    has action => (
        isa => 'Catalyst::Action',
        is  => 'rw',
    );

    has order => (
        isa => 'Int',
        is  => 'rw',
    );
}

1;
