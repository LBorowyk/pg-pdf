create schema if not exists pdf;
-- ---------- Названия глифов ---------------------
drop table if exists pdf.glyph_names cascade;
create table pdf.glyph_names (
	glyph_names_ids serial primary key,
	glyph_name varchar
);
create index glyphs_names_glyphname_idx on pdf.glyph_names(glyph_name);
-- ------------------------------------------------