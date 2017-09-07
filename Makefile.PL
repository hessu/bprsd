use 5.006;
use ExtUtils::MakeMaker;
# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# the contents of the Makefile that is written.
WriteMakefile(
    'NAME'		=> 'bprsd',
    'VERSION_FROM'	=> 'bprsd', # finds $VERSION
    'PREREQ_PM'		=> {
        'Test::More' => '0.1',
        'Ham::APRS::IS' => '1.18',
        'Ham::APRS::FAP' => '1.18',
        'YAML::Tiny' => '1.30',
        'JSON' => '2.00',
        'String::CRC32' => '1.4',
        'Time::HiRes' => '1.0'
    },
    'EXE_FILES'         => [ 'bprsd' ],
    ($] >= 5.005 ?    ## Add these new keywords supported since 5.005
      (
       ABSTRACT_FROM   => 'bprsd', # retrieve abstract from module
       AUTHOR          => 'Heikki Hannikainen <hessu@hes.iki.fi>',
       LICENSE        => 'perl',
      ) : ()
    ),
);
