my $r = shift;
$r->status(404);
$r->send_http_header('text/plain');