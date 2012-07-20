#!/usr/bin/env perl
#
# Please refer to the Plain Old Documentation (POD) at the end of this Perl Script for further information

#TODO Refactor as module
do 'facebook_graphapi.pl';

use strict;
# use warnings;
use JSON;
use HTTP::Tiny;
use Data::Dumper;

# #CONFIGURATION Remove "#" for Smart::Comments
# use Smart::Comments;

my $VERSION = "0.0.4"; # May be required to upload script to CPAN i.e. http://www.cpan.org/scripts/submitting.html

# Command line arguments from Maltego
my $maltego_selected_entity_value = $ARGV[0];

# "###" is for Smart::Comments CPAN Module
### \$maltego_selected_entity_value is: $maltego_selected_entity_value;

my $maltego_additional_field_values = $ARGV[1];

# "###" is for Smart::Comments CPAN Module
### \$maltego_additional_field_values is: $maltego_additional_field_values;

my %maltego_additional_field_values =
  split_maltego_additional_fields($maltego_additional_field_values);
my $affilation_facebook_uid = $maltego_additional_field_values{"uid"};

my $facebook_affiliation_name = $maltego_selected_entity_value;

print("<MaltegoMessage>\n");
print("<MaltegoTransformResponseMessage>\n");
print("\t<UIMessages>\n");
print(
"\t\t<UIMessage MessageType=\"Inform\">Facebook GraphAPI Profile Cover Image Local Transform v$VERSION</UIMessage>\n"
);


my $facebook_graphapi_URL =
  "https://graph.facebook.com/$affilation_facebook_uid";

# Create a new JSON request

# Create a new JSON request
my $http_request = HTTP::Tiny->new;
my $http_response = $http_request->get("$facebook_graphapi_URL");
facebook_graphapi_down("$facebook_graphapi_URL") unless $http_response->{success};

print("\t</UIMessages>\n");

print("\t<Entities>\n");

my $http_response_ref = decode_json($http_response->{content});
if ($http_response_ref) {
    my %http_response = %$http_response_ref;
    print(
"\t\t<Entity Type=\"cmlh.facebook.user.id\"><Value>$http_response{'id'}</Value></Entity>\n"
    );
}
else {

    # REFACTOR as <UIMessages>
    print STDERR ("$affilation_facebook_uid is not a Facebook User\n");
}

# TODO Return optional error Maltego Entity.
print("\t</Entities>\n");

# http://ctas.paterva.com/view/Specification#Message_Wrapper
print("</MaltegoTransformResponseMessage>\n");
print("</MaltegoMessage>\n");

=head1 NAME

from_affliation_facebook-to_user_cover.pl - "To Facebook Profile Cover Image"

=head1 VERSION

This documentation refers "To Facebook Profile Cover Image" Alpha v$VERSION

=head1 CONFIGURATION

Set the value(s) marked as #CONFIGURATION above this POD
    
=head1 USAGE

from_affliation_facebook-to_profile_cover_image.pl $maltego_selected_entity $maltego_additional_field_values

=head1 REQUIRED ARGUEMENTS
                
=head1 OPTIONAL ARGUEMENTS

=head1 DESCRIPTION

Returns the Facebook Cover Image and its FBID in Maltego via the Facebook GraphAPI

=head1 DEPENDENCIES

=head1 PREREQUISITES

JSON CPAN Module
WWW::Mechanize CPAN Module

=head1 COREQUISITES

=head1 INSTALLATION

=head1 OSNAMES

osx

=head1 SCRIPT CATEGORIES

Web

=head1 INCOMPATIBILITIES

=head1 BUGS AND LIMITATIONS

Please refer to the comments beginning with "TODO" in the Perl Code.

=head1 AUTHOR

Christian Heinrich

=head1 CONTACT INFORMATION

http://cmlh.id.au/contact

=head1 MAILING LIST

=head1 REPOSITORY

http://github.com/cmlh/Maltego-Facebook

=head1 FURTHER INFORMATION AND UPDATES

http://cmlh.id.au/tagged/maltego

=head1 LICENSE AND COPYRIGHT

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

  http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License. 

Copyright 2012 Christian Heinrich


