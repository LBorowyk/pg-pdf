import os
from prepareFonts.saveFontToXml import saveFontToXml
from others import fontList

saveFontToXml(fontList.fontnames, os.path.join('..', 'fonts'), os.path.join('..', 'xml_fonts'))