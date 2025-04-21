package API::AKIPS::NMDB;

   use API::AKIPS::Rest;

   # The Constructor of this module
   sub new {

      my $class = shift;
      my $self = {
            rest     =>  API::AKIPS::Rest->new(),
            base_url => #Put your base url here
      };
      bless $self,$class;
      return $self;
   }

   # Description:
   #  This function is a general call to utilize the command console on AKIPS
   # Param: String - The Query to be run by the command console
   # Return String - The output of the query in csv a format
   sub nm_db {
      my $self = shift;
      my $query = shift;
      my $username = $self->{rest}->get_rw_user();
      my $password = $self->{rest}->get_password();
      my $full_url = $self->{base_url}.
                     "username=".$username.
                     ";password=".$password.
                     ";cmds=".$query;
      return $self->{rest}->request($full_url, "nm_db $query");
   }

1;
