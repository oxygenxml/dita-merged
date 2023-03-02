Plugin which uses the DITA Open Toolkit TopicMergeModule to produce a merged output from the entire DITA Map structure without further processing.
It's transtype is called "merged". The DITA Open Toolkit bundled with an Oxygen XML installation should have this plugin pre-installed.

## Possible applications:

The folder "possible-applications" contains two stylesheets, one of them creates an HTML table presenting all topics referenced in the DITA Map and the other one creates a reltable by searching for all related links in the DITA topics. Other possible applications may include applying a spell checker on the entire content, counting words or building various reports based on the XML output. You can also use the output XML with an XSLT stylesheet to produce other kinds of output format.


Copyright and License
---------------------
Copyright 2018 Syncro Soft SRL.

This project is licensed under [Apache License 2.0](https://github.com/oxygenxml/dita-merged/blob/master/LICENSE)
