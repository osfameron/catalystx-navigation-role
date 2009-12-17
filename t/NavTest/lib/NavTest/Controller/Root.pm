package NavTest::Controller::Root;

use Moose;
BEGIN { extends 'Catalyst::Controller' }

with 'CatalystX::Navigation::Role';

# Sets the actions in this controller to be registered with no prefix
# so they function identically to actions created in MyApp.pm
__PACKAGE__->config->{namespace} = '';

sub begin :Private {
    my ($self, $c) = @_;

    $self->add_nav(qw/ help logout /); # relative names
    $self->add_nav('/index');          # full name, here
    $self->add_nav('/item/misc');      # full name, submodule

    $c->stash->{template} = 'default.tt';
}

sub login  :Path('login')  :Args(0) {
    my ($self, $c) = @_;
    my $user     = $c->req->params('user');
    my $password = $c->req->params('password');

    if ($user) {
        my $success = $c->authenticate($user, $password);
        if ($success) {
            $c->stash->{message} = "Login Succeeded for $user";
        } else {
            $c->stash->{message} = "Login Failed for $user";
        }
    } else {
        $c->stash->{template} = 'login.tt';
    }
}
sub help   :Path('help')   :Args(0) :Order(100) { }
sub logout :Path('logout') :Args(0) :Order(90)  { }
sub index  :Path           :Args(0) :Order(0)   { }

sub misc_action :Path(misc_action) :Args(0) :Order(80)   { } 
    # nav enabled in other controller

sub end {
    my ($self, $c) = @_;

    my @nav = $self->get_allowed_navs($c);
    use Data::Dumper;
    local $Data::Dumper::Maxdepth = 3;
    local $Data::Dumper::Indent   = 1;
    die Dumper(\@nav);
    $c->stash->{nav} = \@nav;

    $c->forward('View::TT');
}

=head1 NAME

NavTest::Controller::Root - Root Controller for NavTest

=head1 DESCRIPTION

[enter your description here]

=head1 METHODS

=cut

=head2 index

=cut

sub default :Path {
    my ( $self, $c ) = @_;
    $c->response->body( 'Page not found' );
    $c->response->status(404);
}

=head1 AUTHOR

Hakim,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
