#!/usr/bin/perl 
use strict;
use warnings;

use lib './lib';
use Plugins::GitRepo;

my $git_repo = Plugins::GitRepo->new;

print $git_repo->xhtml;

