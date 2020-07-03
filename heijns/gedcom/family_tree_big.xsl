<?xml version="1.0"?>
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:fo="http://www.w3.org/1999/XSL/Format">

    <xsl:template match="/">
<fo:root xmlns:fo="http://www.w3.org/1999/XSL/Format">
        <HTML>
            <BODY>
                <FONT FACE="Ariel Narrow">
                    <xsl:for-each select="FAMILY_TREE">
                        <xsl:for-each select="PERSON">
                            <xsl:sort select="NAME/FAMILY_NAME"/>
                                <xsl:sort select="NAME/GIVEN_NAMES"/>
                                          <xsl:element name="a">
                                               <xsl:attribute name="name">#<xsl:value-of select="@idno"/>-<xsl:value-of select="NAME/FAMILY_NAME"/>
                                               </xsl:attribute>
                                          </xsl:element>
                        <!--        <H4>    -->
                                    <FONT COLOR="red" SIZE="6">
                                        <B>
                                            <xsl:value-of select="NAME"/>
                                        </B>
                                        <I>
                                            (<xsl:value-of select="SEX"/>)
                                        </I>
                                    </FONT>
<!--                                </H4>    -->
                                <HR size="2" color="black"></HR>
                              <xsl:if test="EVENT[(@type = 'Birth')] | RELATIONSHIP[@type='ChildOfFather'] |
                                                                           RELATIONSHIP[@type='ChildOfMother']">
                                    <BR/>
                                    <FONT SIZE="4">
                                         Birth details
                                    </FONT>
                                    <BR/>
                              </xsl:if>
                              <fo:block font-size="30pt" text-indent="15pt">
                                  <xsl:for-each select="EVENT[@type='Birth']/DATE">
                                      <I>
                                           Date of Birth: 
                                      </I>
                                      <B>
                                      <xsl:value-of select="."/>
                                      </B>
                                      <BR/>
                                      </xsl:for-each>
                                      <xsl:for-each select="EVENT[@type='Birth']/PLACE">
                                            <I>
                                                 Place of Birth:  
                                            </I>
                                            <B>
                                           <xsl:value-of select="."/>
                                            </B>
                                            <BR/>
                                      </xsl:for-each>
                                      <xsl:for-each select="RELATIONSHIP[@type='ChildOfFather']">
                                          <I>
                                               Father:
                                          </I>
                                          <xsl:element name="a">
                                               <xsl:attribute name="href">#<xsl:value-of select="@linkto"/>
                                               </xsl:attribute>
                                               <B>
                                               <xsl:value-of select="NAME"/>
                                               </B>
                                               <BR/>
                                          </xsl:element>
                                      </xsl:for-each>
                                      <xsl:for-each select="RELATIONSHIP[@type='ChildOfMother']">
                                          <I>
                                               Mother:
                                          </I>
                                          <xsl:element name="a">
                                               <xsl:attribute name="href">#<xsl:value-of select="@linkto"/>
                                               </xsl:attribute>
                                               <B>
                                               <xsl:value-of select="NAME"/>
                                               </B>
                                               <BR/>
                                           </xsl:element>
                                      </xsl:for-each>
                                  </fo:block>
                             <xsl:for-each select="EVENT[(@type = 'Baptism')]">
                                <BR/>
                                <FONT SIZE="4">
                                     Baptism details
                                </FONT>
                                <BR/>
                              <fo:block font-size="30pt" text-indent="15pt">
                                <xsl:for-each select="DATE">
                                <I>
                                     Date of Baptism: 
                                </I>
                                <B>
                                     <xsl:value-of select="."/>
                                </B>
                                <BR/>
                                </xsl:for-each>
                                <xsl:for-each select="PLACE">
                                <I>
                                     Place of Baptism:  
                                </I>
                                <B>
                                     <xsl:value-of select="."/>
                                </B>
                                <BR/>
                                </xsl:for-each>
                              </fo:block>
                            </xsl:for-each>
                            <xsl:for-each select="EVENT[(@type = 'Marriage')]">
                                <xsl:variable name="family" select="@family"/>
                                <BR/>
                                <FONT SIZE="4">
                                     Marriage details
                                </FONT>
                                <BR/>
                                <xsl:for-each select="DATE">
                                    <I>
                                         Date of Marriage: 
                                    </I>
                                    <B>
                                         <xsl:value-of select="."/>
                                    </B>
                                    <BR/>
                                </xsl:for-each>
                                <xsl:for-each select="PLACE">
                                    <I>
                                         Place of Marriage:  
                                    </I>
                                    <B>
                                         <xsl:value-of select="."/>
                                    </B>
                                    <BR/>
                                </xsl:for-each>
                                <xsl:for-each select="../RELATIONSHIP[@type='SpouseOf']">
                                    <xsl:if test="@family=$family">
                                        <I>
                                             Spouse:
                                        </I>
                                        <xsl:element name="a">
                                             <xsl:attribute name="href">#<xsl:value-of select="../RELATIONSHIP[(@family=$family)]/@linkto"/>
                                             </xsl:attribute>
                                             <B>
                                                 <xsl:value-of select="../RELATIONSHIP[(@family=$family)]/NAME"/>
                                             </B>
                                        </xsl:element>
                                        <BR/>
                                     </xsl:if>
                                </xsl:for-each>
                            </xsl:for-each>
                            <xsl:for-each select="RELATIONSHIP[(@type = 'SpouseOf')]">
                                <xsl:variable name="family" select="@family"/>
                                <xsl:if test="not(../EVENT[@family=$family])">
                                    <BR/>
                                    <FONT SIZE="4">
                                         Marriage details
                                    </FONT>
                                    <BR/>
                                    <I>
                                         Spouse:
                                    </I>
                                    <xsl:element name="a">
                                         <xsl:attribute name="href">#<xsl:value-of select="@linkto"/>
                                         </xsl:attribute>
                                         <B>
                                             <xsl:value-of select="NAME"/>
                                         </B>
                                    </xsl:element>
                                    <BR/>
                                </xsl:if>
                            </xsl:for-each>
                            <xsl:for-each select="EVENT[(@type = 'Death')] | EVENT[(@type = 'Burial')]"> 
                                <xsl:variable name="type" select="@type"/>
                                <BR/>
                                <FONT SIZE="4">
                                     <xsl:value-of select="$type"/> details
                                </FONT>
                                <BR/>
                                <xsl:for-each select="DATE">
                                    <I>
                                         Date of <xsl:value-of select="$type"/>: 
                                    </I>
                                    <B>
                                     <xsl:value-of select="."/>
                                    </B>
                                    <BR/>
                                </xsl:for-each>
                                <xsl:for-each select="PLACE">
                                    <I>
                                         Place of <xsl:value-of select="$type"/>: 
                                    </I>
                                    <B>
                                     <xsl:value-of select="."/>
                                    </B>
                                    <BR/>
                                </xsl:for-each>
                            </xsl:for-each>
                            <xsl:for-each select="RELATIONSHIP[@type='ParentOf']">
                                <xsl:if test="position() = 1">
                                    <BR/>
                                    <FONT SIZE="4">
                                        Children 
                                    </FONT>
                                    <BR/>
                                </xsl:if>
                                <xsl:element name="a">
                                     <xsl:attribute name="href">#<xsl:value-of select="@linkto"/>
                                     </xsl:attribute>
                                     <B>
                                          <xsl:value-of select="NAME"/>
                                     </B>
                                     <BR/>
                                 </xsl:element>
                            </xsl:for-each>
            <HR size="2" color="black"></HR>
                         <br></BR>
                        </xsl:for-each>
                    </xsl:for-each>
                    <BR/>
                </FONT>
            </BODY>
 <!--           <IMG SRC="E:\Perl\bin\co_01.jpg" WIDTH="100" HEIGHT="25" ALIGN="center"/>
            <HR></HR>
                 <FONT FACE="Matisse ITC">
                     conversion program created by Tom Dabson, MSc in Computing, Final Project: 2000
                 </FONT>
            <IMG SRC="E:\Perl\bin\co_01.jpg" WIDTH="100" HEIGHT="25" ALIGN="center"/>
            <HR></HR>   -->
        </HTML>
</fo:root>
    </xsl:template>
</xsl:stylesheet>
