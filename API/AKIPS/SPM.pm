package API::AKIPS::SPM;

   use API::AKIPS::Rest;

   # This is the constructor for this module
   sub new {

      my $class = shift;
      my $self = {
            rest        => API::AKIPS::Rest->new(),
            base_url   => # Add Base Url
      };
      bless $self,$class;
      return $self;
   }

   # Description:
   #  This function returns a switch port mapping file as a csv
   # Param: String - Name of file
   # Return: String - CSV formatted string
   #
   sub spm_file {
      my $self = shift;
      my $file = shift;
      if (!$file){return 0}
      my $password = $self->{rest}->get_password();
      my $full_url = $self->{base_url}.$password.";filename=".$file;
      return $self->{'rest'}->request($full_url, "spm_file $file");
   }

   # Description:
   #  This function retrieves the switch port mapping of a list of mac addresses
   # Param: String - CSV formatted list of mac addresses
   # Return: String - CSV formatted list of mappings of each provided mac address
   #
   sub spm_mac {
      my $self = shift;
      my $macs = shift;
      if (!$macs){return 0}
      my $password = $self->{rest}->get_password();
      my $full_url = $self->{base_url}.$password.";mac=".$macs;
      return $self->{'rest'}->request($full_url, "spm_mac $macs");
   }

1;
