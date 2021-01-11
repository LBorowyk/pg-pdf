from fontTools.ttLib import TTFont
import os

def getFullFileName(fileName, directoryName, ext):
    return os.path.join(directoryName, fileName + '.' + ext)

def createDirectoryIfNotExists(directoryName):
    if not os.path.exists(directoryName):
        os.makedirs(directoryName)
    print('directory', directoryName)

def saveFontToXml(fontNames, fontsDirectoryName, xmlDirectoryName):
    createDirectoryIfNotExists(xmlDirectoryName)
    for fontName in fontNames:
        font = TTFont(getFullFileName(fontName, fontsDirectoryName, 'ttf'))
        font.saveXML(getFullFileName(fontName, xmlDirectoryName, 'xml'))
