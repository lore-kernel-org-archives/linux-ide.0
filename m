From: "Kalra Ashish-B00888" <ashish.kalra@freescale.com>
Subject: RE: [PATCH][sata_fsl] Defer non-ncq commands when ncq commands active
Date: Thu, 30 Jul 2009 19:28:12 +0530
Message-ID: <16444A0F3094A24C83EAB7836A12C63B032E5C@zin33exm20.fsl.freescale.net>
References: <Pine.WNT.4.64.0907292129310.4440@B00888-02.fsl.freescale.net>
	<4A70A78D.7070601@gmail.com>
	<16444A0F3094A24C83EAB7836A12C63B032E5A@zin33exm20.fsl.freescale.net>
	<E8D39D04-E4B6-4420-AD54-6A95BE35EB30@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4725882383979835935=="
Return-path: <linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@lists.ozlabs.org>
Content-class: urn:content-classes:message
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Sender: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@lists.ozlabs.org
To: Kumar Gala <galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, linux-ide@vger.kernel.org, Robert Hancock <hancockrwd@gmail.com>
List-Id: linux-ide@vger.kernel.org

This is a multi-part message in MIME format.

--===============4725882383979835935==
Content-class: urn:content-classes:message
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01CA111E.1FE629D0"

This is a multi-part message in MIME format.

------_=_NextPart_001_01CA111E.1FE629D0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hello Kumar,

>> > This doesn't look like it should change anything. sata_fsl_ops=20
>> inherits
>> > from sata_pmp_port_ops, which inherits from sata_port_ops, which=20
>> already
>> > sets qc_defer to ata_std_qc_defer.
>> Oh, yes. Actually this patch was for older kernels where there=20
>> inheritence was not there. As you mentioned, this patch is not=20
>> required now.
>>
>How old?  Should we be asking for this to be applied to some of the=20
>stable kernel series?

I believe that the inheritence stuff was added in 2.6.26, thus, this =
patch is
required for quite old kernels ( < 2.6.26 ).

Thanks,

Ashish


------_=_NextPart_001_01CA111E.1FE629D0
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<HTML dir=3Dltr><HEAD><TITLE>Re: [PATCH][sata_fsl] Defer non-ncq =
commands when ncq commands active</TITLE>=0A=
<META http-equiv=3DContent-Type content=3D"text/html; charset=3Dunicode">=0A=
<META content=3D"MSHTML 6.00.2900.3562" name=3DGENERATOR></HEAD>=0A=
<BODY>=0A=
<DIV id=3DidOWAReplyText27244 dir=3Dltr>=0A=
<DIV dir=3Dltr><FONT face=3DArial color=3D#000000 size=3D2>Hello =
Kumar,</FONT></DIV></DIV>=0A=
<DIV dir=3Dltr><BR><FONT size=3D2>&gt;&gt; &gt; This doesn't look like =
it should change anything. sata_fsl_ops&nbsp;<BR>&gt;&gt; =
inherits<BR>&gt;&gt; &gt; from sata_pmp_port_ops, which inherits from =
sata_port_ops, which&nbsp;<BR>&gt;&gt; already<BR>&gt;&gt; &gt; sets =
qc_defer to ata_std_qc_defer.<BR>&gt;&gt; Oh, yes. Actually this patch =
was for older kernels where there&nbsp;<BR>&gt;&gt; inheritence was not =
there. As you mentioned, this patch is not&nbsp;<BR>&gt;&gt; required =
now.<BR>&gt;&gt;<BR>&gt;How old?&nbsp; Should we be asking for this to =
be applied to some of the&nbsp;<BR>&gt;stable kernel series?<BR><BR>I =
believe that the inheritence stuff was added in 2.6.26, thus, this patch =
is</FONT></DIV>=0A=
<DIV dir=3Dltr><FONT size=3D2>required for quite old kernels ( &lt; =
2.6.26 ).</FONT></DIV>=0A=
<P><FONT size=3D2>Thanks,</FONT></P>=0A=
<P><FONT size=3D2>Ashish</P></FONT></BODY></HTML>
------_=_NextPart_001_01CA111E.1FE629D0--

--===============4725882383979835935==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linuxppc-dev mailing list
Linuxppc-dev@lists.ozlabs.org
https://lists.ozlabs.org/listinfo/linuxppc-dev
--===============4725882383979835935==--
