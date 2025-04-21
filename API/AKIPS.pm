package API::AKIPS;

   use API::AKIPS::SPM;
   use API::AKIPS::NMDB;
   use API::AKIPS::SS;

   sub new {
      my $class = shift;
      my %logger_param = ("preset"=>"api");

      my $self = {
         'spm'            => API::AKIPS::SPM->new()
         ,'nmdb'          => API::AKIPS::NMDB->new()
         ,'ss'            => API::AKIPS::SS->new()
         ,'logger'        => Logger->new(\%logger_param)
         ,'API'           => "AKIPS"
      };
      bless $self, $class;

      $self->{"script"} = $self->identify_script();
      $self->{"user"}   = $self->identify_user();

      return $self;
   }

   sub spm_file {
      my $self = shift;
      my $file = shift;
      $self->log_activity('spm_file '.$file);
      return $self->{'spm'}->spm_file($file);
   }

   sub spm_mac {
      my $self = shift;
      my $macs = shift;
      $self->log_activity('spm_mac '.$macs);
      return $self->{'spm'}->spm_mac($macs);
   }

   sub nm_db {
      my $self = shift;
      my $query = shift;
      $self->log_activity('nm_db '.$query);
      return $self->{"nmdb"}->nm_db($query);
   }

   sub web_adb {
      my $self       = shift;
      my $function   = shift;
      $self->log_activity('web_adb '.$function);
      return $self->{"nmdb"}->nm_db($function);
   }

   sub site_script {
      my $self = shift;
      my @query = @_;
      $self->log_activity('site_script '.join(' ', @query));
      return $self->{"ss"}->site_script(@query);
   }

   sub rename_device {
      my $self       = shift;
      my $name_old   = shift;
      my $name_new   = shift;
      $self->log_activity('rename_device '.$name_new);
      $self->{"ss"}->rename_device($name_new, $name_old);
   }


   # Description:
   # A function to identify who is running this script
   sub identify_user {
      my $self = shift;
      my $user = $ENV{USER} || getpwuid($<) || $ENV{LOGNAME};
      if ($user =~ /IDIR\\/i) {
         ($user) = ($user =~ /\\(.*)$/);
      }
      return $user;
   }

   # Description:
   # A function to determine what script is accessing this module
   sub identify_script {
      my $script = ($0 =~ /\/([^\/]+)$/)[0];
      return $script;
   }

   sub log_activity {
   }
}

1;
