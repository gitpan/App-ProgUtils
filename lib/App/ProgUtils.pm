package App::ProgUtils;

our $DATE = '2014-11-28'; # DATE
our $VERSION = '0.14'; # VERSION

use 5.010001;
use strict;
use warnings;

our $_complete_program = sub {
    require Complete::Util;
    require List::MoreUtils;

    my %args = @_;

    my $word = $args{word} // '';

    # combine all executables (including dirs) and programs in PATH
    my $c1 = Complete::Util::complete_file(
        word   => $word,
        filter => sub { -x $_[0] },
        #ci    => 1, # convenience, not yet supported by C::U
    );
    my $c2 = Complete::Util::complete_program(
        word => $word,
        ci   => 1, # convenience
    );

    {
        words      => [ List::MoreUtils::uniq(sort(@$c1, @$c2)) ],
        path_sep   => '/',
    };
};

sub _search_program {
    require File::Which;

    my $prog = shift;
    if ($prog =~ m!/!) {
        return $prog;
    } else {
        return File::Which::which($prog) // $prog;
    }
}

1;
# ABSTRACT: Command line to manipulate programs in PATH

__END__

=pod

=encoding UTF-8

=head1 NAME

App::ProgUtils - Command line to manipulate programs in PATH

=head1 VERSION

This document describes version 0.14 of App::ProgUtils (from Perl distribution App-ProgUtils), released on 2014-11-28.

=head1 SYNOPSIS

This distribution provides the following command-line utilities:

 progcat
 progedit
 progless
 progman
 progpath

=head1 SEE ALSO

L<App::PMUtils>, a similarly spirited distribution.

=head1 HOMEPAGE

Please visit the project's homepage at L<https://metacpan.org/release/App-ProgUtils>.

=head1 SOURCE

Source repository is at L<https://github.com/sharyanto/perl-App-ProgUtils>.

=head1 BUGS

Please report any bugs or feature requests on the bugtracker website L<https://rt.cpan.org/Public/Dist/Display.html?Name=App-ProgUtils>

When submitting a bug or request, please include a test-file or a
patch to an existing test-file that illustrates the bug or desired
feature.

=head1 AUTHOR

perlancar <perlancar@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2014 by perlancar@cpan.org.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
