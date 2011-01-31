package MusicBrainz::Server::Entity::LabelSubscription;
use Moose;
use namespace::autoclean;

extends 'MusicBrainz::Server::Entity::Subscription';

with qw(
    MusicBrainz::Server::Entity::Role::Subscription::Delete
    MusicBrainz::Server::Entity::Role::Subscription::Merge
);

has 'id' => (
    isa => 'Int',
    is => 'ro'
);

has 'label_id' => (
    isa => 'Int',
    is => 'ro',
);

has 'label' => (
    isa => 'Artist',
    is => 'rw',
);

sub target_id { shift->label_id }
sub type { 'label' }

1;
