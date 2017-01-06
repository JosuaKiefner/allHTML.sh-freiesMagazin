#! /bin/bash
OUTPUT_DIR=.
INDEXER_JAR=lib/webhelpindexer.jar
TAGSOUP_JAR=lib/tagsoup-1.2.1.jar
LUCENE_ANALYZER_JAR=lib/lucene-analyzers-3.0.0.jar
LUCENE_CORE_JAR=lib/lucene-core-3.0.0.jar
XERCES=lib/xercesImpl.jar
XERCES_API=lib/xml-apis.jar
SAXON=lib/saxon6.5.5.jar
INDEXER_EXCLUDED_FILES=start.html searchresult.html
CLASSPATH=$XERCES:$XERCES_API:$INDEXER_JAR:$TAGSOUP_JAR:$LUCENE_ANALYZER_JAR:$LUCENE_CORE_JAR

java -cp $TAGSOUP_JAR:$SAXON:$INDEXER_JAR:$LUCENE_ANALYZER_JAR:$LUCENE_CORE_JAR:$XERCES:$XERCES_API \
-DhtmlDir=$OUTPUT_DIR \
-DindexerLanguage=de \
-DdoStem=true \
-Dorg.xml.sax.driver=org.ccil.cowan.tagsoup.Parser \
-Djavax.xml.parsers.SAXParserFactory=org.ccil.cowan.tagsoup.jaxp.SAXFactoryImpl \
-DindexerExcludedFiles=$INDEXER_EXCLUDED_FILES \
com.nexwave.nquindexer.IndexerMain
