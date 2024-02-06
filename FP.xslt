<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs" version="2.0">
    
    <xsl:output method="html" omit-xml-declaration="yes" indent="no"/>

    <!--
       Used few concepts from HTML for my own purpose and covered all the concepts of XSLT in this project 
    -->
    <xsl:template match="/">
        <html>
            <head>
            </head>

            <body style="width: 700px; margin: auto; margin-top: 1em; font-family: Helvetica, Arial, sans-serif">
                <h1 class="text-primary">Our Staff</h1> At Software Consultancy Firm, we value our Employee with their decisions including their own priorities for work environemnt, time and food! 
                <!-- For every Group in the Company element, put the group name 
                    and then the info of each staff member in it. -->
                <xsl:for-each select="Company/Group">
                    <h2>
                        <!-- Spit out the value of the selected Group's type attribute. -->
                        <xsl:value-of select="@type"/>
                    </h2>
                    <!-- Go through each member in the group and output a bio. -->
                    <xsl:for-each select="StaffMember">
                        <h3>
                            <!-- Results in something like, "Joe Biden—President" -->
                            <!-- Name is an element, and @role is an attribute, hence the ampersand. -->
                            <xsl:value-of select="Name"/>—<xsl:value-of select="@role"/>
                        </h3>
                        <!-- This construct is one way to create and add attributes to HTML elements. -->
                        <!-- Creates an HTML img element. -->
                        <xsl:element name="img">
                            <!-- Adds the image URL from the XML file -->
                            <xsl:attribute name="src">
                                <xsl:value-of select="Portrait/@image-source"/>
                            </xsl:attribute>
                            <!-- Results in 'class="portrait"' -->
                            <xsl:attribute name="class">portrait</xsl:attribute>
                            
                            <xsl:attribute name="style">width: 225px; float: right; margin-left: 5px;</xsl:attribute>
                        </xsl:element>
                        <span>With us since <xsl:value-of select="YearJoined"/></span>
                        <p>
                            <xsl:value-of select="RoleDescription"/>
                        </p>
                        <!-- Optional Element -->
                        <xsl:choose>
                            <!-- If this exists, include it. -->
                            <xsl:when test="TargetFocuses">
                                <h4>Specialties:</h4>
                                <xsl:for-each select="TargetFocuses/Focus">
                                    <ul>
                                        <li>
                                            <xsl:value-of select="."/>
                                        </li>
                                    </ul>
                                </xsl:for-each>
                            </xsl:when>
                        </xsl:choose> <h4>Bio</h4>
                        <p>
                            <xsl:value-of select="Biography"/>
                        </p>
                        <!-- If this is the last person, put a group divider; otherwise, put a staff member divider. -->
                        <xsl:choose>
                            <!-- For other functions like the below, see here: http://www.xsltfunctions.com/ -->
                            <xsl:when test="position() != last()">
                                <hr/>
                            </xsl:when>
                            <xsl:otherwise>
                                <hr class="group-divider" style="border: 3px solid gray; "/>
                            </xsl:otherwise>
                        </xsl:choose>
                        
                        <!-- End Staff Member -->
                    </xsl:for-each>
                    <!-- End Group -->
                </xsl:for-each>
                
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>
