  use HTTP::Daemon;
  use HTTP::Status;

  my $d = HTTP::Daemon->new(
           LocalAddr => 'localhost',
           LocalPort => 4321,
       )|| die;

  print "Please contact me at: <URL:", $d->url, ">\n";

  while (my $c = $d->accept) {
      while (my $r = $c->get_request) {
          if ($r->method eq 'GET') {
              
              my $p = $r->url->path;
              $p = substr($p,1);
              print $p, "\n";
              if ($p eq "") {
                  $file_s = "index.html";
                  $c->send_file_response($file_s);
              } else {
                  $c->send_file_response("$p");
              }
              
          }
          else {
              $c->send_error(RC_FORBIDDEN)
          }
      }
      $c->close;
      undef($c);
  }
