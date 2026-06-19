use strict;
use IO::Socket::INET;

my $port = $ENV{PORT} || 3000;
my $root = "C:/Users/youha/Claude projects/radiology-directory";

my $server = IO::Socket::INET->new(
    LocalAddr => '0.0.0.0',
    LocalPort => $port,
    Proto     => 'tcp',
    Type      => IO::Socket::SOCK_STREAM(),
    ReuseAddr => 1,
    Listen    => 10,
) or die "Cannot bind: $!";

print "Serving on http://localhost:$port/\n";
$| = 1;

my %mime = (
    html => 'text/html; charset=utf-8',
    js   => 'application/javascript',
    css  => 'text/css',
    json => 'application/json',
    png  => 'image/png',
    svg  => 'image/svg+xml',
);

while (my $client = $server->accept()) {
    my $req = '';
    while (<$client>) { $req .= $_; last if /^\r?\n$/; }
    my ($path) = ($req =~ /^GET\s+(\S+)/);
    $path //= '/';
    $path = '/index.html' if $path eq '/';
    $path =~ s/[?#].*//;
    $path =~ s/\.\.//g;
    $path =~ s|/|\\|g;
    my $file = $root . $path;
    if (-f $file) {
        open my $fh, '<:raw', $file or do {
            print $client "HTTP/1.0 500 Error\r\n\r\n";
            close $client; next;
        };
        my $body = do { local $/; <$fh> };
        close $fh;
        my ($ext) = ($file =~ /\.(\w+)$/);
        my $ct = $mime{lc($ext//'')} // 'application/octet-stream';
        print $client "HTTP/1.0 200 OK\r\nContent-Type: $ct\r\nContent-Length: ".length($body)."\r\n\r\n$body";
    } else {
        print $client "HTTP/1.0 404 Not Found\r\n\r\nNot Found";
    }
    close $client;
}
