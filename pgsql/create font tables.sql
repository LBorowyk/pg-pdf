create schema if not exists pdf;
-- ---------- Названия глифов ---------------------
drop table if exists pdf.glyph_names cascade;
create table pdf.glyph_names (
	glyph_names_id serial primary key,
	glyph_name varchar
);
create index glyphs_names_glyphname_idx on pdf.glyph_names(glyph_name);
-- ------------------------------------------------
-- ---------- Список названий шрифтов -------------
drop table if exists pdf.font_list cascade;
create table pdf.font_list (
	font_list_id serial primary key,
	font_name varchar
);
create index fontlist_fontlistid_idx on pdf.font_list(font_list_id);

-- ------------------------------------------------

-- ------ Список начертаний конкретного шрифта ----
drop table if exists pdf.fonts cascade;
create table pdf.fonts (
	fonts_id serial primary key,
	font_list_id int4 references pdf.font_list,
	is_bold boolean default false,
	is_italic boolean default false,
	unitsPerEm numeric
);
create index fonts_fontsid_idx on pdf.fonts(fonts_id);
-- ------------------------------------------------

-- ---- Основные данные про начертание шрифта -----
drop table if exists pdf.font_header_data cascade;
create table pdf.font_header_data (
	font_header_data_id serial primary key,
	fonts_id int4 references pdf.fonts,
	platform_id int4,
	plat_enc_id int4,
	lang_id int4,
	unicode boolean,
	font_family varchar,
	font_subfamily varchar,
	unique_subfamily_ident varchar,
	full_font_name varchar,
	postscript_font_name varchar
);
create index fontheaderdata_fontheaderdataid_idx on pdf.font_header_data(font_header_data_id);
create index fontheaderdata_fontsid_idx on pdf.font_header_data(fonts_id);
-- ------------------------------------------------

-- ---------- Таблицы CMAP -------------
-- содержит код глифа и его название
drop table if exists pdf.cmaps cascade;
create table pdf.cmaps (
	cmaps_id serial primary key,
	font_header_data_id int4 references pdf.font_header_data,
	fonts_id int4 references pdf.fonts,
	code varchar,
	code_int int4,
	glyphs_names_id int4 references pdf.glyph_names,
	plat_enc_id int4,
	platform_id int4
);
create index cmaps_cmapsid_idx on pdf.cmaps(cmaps_id);
create index cmaps_fontheaderdataid_idx on pdf.cmaps(font_header_data_id, glyphs_names_id);
-- ------------------------------------------------

-- ----- Список глифов конкретного начертания -----
drop table if exists pdf.glyphs cascade;
create table pdf.glyphs (
	glyphs_id serial primary key,
	fonts_id int4 references pdf.fonts,
	glyphs_names_id int4 references pdf.glyph_names,
	x_min numeric,
	y_min numeric,
	x_max numeric,
	y_max numeric,
	advance_width int4,
	left_side_bearing int4,
	glyph_path text
);
create index glyphs_glyphsid_idx on pdf.glyphs(glyphs_id);
create index glyphs_glyphs_namesid_idx on pdf.glyphs(fonts_id, glyphs_names_id);
-- ------------------------------------------------

-- --------- Отступы между парами глифов ----------
drop table if exists pdf.kernings cascade;
create table pdf.kernings (
	kernings_id serial primary key,
	fonts_id int4 references pdf.fonts,
	left_glyph_id int4 references pdf.glyphs (glyphs_id),
	rigth_glyph_id int4 references pdf.glyphs (glyphs_id),
	kerning int4
);
create index kernings_kerningsid_idx on pdf.kernings(kernings_id);
create index kernings_glyphspair_idx on pdf.kernings(fonts_id, left_glyph_id, rigth_glyph_id);
-- ------------------------------------------------