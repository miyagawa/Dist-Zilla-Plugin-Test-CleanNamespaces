use strict;
use warnings FATAL => 'all';

use Test::More;
use if $ENV{AUTHOR_TESTING}, 'Test::Warnings';
use Test::DZil;
use Path::Tiny;
use File::pushd 'pushd';

my $tzil = Builder->from_config(
    { dist_root => 't/does-not-exist' },
    {
        add_files => {
            'source/dist.ini' => simple_ini(
                [ GatherDir => ],
                [ 'Test::CleanNamespaces' => { skip => '::Dirty$' } ],
            ),
            path(qw(source lib Foo.pm)) => "package Foo;\n1;\n",
            path(qw(source lib Foo Dirty.pm)) => "package Foo::Dirty;\nuse Scalar::Util 'refaddr';\n1;\n",
        },
    },
);
$tzil->build;

my $build_dir = $tzil->tempdir->subdir('build');
my $file = path($build_dir, 'xt', 'release', 'clean-namespaces.t');
ok(-e $file, 'test created');

my $content = $file->slurp;
unlike($content, qr/[^\S\n]\n/m, 'no trailing whitespace in generated test');

subtest 'run the generated test: filters out the "skip" regexp from the modules checked' => sub
{
    my $wd = pushd $build_dir;

    do $file;
    warn $@ if $@;
};

done_testing;
