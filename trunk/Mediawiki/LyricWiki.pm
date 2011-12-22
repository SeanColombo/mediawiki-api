# LyricWiki::API;
# A Perl library to access LyricWiki APIs other than the default MediaWiki APIs.

package LyricWiki::API;

use strict;
use base qw(Mediawiki::API);
use Data::Dumper;

##### CONFIGURATION #####
#my $LYRICWIKI_BASE_URL = "http://lyrics.wikia.com/api.php";
my $LYRICWIKI_BASE_URL = "http://lyrics.sean.wikia-dev.com/api.php";
##### CONFIGURATION #####

=pod

LyricWiki::API - an extension of Mediawiki::API which also allows
making calls to the extra LyricWiki API functions.

=head1 Synopsis

 $api = LyricWiki::API->new();
# TODO: UPDATE THIS EXAMPLE.
# TODO: UPDATE THIS EXAMPLE.
 @list = @{$api->pages_in_category($categoryTitle)};
 $api->edit_page($pageTitle, $pageContent, $editSummary);

=cut

#############################################################

####
# Extend the default constructor so that we can automatically set the base_url.
####
sub new{
	my $class = shift;
	my $self = $class->SUPER::new();

	$self->base_url( $LYRICWIKI_BASE_URL );

	bless($self);
	return $self;
} # end constructor

#############################################################

=item $api->getSong("Cake", "Dime")
=item $api->getSong("Cake:Dime")

####
# Calls the getSong function from LyricWiki.  Ideally, the
# artist and song name should be passed in separately, but
# if they are both in the same string (separated by a comma)
# that can be passed in as the only param and it will work.
####

=cut
sub getSong{
	my $self = shift;
	my $artist = shift;
	my $song = shift;

	# If only one parameter was provided, split on the first colon.
	if((!$song) || ($song eq "")){
		if($artist =~ /^(.*?):(.*)$/){
			$song = $2;
			$artist = $1;
		}
	}

	$self->print(1,"A Fetching content of \"$artist:$song\"");
 
	my $queryParams = [
		'forceget' => '1', # the LW API appears to expect GET data only (for GET requests).
		'action' => 'lyrics', 
		'func' => 'getSong', 
		'artist' => $artist,
		'song' => $song,
		'fmt' => 'xml',
		];

	my $results = $self->makeXMLrequest($queryParams);

	return $results;
} # end getSong()

#############################################################

=item $api->getArtist("Cake");

####
# Returns info for an artist.
####

=cut
sub getArtist{
	my $self = shift;
	my $artist = shift;

	$self->print(1,"A Fetching content of \"$artist\"");
 
	my $queryParams = [
		'forceget' => '1', # the LW API appears to expect GET data only (for GET requests).
		'action' => 'lyrics', 
		'func' => 'getArtist', 
		'artist' => $artist,
		'fixXML' => 'true', # needed because first release of API had invalid XML... this gets the valid version
		'fmt' => 'xml',
		];

	my $results = $self->makeXMLrequest($queryParams);

	return $results;
} # end getArtist()

#############################################################

=item $api->getHometown("Mac Miller");

####
# Returns the hometown for an artist.
####

=cut
sub getHometown{
	my $self = shift;
	my $artist = shift;

	$self->print(1,"A Fetching hometown for \"$artist\"");

	my $queryParams = [
		'forceget' => '1', # the LW API appears to expect GET data only (for GET requests).
		'action' => 'lyrics', 
		'func' => 'getHometown', 
		'artist' => $artist,
		'fmt' => 'xml',
		];

	my $results = $self->makeXMLrequest($queryParams);

	return $results;
} # end getHometown()

#############################################################

=item $api->getSOTD();

####
# Returns info for the current Song of the Day.
#####

=cut
sub getSOTD{
	my $self = shift;

	$self->print(1,"A Fetching Song of the Day");
 
	my $queryParams = [
		'forceget' => '1', # the LW API appears to expect GET data only (for GET requests).
		'action' => 'lyrics', 
		'func' => 'getSOTD', 
		'fmt' => 'xml',
		];

	my $results = $self->makeXMLrequest($queryParams);

	return $results;
} # end getSOTD()

#############################################################

####
# Creates a song page via the API.
#
# Params:
# overwriteIfExists - nonzero means that this page data (the lyrics and onAlbums) will overwrite
#                     the page if it already exists. 0 means that nothing will be changed if the
#                     page already exists.
# artist -
# song - 
# lyrics - 
# language - optional string for the language (the language name should be in English).
# onAlbums - an array-reference to an array which contains strings which are album titles.
####
sub postSong{
	my $self = shift;
	my $overwriteIfExists = shift;
	my $artist = shift;
	my $song = shift;
	my $lyrics = shift;
	my $language = shift;
	my $onAlbums = shift;
	$onAlbums = join("|", @{$onAlbums});

	$self->print(1,"A Posting \"$artist:$song\"");

	my $queryParams = [
		'action' => 'lyrics',
		'func' => 'postSong',
		'overwriteIfExists' => $overwriteIfExists,
		'artist' => $artist,
		'song' => $song,
		'lyrics' => $lyrics,
		'onAlbums' => $onAlbums,
		'language' => $language,
		'fmt' => 'xml',
		];

	my $results = $self->makeXMLrequest($queryParams);

	return $results;
} # end postSong()

#############################################################



################################
# Close POD

=back

=head1 Copryright

Copyright 2011 by Sean Colombo.

Released under GNU Public License (GPL) 2.0.
	  
TODO:
	- Implement all of the todos
	- Test all of the subroutines
	- Add this to the Support Matrix on http://api.wikia.com/wiki/Client_libraries

=cut


########################################################
## Return success upon loading class
1;
