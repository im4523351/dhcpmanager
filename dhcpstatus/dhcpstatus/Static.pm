#------------------------------------------------------------------------
# Copyright (C) 2000 Michael Grubits.
#
# This file is part of DHCPStatus.
#
# DHCPStatus is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
#
# DHCPStatus is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with DHCPStatus; if not, write to the Free Software
# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
#------------------------------------------------------------------------

package Static;

#
# This package keeps track of the static information for a single IP address.
#

use strict;

sub new {
   my $static = {};
   $static->{IP} = "";
   $static->{HOST} = "";
   $static->{MAC} = "00:00:00:00:00:00";
   $static->{LEASE_TIME} = "0";
   bless($static);
   return($static);
}

#
# The IP address of this static.
#
sub ip {
   my $static = shift;
   if (@_) {
      $static->{IP} = shift;
   }
   return($static->{IP});
}

sub host {
   my $static = shift;
   if (@_) {
      $static->{HOST} = shift;
   }
   return($static->{HOST});
}

1;
