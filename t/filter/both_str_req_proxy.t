use strict;
use warnings FATAL => 'all';

use Apache::Test;
use Apache::TestRequest;
use Apache::TestUtil;

plan tests => 1, (have_module('proxy') && have_access);

my $data = join ' ', 'A'..'Z', 0..9;
my $expected = lc $data; # that's what the input filter does
$expected =~ s/\s+//g;   # that's what the output filter does
my $location = '/TestFilter__both_str_req_proxy/foo';
my $response = POST_BODY $location, content => $data;
ok t_cmp($expected, $response, "lc input and reverse output filters");
