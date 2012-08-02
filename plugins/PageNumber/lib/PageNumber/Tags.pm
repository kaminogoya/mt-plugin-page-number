package PageNumber::Tags;

use strict;
use warnings;

sub _hdlr_current_page_number {
    my ($ctx) = @_;

    my $limit  = $ctx->stash('limit');
    my $offset = $ctx->stash('offset');

    return $limit ? $offset / $limit + 1 : 1;
}

sub _hdlr_previous_page_number {
    my ( $ctx, $args ) = @_;

    my $limit  = $ctx->stash('limit');
    my $offset = $ctx->stash('offset');

    return q() unless $offset;
    my $current_page = $limit ? $offset / $limit + 1 : 1;
    return q() unless $current_page > 1;

    return $current_page - 1;
}

sub _hdlr_next_page_number {
    my ( $ctx, $args ) = @_;

    my $limit  = $ctx->stash('limit');
    my $offset = $ctx->stash('offset');
    my $count  = $ctx->stash('count');

    return q() if ( $limit + $offset ) >= $count;
    my $current_page = $limit ? $offset / $limit + 1 : 1;

    return $current_page + 1;
}

1;
