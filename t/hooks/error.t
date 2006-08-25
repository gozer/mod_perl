use strict;
use warnings FATAL => 'all';

use Apache::Test;
use Apache::TestUtil;
use Apache::TestRequest;

plan tests => 2;

{
    # this registers and performs cleanups, but we test whether the
    # cleanup was run only in the next sub-test
    my $location = "/TestHooks__error";
    my $expected = qr/^Error: Undefined subroutine/;
    my $received = GET_BODY $location;
    ok t_cmp($received, $expected, "error-notes set on ErrorDocument");
}

{
    # this registers and performs cleanups, but we test whether the
    # cleanup was run only in the next sub-test
    my $error_seed_text = 'seed_text';
    my $location = "/TestHooks__error?$error_seed_text";
    my $expected = qr/^Error: \Q$error_seed_text\E, Undefined subroutine/;
    my $received = GET_BODY $location;
    ok t_cmp($received, $expected, "seeded error-notes set on ErrorDocument");
}
