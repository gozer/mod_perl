use ExtUtils::testlib;
use strict;
use warnings FATAL => 'all';

use Test;

use Apache2 ();
use Apache::Const -compile => qw(DECLINED :http :common TAKE23 &OPT_EXECCGI
                                 DECLINE_CMD DIR_MAGIC_TYPE);
use Apache::Const; #defaults to :common

plan tests => 15;

ok REDIRECT == 302;
ok AUTH_REQUIRED == 401;
ok OK == 0;
ok Apache::OK == 0;
ok Apache::DECLINED == -1;
ok Apache::HTTP_GONE == 410;
ok Apache::OPT_EXECCGI;
ok Apache::DECLINE_CMD eq "\x07\x08";
ok Apache::DIR_MAGIC_TYPE eq "httpd/unix-directory";

ok ! defined &M_GET;
Apache::Const->import('M_GET');
ok defined &M_GET;

for (qw(BOGUS :bogus)) {
    eval { Apache::Const->import($_) };
    ok $@;
}

eval { Apache::Const->import('-foobar') };

ok $@;

eval { Apache::Const::compile() };

ok $@;