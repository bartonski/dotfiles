#! /bin/sed

# Translate html anchors to mediawiki links
s/<a href="/* [[/
s/">/|/
s/<.a>.*/]]/
