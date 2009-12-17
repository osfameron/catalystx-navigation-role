use MooseX::Declare;

role CatalystX::Navigation::Role {
    our $VERSION = '0.01';

    use MooseX::MultiMethods;

    use MooseX::Types::Moose qw( Str ArrayRef HashRef );
    use CatalystX::Navigation::Types qw( :all );

    has 'navigation' => (
        is      => 'rw',
        isa     => ArrayRef,
        default => sub { [] },
        handles => {
            all_possible_navs => 'elements',
        },
    );

    multi method _action_list_of (MyCActionChain $x) {
        @{ $x->chain };
    }
    multi method _action_list_of (Any $x) {
        ($x);
    }

    # I'd use a normal Moose coercion, but I also need $c... d'oh
    multi method _coerce_nav(MyC $c, MyCxNavigation $obj) {
        $obj;
    }
    multi method _coerce_nav(MyC $c, Str $str) {
        my $action = $c->dispatcher->get_action_by_path($str);
        my ($order) = $action->attributes->{Order};

        CatalystX::Navigation->new(
            order  => $order || 101,
            action => $action,
        );
    }
    multi method _coerce_nav(MyC $c, HashRef $hash) {
        CatalystX::Navigation->new( $hash );
    }

    method get_navigation_methods (MyCController $self: MyC $c) {
        my @possible_navs = map 
            { $self->_coerce_nav($c, $_) }
                 $self->all_possible_navs;

        my @allowed_navs = $self->get_allowed_navs($c, \@possible_navs);

        my @ordered_navs = sort {
            $a->order        <=> $b->order
         || $a->action->name cmp $b->action->name
            } @allowed_navs;
    }

    method get_allowed_navs (MyCController $self: MyC $c, ARCxNavigation $navs) {
        return grep {
            my $action = $_->action;
            my @chain = $self->_action_list_of(
                $c->dispatcher->expand_action($action));
            my $denied = first {
                $_->does('Catalyst::ActionRole::ACL')
                && !($action->can_visit($c))
                } @chain;
            } @$navs;
    }
}

=head1 NAME

CatalystX::Navigation::Role - The great new Catalyst::Navigation::Role!

=head1 VERSION

Version 0.01

=cut



=head1 SYNOPSIS


=head1 AUTHOR

osfameron, C<< <osfameron at cpan.org> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-catalyst-navigation-role at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=CatalystX-Navigation-Role>.

=head1 SUPPORT

=over 4

=item * RT: CPAN's request tracker

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=CatalystX-Navigation-Role>

=item * Search CPAN

L<http://search.cpan.org/dist/CatalystX-Navigation-Role/>

=back

=head1 ACKNOWLEDGEMENTS


=head1 COPYRIGHT & LICENSE

Copyright 2009 osfameron.

This program is free software; you can redistribute it and/or modify it
under the terms of either: the GNU General Public License as published
by the Free Software Foundation; or the Artistic License.

See http://dev.perl.org/licenses/ for more information.


=cut

1; # End of CatalystX::Navigation::Role
