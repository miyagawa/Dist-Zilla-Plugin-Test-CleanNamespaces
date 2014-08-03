use strict;
use warnings FATAL => 'all';

use Test::More;
use if $ENV{AUTHOR_TESTING}, 'Test::Warnings';
use Test::DZil;
use Path::Tiny;
use File::pushd 'pushd';
use Test::Deep;

my $tzil = Builder->from_config(
    { dist_root => 't/does-not-exist' },
    {
        add_files => {
            path(qw(source dist.ini)) => simple_ini(
                [ GatherDir => ],
                [ 'Test::CleanNamespaces' ],
            ),
            path(qw(source lib Foo.pm)) => "package Foo;\n1;\n",
        },
    },
);
$tzil->build;

my $build_dir = path($tzil->tempdir)->child('build');
my $file = $build_dir->child(qw(xt release clean-namespaces.t));
ok(-e $file, 'test created');

my $content = $file->slurp_utf8;
unlike($content, qr/[^\S\n]\n/m, 'no trailing whitespace in generated test');

cmp_deeply(
    $tzil->distmeta,
    superhashof({
        prereqs => {
            develop => {
                requires => {
                    'Test::CleanNamespaces' => Dist::Zilla::Plugin::Test::CleanNamespaces->_tcn_prereq,
                },
            },
        },
    }),
    'prerequisites are properly injected',
);

subtest 'run the generated test' => sub
{
    my $wd = pushd $build_dir;

    do $file;
    note 'ran tests successfully' if not $@;
    fail($@) if $@;
};

done_testing;
