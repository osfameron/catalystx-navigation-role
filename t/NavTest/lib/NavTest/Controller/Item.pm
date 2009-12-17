package NavTest::Controller::Item;

use Moose;
BEGIN {
    extends 'Catalyst::Controller::ActionRole';
}
with 'CatalystX::Navigation::Role';

sub item :Chained('/') :PathPart('item') :CaptureArgs(0) 
    :Order(10)
{ 
    my ($self, $c) = @_;
    $self->add_nav($c,
        'item',
        'supervise'
    );
}

sub misc :Chained('item') :PathPart('misc') :Args(0)
    :Order(70) {
}

sub supervise :Chained('item') :PathPart('supervise') :Args(0) 
    :Order(20)
    :Does(ACL)
    :AllowedRole(supervisor)
    :AllowedRole(admin)
    :ACLDetachTo(/error)
{ 
    my ($self, $c) = @_;
    $self->add_nav($c,
        '/misc_action', # not in this controller
    );

}

sub administer :Chained('item') :PathPart('admin') :Args(0) 
    :Does(ACL)
    :RequiresRole(admin)
    :ACLDetachTo(/error)
{ 
    # add new item
    my ($self, $c) = @_;

    $self->add_nav($c,
        { 
            action => 'admin',
            order  => 5, # higher than item
        });

    # and override
    $self->add_nav($c,
        { 
            action => 'supervise',
            order  => 7, # also higher than item 
        });
    

}


=head1 NAME

NavTest::Controller::Root - Root Controller for NavTest

=head1 DESCRIPTION

[enter your description here]

=head1 METHODS

=cut

=head2 index

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;

    # Hello World
    $c->response->body( $c->welcome_message );
}

sub default :Path {
    my ( $self, $c ) = @_;
    $c->response->body( 'Page not found' );
    $c->response->status(404);
}

=head2 end

Attempt to render a view, if needed.

=cut

sub end : ActionClass('RenderView') {}

=head1 AUTHOR

Hakim,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
