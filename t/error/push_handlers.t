use strict;
use warnings FATAL => 'all';

use Apache::Test;
use Apache::TestUtil;
use Apache::TestRequest;

# XXX: the misuse of push_handlers exercised by this test is different
# at least on FreeBSD, so it fails, skip for now.
plan tests => 1, under_construction;

my $location = "/TestError__push_handlers";
my $expected = "ok";
my $received = GET_BODY $location;

ok t_cmp($expected, $received);