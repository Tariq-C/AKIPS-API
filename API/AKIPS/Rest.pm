package API::AKIPS::Rest;

   use IO::Socket::SSL;
   use HTTP::Request::Common;
   use HTTP::Headers;
   use LWP::UserAgent;

   # The Constructor of this module
   sub new {

      my $class = shift;
      my $self = {
            UsernameRW     => 'api-rw'
            ,UsernameRO    => 'api-ro'
            ,Password      => # connect to password somehow
            ,ua_agent      =>  LWP::UserAgent->new(ssl_opts => {verify_hostname => 0})
      };
      bless $self,$class;

      return $self;
   }

   # Description:
   #  A function to return the read-write username for api calls
   sub get_rw_user {
      my $self = shift;
      return $self->{'UsernameRW'};
   }

   # Description:
   # A function to return the read-only username for api calls
   sub get_ro_user {
      my $self = shift;
      return $self->{'UsernameRO'};
   }

   # Description:
   # A function to return the api password for api calls
   sub get_password {
      my $self = shift;
      return $self->{'Password'};
   }

   # Description:
   #  A function which sends an HTTP request to AKIPS
   # Param:
   #  String - The http url that we want to send
   #  String - The human readable request for logging
   #
   # Return:
   #  String - The decoded content of the http response
   #
   sub request {
      my $self = shift;
      my $url  = shift;
      my $req  = shift;

      my $request = HTTP::Request->new('GET' => $url);
      my $response = $self->{ua_agent}->request($request);
      my $code = $response->code;

      return $response->decoded_content;
   }

1;
