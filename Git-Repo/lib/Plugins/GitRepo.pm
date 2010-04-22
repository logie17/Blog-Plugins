package Plugins::GitRepo;
use strict;
use warnings;

use Net::GitHub;

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
# CONSTANTS
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#

use constant DIV_CLASS_NAME =>  scalar 'github_repos';
use constant LI_CLASS_NAME  =>  scalar 'github_repos_item';
use constant A_CLASS_NAME   =>  scalar 'github_repos_item_anchor';
use constant GITHUB_OWNER   =>  scalar 'logie17';

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
# STATIC METHODS
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#

sub new
# Purpose: Constructor
# Input:   Ref/String of class
#          Hash of parameters
# Output:  Ref to instance
{
    my ( $class, %params) = @_;

    my $self = bless {}, ref($class) || $class;

    $self->_init(\%params);

    return $self;
}

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
# PUBLIC METHODS 
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#

sub xhtml
# Purpose: Builds out xhtml of repositories 
# Input:   1. Ref to self
# Output:  1. XHTML
{
    my ($self) = @_; 

    my $class_name = DIV_CLASS_NAME;

    my $repos_xhtml = join '', map 
                      { 
                        '<li class="' . LI_CLASS_NAME . 
                        '"><a class="' . A_CLASS_NAME . 
                        '" href="' . $_->{url} . 
                        '" title="' . $_->{description} . 
                        '">' . $_->{name} . 
                        '</a></li>'
                      } 
                      @{$self->{github_obj}->repos->show->{repositories}}; 

    return<<EOF;
    <div class="$class_name">
        $repos_xhtml
    </div>
EOF
}

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
# PRIVATE METHODS 
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#

sub _init
# Purpose: Initializes object state
# Input:   Ref to self
#          Hash ref of parameters
# Output:  Ref to to self
{
    my ($self, $params_hr) = @_;

    $self->{github_obj} = Net::GitHub->new(owner => GITHUB_OWNER, repo => '');

    return $self;
}

1;
