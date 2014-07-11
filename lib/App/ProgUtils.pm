package App::ProgUtils;

use 5.010001;
use strict;
use warnings;

our $VERSION = '0.07'; # VERSION
our $DATE = '2014-07-11'; # DATE

our $_complete_program = sub {
    require Complete::Util;
    my %args = @_;

    my $word = $args{word} // '';
    my $completion;
    my $is_path;
    if ($word =~ m#/#) {
        # if user specify path, e.g. ./foo, ../bar, or /usr/bin/ it means she
        # wants to complete from filesystem. but note that complete_file()
        # doesn't yet support ci=>1 option.
        $is_path = 1;
        $completion = Complete::Util::complete_file(
            word => $word,
            #ci   => 1, # convenience
        );
    } else {
        $completion = Complete::Util::complete_program(
            word      => $args{word},
            ci        => 1, # convenience
        );
    }

    {
        completion => $completion,
        is_path    => $is_path,
    };
};

1;
# ABSTRACT: Command line to manipulate programs in PATH

__END__

=pod

=encoding UTF-8

=head1 NAME

App::ProgUtils - Command line to manipulate programs in PATH

=head1 VERSION

This document describes version 0.07 of App::ProgUtils (from Perl distribution App-ProgUtils), released on 2014-07-11.

=head1 SYNOPSIS

This distribution provides the following command-line utilities:

 progless
 progedit
 progman

=head1 SEE ALSO

B<which>

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

Steven Haryanto <stevenharyanto@gmail.com>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2014 by Steven Haryanto.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
