# NAME

Dist::Zilla::Plugin::Test::CleanNamespaces - Generate a test to check that all namespaces are clean

# VERSION

version 0.002

# SYNOPSIS

In your `dist.ini`:

    [Test::CleanNamespaces]
    skip = ::Dirty$

# DESCRIPTION

This is a [Dist::Zilla](https://metacpan.org/pod/Dist::Zilla) plugin that runs at the
[gather files](https://metacpan.org/pod/Dist::Zilla::Role::FileGatherer) stage, providing a test file
(configurable, defaulting to `xt/release/clean-namespaces.t`).

This test will scan all modules in your distribution and check that their
namespaces are "clean" -- that is, that there are no remaining imported
subroutines from other modules that are now callable as methods at runtime.

You can fix this in your code with [namespace::clean](https://metacpan.org/pod/namespace::clean) or
[namespace::autoclean](https://metacpan.org/pod/namespace::autoclean).

# CONFIGURATION OPTIONS

## filename

The name of the generated test. Defaults to `xt/release/clean-namespaces.t`.

## skip

A regular expression describing a module name that should not be checked. Can
be repeated more than once.

# TO DO (or: POSSIBLE FEATURES COMING IN FUTURE RELEASES)

- use of a configurable [FileFinder](https://metacpan.org/pod/Dist::Zilla::Role::FileFinder) for finding

    source files to check (depends on changes planned in [Test::CleanNamespaces](https://metacpan.org/pod/Test::CleanNamespaces))

# SUPPORT

Bugs may be submitted through [the RT bug tracker](https://rt.cpan.org/Public/Dist/Display.html?Name=Dist-Zilla-Plugin-Test-CleanNamespaces)
(or [bug-Dist-Zilla-Plugin-Test-CleanNamespaces@rt.cpan.org](mailto:bug-Dist-Zilla-Plugin-Test-CleanNamespaces@rt.cpan.org)).
I am also usually active on irc, as 'ether' at `irc.perl.org`.

# SEE ALSO

- [Test::CleanNamespaces](https://metacpan.org/pod/Test::CleanNamespaces)
- [namespace::clean](https://metacpan.org/pod/namespace::clean)
- [namespace::autoclean](https://metacpan.org/pod/namespace::autoclean)
- [namespace::sweep](https://metacpan.org/pod/namespace::sweep)
- [Sub::Exporter::ForMethods](https://metacpan.org/pod/Sub::Exporter::ForMethods)

# AUTHOR

Karen Etheridge <ether@cpan.org>

# COPYRIGHT AND LICENSE

This software is copyright (c) 2014 by Karen Etheridge.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.
