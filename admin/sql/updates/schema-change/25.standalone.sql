-- Generated by CompileSchemaScripts.pl from:
-- 20170604-mbs-9365.sql
-- 20170909-mbs-9462-missing-event-triggers.sql
-- 20180331-mbs-9664-non-loop-checks.sql
\set ON_ERROR_STOP 1
BEGIN;
SET search_path = musicbrainz, public;
SET LOCAL statement_timeout = 0;
--------------------------------------------------------------------------------
SELECT '20170604-mbs-9365.sql';

ALTER TABLE event_meta DROP CONSTRAINT IF EXISTS event_meta_fk_id;

ALTER TABLE event_meta
   ADD CONSTRAINT event_meta_fk_id
   FOREIGN KEY (id)
   REFERENCES event(id)
   ON DELETE CASCADE;

--------------------------------------------------------------------------------
SELECT '20170909-mbs-9462-missing-event-triggers.sql';

DROP TRIGGER IF EXISTS b_upd_l_event_url ON l_event_url;
DROP TRIGGER IF EXISTS remove_unused_links ON l_event_url;
DROP TRIGGER IF EXISTS url_gc_a_del_l_event_url ON l_event_url;
DROP TRIGGER IF EXISTS url_gc_a_upd_l_event_url ON l_event_url;

CREATE TRIGGER b_upd_l_event_url
    BEFORE UPDATE ON l_event_url
    FOR EACH ROW EXECUTE PROCEDURE b_upd_last_updated_table();

CREATE CONSTRAINT TRIGGER remove_unused_links
    AFTER DELETE OR UPDATE ON l_event_url DEFERRABLE INITIALLY DEFERRED
    FOR EACH ROW EXECUTE PROCEDURE remove_unused_links();

CREATE CONSTRAINT TRIGGER url_gc_a_del_l_event_url
    AFTER DELETE ON l_event_url DEFERRABLE INITIALLY DEFERRED
    FOR EACH ROW EXECUTE PROCEDURE remove_unused_url();

CREATE CONSTRAINT TRIGGER url_gc_a_upd_l_event_url
    AFTER UPDATE ON l_event_url DEFERRABLE INITIALLY DEFERRED
    FOR EACH ROW EXECUTE PROCEDURE remove_unused_url();

--------------------------------------------------------------------------------
SELECT '20180331-mbs-9664-non-loop-checks.sql';

ALTER TABLE l_area_area                   ADD CONSTRAINT non_loop_relationship CHECK (entity0 != entity1);
ALTER TABLE l_artist_artist               ADD CONSTRAINT non_loop_relationship CHECK (entity0 != entity1);
ALTER TABLE l_event_event                 ADD CONSTRAINT non_loop_relationship CHECK (entity0 != entity1);
ALTER TABLE l_label_label                 ADD CONSTRAINT non_loop_relationship CHECK (entity0 != entity1);
ALTER TABLE l_instrument_instrument       ADD CONSTRAINT non_loop_relationship CHECK (entity0 != entity1);
ALTER TABLE l_place_place                 ADD CONSTRAINT non_loop_relationship CHECK (entity0 != entity1);
ALTER TABLE l_recording_recording         ADD CONSTRAINT non_loop_relationship CHECK (entity0 != entity1);
ALTER TABLE l_release_release             ADD CONSTRAINT non_loop_relationship CHECK (entity0 != entity1);
ALTER TABLE l_release_group_release_group ADD CONSTRAINT non_loop_relationship CHECK (entity0 != entity1);
ALTER TABLE l_series_series               ADD CONSTRAINT non_loop_relationship CHECK (entity0 != entity1);
ALTER TABLE l_url_url                     ADD CONSTRAINT non_loop_relationship CHECK (entity0 != entity1);
ALTER TABLE l_work_work                   ADD CONSTRAINT non_loop_relationship CHECK (entity0 != entity1);

COMMIT;
