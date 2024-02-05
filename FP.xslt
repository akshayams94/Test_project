<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs" version="2.0">
    
    <!-- Controls the kind of output. For more on these and other options, see here: https://www.w3schools.com/xml/ref_xsl_el_output.asp -->
    <xsl:output method="html" omit-xml-declaration="yes" indent="no"/>

    <!--
        We want to transform an XML document into an HTML document. We know that every XML document has a root (/) element. 
        This first element tells the processor what to do once it finds the root element in the XML. 
        To start out, we want the result document to be an HTML document, so we specify the skeleton of an HTML document. 
        Later, where we want to include other parts of the source XML, we add other templates and specify elements of the XML to select.
    -->
    <xsl:template match="/">
        <html>
            <head>
            </head>

            <body style="width: 700px; margin: auto; margin-top: 1em; font-family: Helvetica, Arial, sans-serif">
                <h1 class="text-primary">Our Staff</h1> At Basalt Veterinary Hospital, we value our staff! 
                <!-- For every Group in the Biographies element, put the group name 
                    and then the info of each staff member in it. -->
                <xsl:for-each select="Biographies/Group">
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
                            <xsl:when test="VeterinaryFocuses">
                                <h4>Specialties:</h4>
                                <xsl:for-each select="VeterinaryFocuses/Focus">
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