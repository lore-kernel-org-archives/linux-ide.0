From: "SCHEP. - Schepke, Arnt" <SCHEP@Hoeft-Wessel.de>
Subject: AW: flash as hda causes 2.4.18 to hang in grok_partitions()...add
	_to_page_cache_unique()
Date: Wed, 19 Mar 2003 09:41:16 +0100
Sender: kernelnewbies-bounce@nl.linux.org
Message-ID: <984305F1827DD5118FEA0000D1105F0A01BDC3AD@HW_MAIL>
Mime-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C2EDF3.4DF47F20"
Return-path: <kernelnewbies-bounce@nl.linux.org>
Errors-to: kernelnewbies-bounce@nl.linux.org
List-help: <mailto:listar@nl.linux.org?Subject=help>
List-unsubscribe: <mailto:kernelnewbies-request@nl.linux.org?Subject=unsubscribe>
List-software: Listar version 1.0.0
List-subscribe: <mailto:kernelnewbies-request@nl.linux.org?Subject=subscribe>
List-owner: <mailto:riel@nl.linux.org>
List-post: <mailto:kernelnewbies@nl.linux.org>
List-archive: <http://mail.nl.linux.org/kernelnewbies/>
To: 'Guennadi Liakhovetski' <gl@dsa-ac.de>, David Wuertele <dave-gnus@bfnet.com>
Cc: kernelnewbies@nl.linux.org, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_001_01C2EDF3.4DF47F20
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

AFIK the IDE stuff is completely rewritten and new. And there was some
trouble with this new stuff, and some trouble, and now it is somehow =
fixed.
And I hope my mailing does not contain any html-stuff as my **** =
outlook
makes sometimes.

Regards

-----Urspr=FCngliche Nachricht-----
Von: Guennadi Liakhovetski [mailto:gl@dsa-ac.de]
Gesendet am: Mittwoch, 19. M=E4rz 2003 09:17
An: David Wuertele
Cc: kernelnewbies@nl.linux.org; linux-ide@vger.kernel.org
Betreff: Re: flash as hda causes 2.4.18 to hang in
grok_partitions()...add_to_page_cache_unique()

> Guennadi> Try a 2.4.21-pre4-ac4 at least. It fixed our problems with
> Guennadi> flash in true IDE mode here.
>
> Thanks.  Do you know what the change was?  Was patch-2.4.21-pre4-ac4
> the actual patch to fix the problem for you?

No, not really. I posted a question on LKML and Alan told me to try the
patch he released the day before:-) And it worked like a charm:-) So, =
yes,
it was that actual patch.

Guennadi
---------------------------------
Guennadi Liakhovetski, Ph.D.
DSA Daten- und Systemtechnik GmbH
Pascalstr. 28
D-52076 Aachen
Germany

-
To unsubscribe from this list: send the line "unsubscribe linux-ide" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

------_=_NextPart_001_01C2EDF3.4DF47F20
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Diso-8859-1">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
5.5.2653.12">
<TITLE>AW: flash as hda causes 2.4.18 to hang in =
grok_partitions()...add_to_page_cache_unique()</TITLE>
</HEAD>
<BODY>

<P><FONT SIZE=3D2>AFIK the IDE stuff is completely rewritten and new. =
And there was some trouble with this new stuff, and some trouble, and =
now it is somehow fixed.</FONT></P>

<P><FONT SIZE=3D2>And I hope my mailing does not contain any html-stuff =
as my **** outlook makes sometimes.</FONT>
</P>

<P><FONT SIZE=3D2>Regards</FONT>
</P>

<P><FONT SIZE=3D2>-----Urspr=FCngliche Nachricht-----</FONT>
<BR><FONT SIZE=3D2>Von: Guennadi Liakhovetski [<A =
HREF=3D"mailto:gl@dsa-ac.de">mailto:gl@dsa-ac.de</A>]</FONT>
<BR><FONT SIZE=3D2>Gesendet am: Mittwoch, 19. M=E4rz 2003 09:17</FONT>
<BR><FONT SIZE=3D2>An: David Wuertele</FONT>
<BR><FONT SIZE=3D2>Cc: kernelnewbies@nl.linux.org; =
linux-ide@vger.kernel.org</FONT>
<BR><FONT SIZE=3D2>Betreff: Re: flash as hda causes 2.4.18 to hang =
in</FONT>
<BR><FONT =
SIZE=3D2>grok_partitions()...add_to_page_cache_unique()</FONT>
</P>

<P><FONT SIZE=3D2>&gt; Guennadi&gt; Try a 2.4.21-pre4-ac4 at least. It =
fixed our problems with</FONT>
<BR><FONT SIZE=3D2>&gt; Guennadi&gt; flash in true IDE mode =
here.</FONT>
<BR><FONT SIZE=3D2>&gt;</FONT>
<BR><FONT SIZE=3D2>&gt; Thanks.&nbsp; Do you know what the change =
was?&nbsp; Was patch-2.4.21-pre4-ac4</FONT>
<BR><FONT SIZE=3D2>&gt; the actual patch to fix the problem for =
you?</FONT>
</P>

<P><FONT SIZE=3D2>No, not really. I posted a question on LKML and Alan =
told me to try the</FONT>
<BR><FONT SIZE=3D2>patch he released the day before:-) And it worked =
like a charm:-) So, yes,</FONT>
<BR><FONT SIZE=3D2>it was that actual patch.</FONT>
</P>

<P><FONT SIZE=3D2>Guennadi</FONT>
<BR><FONT SIZE=3D2>---------------------------------</FONT>
<BR><FONT SIZE=3D2>Guennadi Liakhovetski, Ph.D.</FONT>
<BR><FONT SIZE=3D2>DSA Daten- und Systemtechnik GmbH</FONT>
<BR><FONT SIZE=3D2>Pascalstr. 28</FONT>
<BR><FONT SIZE=3D2>D-52076 Aachen</FONT>
<BR><FONT SIZE=3D2>Germany</FONT>
</P>

<P><FONT SIZE=3D2>-</FONT>
<BR><FONT SIZE=3D2>To unsubscribe from this list: send the line =
&quot;unsubscribe linux-ide&quot; in</FONT>
<BR><FONT SIZE=3D2>the body of a message to =
majordomo@vger.kernel.org</FONT>
<BR><FONT SIZE=3D2>More majordomo info at&nbsp; <A =
HREF=3D"http://vger.kernel.org/majordomo-info.html" =
TARGET=3D"_blank">http://vger.kernel.org/majordomo-info.html</A></FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C2EDF3.4DF47F20--
--
Kernelnewbies: Help each other learn about the Linux kernel.
Archive:       http://mail.nl.linux.org/kernelnewbies/
FAQ:           http://kernelnewbies.org/faq/
