# Wikia::API
# A Perl library to access Wikia APIs other than the default MediaWiki APIs.

package Wikia::API;

use strict;
use base qw(Mediawiki::API);



=pod

Wikia::API - an extension of Mediawiki::API which also allows
interfacing with Wikia's Nirvana framework.

=head1 Synopsis

 $api = Wikia::API->new();
# TODO: UPDATE THIS EXAMPLE.
 $api->base_url($newurl);
 @list = @{$api->pages_in_category($categoryTitle)};
 $api->edit_page($pageTitle, $pageContent, $editSummary);

=cut

#############################################################



# TODO: Function to set wiki?  Should be diff than base_url probably.
# TODO: Function to set wiki?  Should be diff than base_url probably.


# TODO: subroutine to call Nirvana
# TODO: subroutine to call Nirvana










################################
# Close POD

=back

=head1 Copryright

Copyright 2011 by Sean Colombo.

Released under GNU Public License (GPL) 2.0.
	  
TODO:
	- Implement Nirvana calls

=cut


########################################################
## Return success upon loading class
1;
