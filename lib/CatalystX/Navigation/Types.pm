package CatalystX::Navigation::Types;

use MooseX::Types -declare => [
    qw/ ARCxNavigation 
        MyC
        MyCController
        MyCAction
        MyCActionChain
        MyCxNavigation
    /
    ];

use MooseX::Types::Moose qw/ ArrayRef Str HashRef /;

subtype MyC,
    as class_type('Catalyst');
subtype MyCController, 
    as class_type('Catalyst::Controller');
subtype MyCAction, 
    as class_type('Catalyst::Action');
subtype MyCActionChain, 
    as class_type('Catalyst::ActionChain');
subtype MyCxNavigation, 
    as class_type('CatalystX::Navigation');

subtype ARCxNavigation,
    as ArrayRef['CatalystX::Navigation'];

1;
