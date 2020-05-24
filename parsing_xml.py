#python script to parse the NotarizationStatus.xml and get status of notarization request and also to get Notarization logs.

from xml.dom import minidom
import requests
import os.path
from os import path

if (path.exists('NotarizationStatus.xml')):
    print("Notarization Status xml file exists at the given location")
else:
    print("File doesnt exist")

xmldoc = minidom.parse('NotarizationStatus.xml')
itemlist = xmldoc.getElementsByTagName('key')
if itemlist[0].firstChild.nodeValue == "notarization-info":
    stringval = xmldoc.getElementsByTagName('string')
    print(stringval[0].firstChild.nodeValue)
    response = requests.get(stringval[0].firstChild.nodeValue)
    response.json()
    with open('NotarizationLogs.txt', mode = 'wb') as file:
        file.write(response.content)
        response.json()

    print("printing status")
    if stringval[2].firstChild.nodeValue == 'invalid':
        print(stringval[2].firstChild.nodeValue)
    elif stringval[2].firstChild.nodeValue == 'in progress':
        print("processing...")
    else:
        print("The Notarization request was successful. App/pkg is notarized")
else:
    print("Notarization request was incorrect")