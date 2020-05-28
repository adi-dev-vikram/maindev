#python script to parse the xml and get status of request using requests lib

from xml.dom import minidom
import requests
import os.path
from os import path

if (path.exists('FileName.xml')):
    print("Notarization Status xml file exists at the given location")
else:
    print("File doesnt exist")

xmldoc = minidom.parse('NameOfFile.xml')
itemlist = xmldoc.getElementsByTagName('key')
if itemlist[0].firstChild.nodeValue == "tag_name":
    stringval = xmldoc.getElementsByTagName('string')
    print(stringval[0].firstChild.nodeValue)
    response = requests.get(stringval[0].firstChild.nodeValue)
    response.json()
    with open('Filetowrite.txt', mode = 'wb') as file:
        file.write(response.content)
        response.json()

    print("printing status")
    if stringval[2].firstChild.nodeValue == 'invalid':
        print(stringval[2].firstChild.nodeValue)
    elif stringval[2].firstChild.nodeValue == 'in progress':
        print("processing...")
    else:
        print("The request was successful.")
else:
    print(" Request was incorrect")
