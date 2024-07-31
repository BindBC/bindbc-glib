/+
+               Copyright 2024 Aya Partridge
+ Distributed under the Boost Software License, Version 1.0.
+     (See accompanying file LICENSE_1_0.txt or copy at
+           http://www.boost.org/LICENSE_1_0.txt)
+/
module glib.unicode;

import bindbc.glib.config;
import bindbc.glib.codegen;

import glib.error;
import glib.types;

mixin(makeEnumBind(q{GUnicodeType}, aliases: [q{GUnicode}], members: (){
	EnumMember[] ret = [
		{{q{control},             q{G_UNICODE_CONTROL}}},
		{{q{format},              q{G_UNICODE_FORMAT}}},
		{{q{unassigned},          q{G_UNICODE_UNASSIGNED}}},
		{{q{privateUse},          q{G_UNICODE_PRIVATE_USE}}},
		{{q{surrogate},           q{G_UNICODE_SURROGATE}}},
		{{q{lowercaseLetter},     q{G_UNICODE_LOWERCASE_LETTER}}},
		{{q{modifierLetter},      q{G_UNICODE_MODIFIER_LETTER}}},
		{{q{otherLetter},         q{G_UNICODE_OTHER_LETTER}}},
		{{q{titleCaseLetter},     q{G_UNICODE_TITLECASE_LETTER}}},
		{{q{uppercaseLetter},     q{G_UNICODE_UPPERCASE_LETTER}}},
		{{q{spacingMark},         q{G_UNICODE_SPACING_MARK}}, aliases: [{q{combiningMark}, q{G_UNICODE_COMBINING_MARK}}]},
		{{q{enclosingMark},       q{G_UNICODE_ENCLOSING_MARK}}},
		{{q{nonSpacingMark},      q{G_UNICODE_NON_SPACING_MARK}}},
		{{q{decimalNumber},       q{G_UNICODE_DECIMAL_NUMBER}}},
		{{q{letterNumber},        q{G_UNICODE_LETTER_NUMBER}}},
		{{q{otherNumber},         q{G_UNICODE_OTHER_NUMBER}}},
		{{q{connectPunctuation},  q{G_UNICODE_CONNECT_PUNCTUATION}}},
		{{q{dashPunctuation},     q{G_UNICODE_DASH_PUNCTUATION}}},
		{{q{closePunctuation},    q{G_UNICODE_CLOSE_PUNCTUATION}}},
		{{q{finalPunctuation},    q{G_UNICODE_FINAL_PUNCTUATION}}},
		{{q{initialPunctuation},  q{G_UNICODE_INITIAL_PUNCTUATION}}},
		{{q{otherPunctuation},    q{G_UNICODE_OTHER_PUNCTUATION}}},
		{{q{openPunctuation},     q{G_UNICODE_OPEN_PUNCTUATION}}},
		{{q{currencySymbol},      q{G_UNICODE_CURRENCY_SYMBOL}}},
		{{q{modifierSymbol},      q{G_UNICODE_MODIFIER_SYMBOL}}},
		{{q{mathsSymbol},         q{G_UNICODE_MATHS_SYMBOL}}, aliases: [{q{mathSymbol}, q{G_UNICODE_MATH_SYMBOL}}]},
		{{q{otherSymbol},         q{G_UNICODE_OTHER_SYMBOL}}},
		{{q{lineSeparator},       q{G_UNICODE_LINE_SEPARATOR}}},
		{{q{paragraphSeparator},  q{G_UNICODE_PARAGRAPH_SEPARATOR}}},
		{{q{spaceSeparator},      q{G_UNICODE_SPACE_SEPARATOR}}},
	];
	return ret;
}()));

mixin(makeEnumBind(q{GUnicodeBreakType}, aliases: [q{GUnicodeBreak}], members: (){
	EnumMember[] ret = [
		{{q{mandatory},                     q{G_UNICODE_BREAK_MANDATORY}}},
		{{q{carriageReturn},                q{G_UNICODE_BREAK_CARRIAGE_RETURN}}},
		{{q{lineFeed},                      q{G_UNICODE_BREAK_LINE_FEED}}},
		{{q{combiningMark},                 q{G_UNICODE_BREAK_COMBINING_MARK}}},
		{{q{surrogate},                     q{G_UNICODE_BREAK_SURROGATE}}},
		{{q{zeroWidthSpace},                q{G_UNICODE_BREAK_ZERO_WIDTH_SPACE}}},
		{{q{inseparable},                   q{G_UNICODE_BREAK_INSEPARABLE}}},
		{{q{nonBreakingGlue},               q{G_UNICODE_BREAK_NON_BREAKING_GLUE}}},
		{{q{contingent},                    q{G_UNICODE_BREAK_CONTINGENT}}},
		{{q{space},                         q{G_UNICODE_BREAK_SPACE}}},
		{{q{after},                         q{G_UNICODE_BREAK_AFTER}}},
		{{q{before},                        q{G_UNICODE_BREAK_BEFORE}}},
		{{q{beforeAndAfter},                q{G_UNICODE_BREAK_BEFORE_AND_AFTER}}},
		{{q{hyphen},                        q{G_UNICODE_BREAK_HYPHEN}}},
		{{q{nonStarter},                    q{G_UNICODE_BREAK_NON_STARTER}}},
		{{q{openPunctuation},               q{G_UNICODE_BREAK_OPEN_PUNCTUATION}}},
		{{q{closePunctuation},              q{G_UNICODE_BREAK_CLOSE_PUNCTUATION}}},
		{{q{quotation},                     q{G_UNICODE_BREAK_QUOTATION}}},
		{{q{exclamation},                   q{G_UNICODE_BREAK_EXCLAMATION}}},
		{{q{ideographic},                   q{G_UNICODE_BREAK_IDEOGRAPHIC}}},
		{{q{numeric},                       q{G_UNICODE_BREAK_NUMERIC}}},
		{{q{infixSeparator},                q{G_UNICODE_BREAK_INFIX_SEPARATOR}}},
		{{q{symbol},                        q{G_UNICODE_BREAK_SYMBOL}}},
		{{q{alphabetic},                    q{G_UNICODE_BREAK_ALPHABETIC}}},
		{{q{prefix},                        q{G_UNICODE_BREAK_PREFIX}}},
		{{q{postfix},                       q{G_UNICODE_BREAK_POSTFIX}}},
		{{q{complexContext},                q{G_UNICODE_BREAK_COMPLEX_CONTEXT}}},
		{{q{ambiguous},                     q{G_UNICODE_BREAK_AMBIGUOUS}}},
		{{q{unknown},                       q{G_UNICODE_BREAK_UNKNOWN}}},
		{{q{nextLine},                      q{G_UNICODE_BREAK_NEXT_LINE}}},
		{{q{wordJoiner},                    q{G_UNICODE_BREAK_WORD_JOINER}}},
		{{q{hangulLJamo},                   q{G_UNICODE_BREAK_HANGUL_L_JAMO}}},
		{{q{hangulVJamo},                   q{G_UNICODE_BREAK_HANGUL_V_JAMO}}},
		{{q{hangulTJamo},                   q{G_UNICODE_BREAK_HANGUL_T_JAMO}}},
		{{q{hangulLVSyllable},              q{G_UNICODE_BREAK_HANGUL_LV_SYLLABLE}}},
		{{q{hangulLVTSyllable},             q{G_UNICODE_BREAK_HANGUL_LVT_SYLLABLE}}},
	];
	if(glibVersion >= Version(2,28,0)){
		EnumMember[] add = [
			{{q{closeParenthesis},            q{G_UNICODE_BREAK_CLOSE_PARENTHESIS}}, aliases: [{q{paranthesis}, q{G_UNICODE_BREAK_CLOSE_PARANTHESIS}}]},
		];
		ret ~= add;
	}
	if(glibVersion >= Version(2,32,0)){
		EnumMember[] add = [
			{{q{conditionalJapaneseStarter},  q{G_UNICODE_BREAK_CONDITIONAL_JAPANESE_STARTER}}},
			{{q{hebrewLetter},                q{G_UNICODE_BREAK_HEBREW_LETTER}}},
		];
		ret ~= add;
	}
	if(glibVersion >= Version(2,36,0)){
		EnumMember[] add = [
			{{q{regionalIndicator},           q{G_UNICODE_BREAK_REGIONAL_INDICATOR}}},
		];
		ret ~= add;
	}
	if(glibVersion >= Version(2,50,0)){
		EnumMember[] add = [
			{{q{emojiBase},                   q{G_UNICODE_BREAK_EMOJI_BASE}}},
			{{q{emojiModifier},               q{G_UNICODE_BREAK_EMOJI_MODIFIER}}},
			{{q{zeroWidthJoiner},             q{G_UNICODE_BREAK_ZERO_WIDTH_JOINER}}},
		];
		ret ~= add;
	}
	if(glibVersion >= Version(2,80,0)){
		EnumMember[] add = [
			{{q{aksara},                      q{G_UNICODE_BREAK_AKSARA}}},
			{{q{aksaraPreBase},               q{G_UNICODE_BREAK_AKSARA_PRE_BASE}}},
			{{q{aksaraStart},                 q{G_UNICODE_BREAK_AKSARA_START}}},
			{{q{viramaFinal},                 q{G_UNICODE_BREAK_VIRAMA_FINAL}}},
			{{q{virama},                      q{G_UNICODE_BREAK_VIRAMA}}},
		];
		ret ~= add;
	}
	return ret;
}()));

mixin(makeEnumBind(q{GUnicodeScript}, members: (){
	EnumMember[] ret = [
		{{q{invalidCode},              q{G_UNICODE_SCRIPT_INVALID_CODE}},  q{-1}},
		{{q{common},                   q{G_UNICODE_SCRIPT_COMMON}},        q{0}},
		{{q{inherited},                q{G_UNICODE_SCRIPT_INHERITED}}},
		{{q{arabic},                   q{G_UNICODE_SCRIPT_ARABIC}}},
		{{q{armenian},                 q{G_UNICODE_SCRIPT_ARMENIAN}}},
		{{q{bengali},                  q{G_UNICODE_SCRIPT_BENGALI}}},
		{{q{bopomofo},                 q{G_UNICODE_SCRIPT_BOPOMOFO}}},
		{{q{cherokee},                 q{G_UNICODE_SCRIPT_CHEROKEE}}},
		{{q{coptic},                   q{G_UNICODE_SCRIPT_COPTIC}}},
		{{q{cyrillic},                 q{G_UNICODE_SCRIPT_CYRILLIC}}},
		{{q{deseret},                  q{G_UNICODE_SCRIPT_DESERET}}},
		{{q{devanagari},               q{G_UNICODE_SCRIPT_DEVANAGARI}}},
		{{q{ethiopic},                 q{G_UNICODE_SCRIPT_ETHIOPIC}}},
		{{q{georgian},                 q{G_UNICODE_SCRIPT_GEORGIAN}}},
		{{q{gothic},                   q{G_UNICODE_SCRIPT_GOTHIC}}},
		{{q{greek},                    q{G_UNICODE_SCRIPT_GREEK}}},
		{{q{gujarati},                 q{G_UNICODE_SCRIPT_GUJARATI}}},
		{{q{gurmukhi},                 q{G_UNICODE_SCRIPT_GURMUKHI}}},
		{{q{han},                      q{G_UNICODE_SCRIPT_HAN}}},
		{{q{hangul},                   q{G_UNICODE_SCRIPT_HANGUL}}},
		{{q{hebrew},                   q{G_UNICODE_SCRIPT_HEBREW}}},
		{{q{hiragana},                 q{G_UNICODE_SCRIPT_HIRAGANA}}},
		{{q{kannada},                  q{G_UNICODE_SCRIPT_KANNADA}}},
		{{q{katakana},                 q{G_UNICODE_SCRIPT_KATAKANA}}},
		{{q{khmer},                    q{G_UNICODE_SCRIPT_KHMER}}},
		{{q{lao},                      q{G_UNICODE_SCRIPT_LAO}}},
		{{q{latin},                    q{G_UNICODE_SCRIPT_LATIN}}},
		{{q{malayalam},                q{G_UNICODE_SCRIPT_MALAYALAM}}},
		{{q{mongolian},                q{G_UNICODE_SCRIPT_MONGOLIAN}}},
		{{q{myanmar},                  q{G_UNICODE_SCRIPT_MYANMAR}}},
		{{q{ogham},                    q{G_UNICODE_SCRIPT_OGHAM}}},
		{{q{oldItalic},                q{G_UNICODE_SCRIPT_OLD_ITALIC}}},
		{{q{oriya},                    q{G_UNICODE_SCRIPT_ORIYA}}},
		{{q{runic},                    q{G_UNICODE_SCRIPT_RUNIC}}},
		{{q{sinhala},                  q{G_UNICODE_SCRIPT_SINHALA}}},
		{{q{syriac},                   q{G_UNICODE_SCRIPT_SYRIAC}}},
		{{q{tamil},                    q{G_UNICODE_SCRIPT_TAMIL}}},
		{{q{telugu},                   q{G_UNICODE_SCRIPT_TELUGU}}},
		{{q{thaana},                   q{G_UNICODE_SCRIPT_THAANA}}},
		{{q{thai},                     q{G_UNICODE_SCRIPT_THAI}}},
		{{q{tibetan},                  q{G_UNICODE_SCRIPT_TIBETAN}}},
		{{q{canadianAboriginal},       q{G_UNICODE_SCRIPT_CANADIAN_ABORIGINAL}}},
		{{q{yi},                       q{G_UNICODE_SCRIPT_YI}}},
		{{q{tagalog},                  q{G_UNICODE_SCRIPT_TAGALOG}}},
		{{q{hanunoo},                  q{G_UNICODE_SCRIPT_HANUNOO}}},
		{{q{buhid},                    q{G_UNICODE_SCRIPT_BUHID}}},
		{{q{tagbanwa},                 q{G_UNICODE_SCRIPT_TAGBANWA}}},
		
		{{q{braille},                  q{G_UNICODE_SCRIPT_BRAILLE}}},
		{{q{cypriot},                  q{G_UNICODE_SCRIPT_CYPRIOT}}},
		{{q{limbu},                    q{G_UNICODE_SCRIPT_LIMBU}}},
		{{q{osmanya},                  q{G_UNICODE_SCRIPT_OSMANYA}}},
		{{q{shavian},                  q{G_UNICODE_SCRIPT_SHAVIAN}}},
		{{q{linearB},                  q{G_UNICODE_SCRIPT_LINEAR_B}}},
		{{q{taiLe},                    q{G_UNICODE_SCRIPT_TAI_LE}}},
		{{q{ugaritic},                 q{G_UNICODE_SCRIPT_UGARITIC}}},

		{{q{newTaiLue},                q{G_UNICODE_SCRIPT_NEW_TAI_LUE}}},
		{{q{buginese},                 q{G_UNICODE_SCRIPT_BUGINESE}}},
		{{q{glagolitic},               q{G_UNICODE_SCRIPT_GLAGOLITIC}}},
		{{q{tifinagh},                 q{G_UNICODE_SCRIPT_TIFINAGH}}},
		{{q{sylotiNagri},              q{G_UNICODE_SCRIPT_SYLOTI_NAGRI}}},
		{{q{oldPersian},               q{G_UNICODE_SCRIPT_OLD_PERSIAN}}},
		{{q{kharoshthi},               q{G_UNICODE_SCRIPT_KHAROSHTHI}}},
		
		{{q{unknown},                  q{G_UNICODE_SCRIPT_UNKNOWN}}},
		{{q{balinese},                 q{G_UNICODE_SCRIPT_BALINESE}}},
		{{q{cuneiform},                q{G_UNICODE_SCRIPT_CUNEIFORM}}},
		{{q{phoenician},               q{G_UNICODE_SCRIPT_PHOENICIAN}}},
		{{q{phagsPa},                  q{G_UNICODE_SCRIPT_PHAGS_PA}}},
		{{q{nko},                      q{G_UNICODE_SCRIPT_NKO}}},
	];
	if(glibVersion >= Version(2,16,3)){
		EnumMember[] add = [
			{{q{kayahLi},                q{G_UNICODE_SCRIPT_KAYAH_LI}}},
			{{q{lepcha},                 q{G_UNICODE_SCRIPT_LEPCHA}}},
			{{q{rejang},                 q{G_UNICODE_SCRIPT_REJANG}}},
			{{q{sundanese},              q{G_UNICODE_SCRIPT_SUNDANESE}}},
			{{q{saurashtra},             q{G_UNICODE_SCRIPT_SAURASHTRA}}},
			{{q{cham},                   q{G_UNICODE_SCRIPT_CHAM}}},
			{{q{olChiki},                q{G_UNICODE_SCRIPT_OL_CHIKI}}},
			{{q{vai},                    q{G_UNICODE_SCRIPT_VAI}}},
			{{q{carian},                 q{G_UNICODE_SCRIPT_CARIAN}}},
			{{q{lycian},                 q{G_UNICODE_SCRIPT_LYCIAN}}},
			{{q{lydian},                 q{G_UNICODE_SCRIPT_LYDIAN}}},
		];
		ret ~= add;
	}
	if(glibVersion >= Version(2,26,0)){
		EnumMember[] add = [
			{{q{avestan},                q{G_UNICODE_SCRIPT_AVESTAN}}},
			{{q{bamum},                  q{G_UNICODE_SCRIPT_BAMUM}}},
			{{q{egyptianHieroglyphs},    q{G_UNICODE_SCRIPT_EGYPTIAN_HIEROGLYPHS}}},
			{{q{imperialAramaic},        q{G_UNICODE_SCRIPT_IMPERIAL_ARAMAIC}}},
			{{q{inscriptionalPahlavi},   q{G_UNICODE_SCRIPT_INSCRIPTIONAL_PAHLAVI}}},
			{{q{inscriptionalParthian},  q{G_UNICODE_SCRIPT_INSCRIPTIONAL_PARTHIAN}}},
			{{q{javanese},               q{G_UNICODE_SCRIPT_JAVANESE}}},
			{{q{kaithi},                 q{G_UNICODE_SCRIPT_KAITHI}}},
			{{q{lisu},                   q{G_UNICODE_SCRIPT_LISU}}},
			{{q{meeteiMayek},            q{G_UNICODE_SCRIPT_MEETEI_MAYEK}}},
			{{q{oldSouthArabian},        q{G_UNICODE_SCRIPT_OLD_SOUTH_ARABIAN}}},
			{{q{oldTurkic},              q{G_UNICODE_SCRIPT_OLD_TURKIC}}},
			{{q{samaritan},              q{G_UNICODE_SCRIPT_SAMARITAN}}},
			{{q{taiTham},                q{G_UNICODE_SCRIPT_TAI_THAM}}},
			{{q{taiViet},                q{G_UNICODE_SCRIPT_TAI_VIET}}},
		];
		ret ~= add;
	}
	if(glibVersion >= Version(2,28,0)){
		EnumMember[] add = [
			{{q{batak},                  q{G_UNICODE_SCRIPT_BATAK}}},
			{{q{brahmi},                 q{G_UNICODE_SCRIPT_BRAHMI}}},
			{{q{mandaic},                q{G_UNICODE_SCRIPT_MANDAIC}}},
		];
		ret ~= add;
	}
	if(glibVersion >= Version(2,32,0)){
		EnumMember[] add = [
			{{q{chakma},                 q{G_UNICODE_SCRIPT_CHAKMA}}},
			{{q{meroiticCursive},        q{G_UNICODE_SCRIPT_MEROITIC_CURSIVE}}},
			{{q{meroiticHieroglyphs},    q{G_UNICODE_SCRIPT_MEROITIC_HIEROGLYPHS}}},
			{{q{miao},                   q{G_UNICODE_SCRIPT_MIAO}}},
			{{q{sharada},                q{G_UNICODE_SCRIPT_SHARADA}}},
			{{q{soraSompeng},            q{G_UNICODE_SCRIPT_SORA_SOMPENG}}},
			{{q{takri},                  q{G_UNICODE_SCRIPT_TAKRI}}},
		];
		ret ~= add;
	}
	if(glibVersion >= Version(2,42,0)){
		EnumMember[] add = [
			{{q{bassaVah},               q{G_UNICODE_SCRIPT_BASSA_VAH}}},
			{{q{caucasianAlbanian},      q{G_UNICODE_SCRIPT_CAUCASIAN_ALBANIAN}}},
			{{q{duployan},               q{G_UNICODE_SCRIPT_DUPLOYAN}}},
			{{q{elbasan},                q{G_UNICODE_SCRIPT_ELBASAN}}},
			{{q{grantha},                q{G_UNICODE_SCRIPT_GRANTHA}}},
			{{q{khojki},                 q{G_UNICODE_SCRIPT_KHOJKI}}},
			{{q{khudawadi},              q{G_UNICODE_SCRIPT_KHUDAWADI}}},
			{{q{linearA},                q{G_UNICODE_SCRIPT_LINEAR_A}}},
			{{q{mahajani},               q{G_UNICODE_SCRIPT_MAHAJANI}}},
			{{q{manichaean},             q{G_UNICODE_SCRIPT_MANICHAEAN}}},
			{{q{mendeKikakui},           q{G_UNICODE_SCRIPT_MENDE_KIKAKUI}}},
			{{q{modi},                   q{G_UNICODE_SCRIPT_MODI}}},
			{{q{mro},                    q{G_UNICODE_SCRIPT_MRO}}},
			{{q{nabataean},              q{G_UNICODE_SCRIPT_NABATAEAN}}},
			{{q{oldNorthArabian},        q{G_UNICODE_SCRIPT_OLD_NORTH_ARABIAN}}},
			{{q{oldPermic},              q{G_UNICODE_SCRIPT_OLD_PERMIC}}},
			{{q{pahawhHmong},            q{G_UNICODE_SCRIPT_PAHAWH_HMONG}}},
			{{q{palmyrene},              q{G_UNICODE_SCRIPT_PALMYRENE}}},
			{{q{pauCinHau},              q{G_UNICODE_SCRIPT_PAU_CIN_HAU}}},
			{{q{psalterPahlavi},         q{G_UNICODE_SCRIPT_PSALTER_PAHLAVI}}},
			{{q{siddham},                q{G_UNICODE_SCRIPT_SIDDHAM}}},
			{{q{tirhuta},                q{G_UNICODE_SCRIPT_TIRHUTA}}},
			{{q{warangCiti},             q{G_UNICODE_SCRIPT_WARANG_CITI}}},
		];
		ret ~= add;
	}
	if(glibVersion >= Version(2,48,0)){
		EnumMember[] add = [
			{{q{ahom},                   q{G_UNICODE_SCRIPT_AHOM}}},
			{{q{anatolianHieroglyphs},   q{G_UNICODE_SCRIPT_ANATOLIAN_HIEROGLYPHS}}},
			{{q{hatran},                 q{G_UNICODE_SCRIPT_HATRAN}}},
			{{q{multani},                q{G_UNICODE_SCRIPT_MULTANI}}},
			{{q{oldHungarian},           q{G_UNICODE_SCRIPT_OLD_HUNGARIAN}}},
			{{q{signwriting},            q{G_UNICODE_SCRIPT_SIGNWRITING}}},
		];
		ret ~= add;
	}
	if(glibVersion >= Version(2,50,0)){
		EnumMember[] add = [
			{{q{adlam},                  q{G_UNICODE_SCRIPT_ADLAM}}},
			{{q{bhaiksuki},              q{G_UNICODE_SCRIPT_BHAIKSUKI}}},
			{{q{marchen},                q{G_UNICODE_SCRIPT_MARCHEN}}},
			{{q{newa},                   q{G_UNICODE_SCRIPT_NEWA}}},
			{{q{osage},                  q{G_UNICODE_SCRIPT_OSAGE}}},
			{{q{tangut},                 q{G_UNICODE_SCRIPT_TANGUT}}},
		];
		ret ~= add;
	}
	if(glibVersion >= Version(2,54,0)){
		EnumMember[] add = [
			{{q{masaramGondi},           q{G_UNICODE_SCRIPT_MASARAM_GONDI}}},
			{{q{nushu},                  q{G_UNICODE_SCRIPT_NUSHU}}},
			{{q{soyombo},                q{G_UNICODE_SCRIPT_SOYOMBO}}},
			{{q{zanabazarSquare},        q{G_UNICODE_SCRIPT_ZANABAZAR_SQUARE}}},
		];
		ret ~= add;
	}
	if(glibVersion >= Version(2,58,0)){
		EnumMember[] add = [
			{{q{dogra},                  q{G_UNICODE_SCRIPT_DOGRA}}},
			{{q{gunjalaGondi},           q{G_UNICODE_SCRIPT_GUNJALA_GONDI}}},
			{{q{hanifiRohingya},         q{G_UNICODE_SCRIPT_HANIFI_ROHINGYA}}},
			{{q{makasar},                q{G_UNICODE_SCRIPT_MAKASAR}}},
			{{q{medefaidrin},            q{G_UNICODE_SCRIPT_MEDEFAIDRIN}}},
			{{q{oldSogdian},             q{G_UNICODE_SCRIPT_OLD_SOGDIAN}}},
			{{q{sogdian},                q{G_UNICODE_SCRIPT_SOGDIAN}}},
		];
		ret ~= add;
	}
	if(glibVersion >= Version(2,62,0)){
		EnumMember[] add = [
			{{q{elymaic},                q{G_UNICODE_SCRIPT_ELYMAIC}}},
			{{q{nandinagari},            q{G_UNICODE_SCRIPT_NANDINAGARI}}},
			{{q{nyiakengPuachueHmong},   q{G_UNICODE_SCRIPT_NYIAKENG_PUACHUE_HMONG}}},
			{{q{wancho},                 q{G_UNICODE_SCRIPT_WANCHO}}},
		];
		ret ~= add;
	}
	if(glibVersion >= Version(2,66,0)){
		EnumMember[] add = [
			{{q{chorasmian},             q{G_UNICODE_SCRIPT_CHORASMIAN}}},
			{{q{divesAkuru},             q{G_UNICODE_SCRIPT_DIVES_AKURU}}},
			{{q{khitanSmallScript},      q{G_UNICODE_SCRIPT_KHITAN_SMALL_SCRIPT}}},
			{{q{yezidi},                 q{G_UNICODE_SCRIPT_YEZIDI}}},
		];
		ret ~= add;
	}
	if(glibVersion >= Version(2,72,0)){
		EnumMember[] add = [
			{{q{cyproMinoan},            q{G_UNICODE_SCRIPT_CYPRO_MINOAN}}},
			{{q{oldUyghur},              q{G_UNICODE_SCRIPT_OLD_UYGHUR}}},
			{{q{tangsa},                 q{G_UNICODE_SCRIPT_TANGSA}}},
			{{q{toto},                   q{G_UNICODE_SCRIPT_TOTO}}},
			{{q{vithkuqi},               q{G_UNICODE_SCRIPT_VITHKUQI}}},
			{{q{maths},                  q{G_UNICODE_SCRIPT_MATHS}}, aliases: [{q{math}, q{G_UNICODE_SCRIPT_MATH}}]},
		];
		ret ~= add;
	}
	if(glibVersion >= Version(2,74,0)){
		EnumMember[] add = [
			{{q{kawi},                   q{G_UNICODE_SCRIPT_KAWI}}},
			{{q{nagMundari},             q{G_UNICODE_SCRIPT_NAG_MUNDARI}}},
		];
		ret ~= add;
	}
	return ret;
}()));

enum G_UNICHAR_MAX_DECOMPOSITION_LENGTH = 18;

mixin(makeEnumBind(q{GNormaliseMode}, aliases: [q{GNormalizeMode}], members: (){
	EnumMember[] ret = [
		{{q{default_},        q{G_NORMALISE_DEFAULT}}, aliases: [{q{nfd}, q{G_NORMALISE_NFD}}, {c: q{G_NORMALIZE_NFD}}, {c: q{G_NORMALIZE_DEFAULT}}]},
		{{q{defaultCompose},  q{G_NORMALISE_DEFAULT_COMPOSE}}, aliases: [{q{nfc}, q{G_NORMALISE_NFC}}, {c: q{G_NORMALIZE_NFC}}, {c: q{G_NORMALIZE_DEFAULT_COMPOSE}}]},
		{{q{all},             q{G_NORMALISE_ALL}}, aliases: [{q{nfkd}, q{G_NORMALISE_NFKD}}, {c: q{G_NORMALIZE_NFKD}}, {c: q{G_NORMALIZE_ALL}}]},
		{{q{allCompose},      q{G_NORMALISE_ALL_COMPOSE}}, aliases: [{q{nfkc}, q{G_NORMALISE_NFKC}}, {c: q{G_NORMALIZE_NFKC}}, {c: q{G_NORMALIZE_ALL_COMPOSE}}]},
	];
	return ret;
}()));

mixin(joinFnBinds((){
	FnBind[] ret = [
		{q{uint}, q{g_unicode_script_to_iso15924}, q{GUnicodeScript script}},
		{q{GUnicodeScript}, q{g_unicode_script_from_iso15924}, q{uint iso15924}},
		{q{gboolean}, q{g_unichar_isalnum}, q{dchar c}, attr: q{pure}},
		{q{gboolean}, q{g_unichar_isalpha}, q{dchar c}, attr: q{pure}},
		{q{gboolean}, q{g_unichar_iscntrl}, q{dchar c}, attr: q{pure}},
		{q{gboolean}, q{g_unichar_isdigit}, q{dchar c}, attr: q{pure}},
		{q{gboolean}, q{g_unichar_isgraph}, q{dchar c}, attr: q{pure}},
		{q{gboolean}, q{g_unichar_islower}, q{dchar c}, attr: q{pure}},
		{q{gboolean}, q{g_unichar_isprint}, q{dchar c}, attr: q{pure}},
		{q{gboolean}, q{g_unichar_ispunct}, q{dchar c}, attr: q{pure}},
		{q{gboolean}, q{g_unichar_isspace}, q{dchar c}, attr: q{pure}},
		{q{gboolean}, q{g_unichar_isupper}, q{dchar c}, attr: q{pure}},
		{q{gboolean}, q{g_unichar_isxdigit}, q{dchar c}, attr: q{pure}},
		{q{gboolean}, q{g_unichar_istitle}, q{dchar c}, attr: q{pure}},
		{q{gboolean}, q{g_unichar_isdefined}, q{dchar c}, attr: q{pure}},
		{q{gboolean}, q{g_unichar_iswide}, q{dchar c}, attr: q{pure}},
		{q{gboolean}, q{g_unichar_iswide_cjk}, q{dchar c}, attr: q{pure}},
		{q{gboolean}, q{g_unichar_iszerowidth}, q{dchar c}, attr: q{pure}},
		{q{gboolean}, q{g_unichar_ismark}, q{dchar c}, attr: q{pure}},
		{q{dchar}, q{g_unichar_toupper}, q{dchar c}, attr: q{pure}},
		{q{dchar}, q{g_unichar_tolower}, q{dchar c}, attr: q{pure}},
		{q{dchar}, q{g_unichar_totitle}, q{dchar c}, attr: q{pure}},
		{q{int}, q{g_unichar_digit_value}, q{dchar c}, attr: q{pure}},
		{q{int}, q{g_unichar_xdigit_value}, q{dchar c}, attr: q{pure}},
		{q{GUnicodeType}, q{g_unichar_type}, q{dchar c}, attr: q{pure}},
		{q{GUnicodeBreakType}, q{g_unichar_break_type}, q{dchar c}, attr: q{pure}},
		{q{int}, q{g_unichar_combining_class}, q{dchar uc}, attr: q{pure}},
		{q{gboolean}, q{g_unichar_get_mirror_char}, q{dchar ch, dchar* mirroredCh}},
		{q{GUnicodeScript}, q{g_unichar_get_script}, q{dchar ch}, attr: q{pure}},
		{q{gboolean}, q{g_unichar_validate}, q{dchar ch}, attr: q{pure}},
		{q{gboolean}, q{g_unichar_compose}, q{dchar a, dchar b, dchar* ch}},
		{q{gboolean}, q{g_unichar_decompose}, q{dchar ch, dchar* a, dchar* b}},
		{q{size_t}, q{g_unichar_fully_decompose}, q{dchar ch, gboolean compat, dchar* result, size_t resultLen}},
		{q{void}, q{g_unicode_canonical_ordering}, q{dchar* string, size_t len}},
		{q{dchar}, q{g_utf8_get_char}, q{const(char)* p}},
		{q{dchar}, q{g_utf8_get_char_validated}, q{const(char)* p, ptrdiff_t maxLen}},
		{q{char*}, q{g_utf8_offset_to_pointer}, q{const(char)* str, c_long offset}},
		{q{c_long}, q{g_utf8_pointer_to_offset}, q{const(char)* str, const(char)* pos}},
		{q{char*}, q{g_utf8_prev_char}, q{const(char)* p}},
		{q{char*}, q{g_utf8_find_next_char}, q{const(char)* p, const(char)* end}},
		{q{char*}, q{g_utf8_find_prev_char}, q{const(char)* str, const(char)* p}},
		{q{c_long}, q{g_utf8_strlen}, q{const(char)* p, ptrdiff_t max}},
		{q{char*}, q{g_utf8_strncpy}, q{char* dest, const(char)* src, size_t n}},
		{q{char*}, q{g_utf8_strchr}, q{const(char)* p, ptrdiff_t len, dchar c}},
		{q{char*}, q{g_utf8_strrchr}, q{const(char)* p, ptrdiff_t len, dchar c}},
		{q{char*}, q{g_utf8_strreverse}, q{const(char)* str, ptrdiff_t len}},
		{q{wchar*}, q{g_utf8_to_utf16}, q{const(char)* str, c_long len, c_long* itemsRead, c_long* itemsWritten, GError** error}},
		{q{dchar *}, q{g_utf8_to_ucs4}, q{const(char)* str, c_long len, c_long* itemsRead, c_long* itemsWritten, GError** error}},
		{q{dchar *}, q{g_utf8_to_ucs4_fast}, q{const(char)* str, c_long len, c_long* itemsWritten}},
		{q{dchar *}, q{g_utf16_to_ucs4}, q{const(wchar)* str, c_long len, c_long* itemsRead, c_long* itemsWritten, GError** error}},
		{q{char*}, q{g_utf16_to_utf8}, q{const(wchar)* str, c_long len, c_long* itemsRead, c_long* itemsWritten, GError** error}},
		{q{wchar*}, q{g_ucs4_to_utf16}, q{const(dchar)* str, c_long len, c_long* itemsRead, c_long* itemsWritten, GError** error}},
		{q{char*}, q{g_ucs4_to_utf8}, q{const(dchar)* str, c_long len, c_long* itemsRead, c_long* itemsWritten, GError** error}},
		{q{int}, q{g_unichar_to_utf8}, q{dchar c, char* outBuf}},
		{q{gboolean}, q{g_utf8_validate}, q{const(char)* str, ptrdiff_t maxLen, const(char)** end}},
		{q{char*}, q{g_utf8_strup}, q{const(char)* str, ptrdiff_t len}},
		{q{char*}, q{g_utf8_strdown}, q{const(char)* str, ptrdiff_t len}},
		{q{char*}, q{g_utf8_casefold}, q{const(char)* str, ptrdiff_t len}},
		{q{char*}, q{g_utf8_normalize}, q{const(char)* str, ptrdiff_t len, GNormaliseMode mode}, aliases: [q{g_utf8_normalise}]},
		{q{int}, q{g_utf8_collate}, q{const(char)* str1, const(char)* str2}},
		{q{char*}, q{g_utf8_collate_key}, q{const(char)* str, ptrdiff_t len}},
		{q{char*}, q{g_utf8_collate_key_for_filename}, q{const(char)* str, ptrdiff_t len}},
	];
	if(glibVersion >= Version(2,30,0)){
		FnBind[] add = [
			{q{char*}, q{g_utf8_substring}, q{const(char)* str, c_long startPos, c_long endPos}},
		];
		ret ~= add;
	}
	if(glibVersion >= Version(2,52,0)){
		FnBind[] add = [
			{q{char*}, q{g_utf8_make_valid}, q{const(char)* str, ptrdiff_t len}},
		];
		ret ~= add;
	}
	if(glibVersion >= Version(2,60,0)){
		FnBind[] add = [
			{q{gboolean}, q{g_utf8_validate_len}, q{const(char)* str, size_t maxLen, const(char)** end}},
		];
		ret ~= add;
	}
	if(glibVersion >= Version(2,78,0)){
		FnBind[] add = [
			{q{char*}, q{g_utf8_truncate_middle}, q{const(char)* string, size_t truncateLength}},
		];
		ret ~= add;
	}
	return ret;
}()));
