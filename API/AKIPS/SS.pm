package API::AKIPS::SS;

   use API::AKIPS::Rest;

   # Constructor of this module
   sub new {
      my $class = shift;

      my $self = {
            base_url => #Add Base Url here,
            rest     => API::AKIPS::Rest->new()
         };
      bless $self,$class;
      return $self;
   }

   # Description:
   #  This function is a general call to a specified site script
   # Param:
   #  String - Name of site script on akips
   #  a.String - Parameter Name
   #  b.String - Parameter Value
   #  Repeat Param's a and b until no more parameters are detected
   #
   # Return: String - The output of the selected site script
   #
   sub site_script {
      my $self = shift;
      my $function = shift;
      my @param;
      my @value;
      my $counter = 0;
      for my $i (@_){
         if ($counter % 2 == 0){
            push(@param, $i);
         }else{
            push(@value, $i);
         }
         $counter++;
      }

      if ($function =~ /^(?!web_).*$/) {
         $function = "web_".$function;
      }

      my $full_url = $self->{base_url}.
                     $self->{rest}->get_password().
                     ";function=".$function;
      $counter = 0;
      for my $i (@param){
         $full_url .= ";".$param[$counter]."=".$value[$counter++];
      }
      return $self->{rest}->request($full_url,"site_script $function");
   }

1;
