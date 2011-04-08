From: Kushwaha Prabhakar-B32579 <B32579@freescale.com>
Subject: RE: known working sata_sil24.c setup on powerpc platforms?
Date: Fri, 8 Apr 2011 08:31:25 +0000
Message-ID: <071A08F2C6A57E4E94D980ECA553F87416D8CC@039-SN1MPN1-004.039d.mgd.msft.net>
References: <BANLkTimXgi26RHHxyBLoN8YqaDy_PL-hGQ@mail.gmail.com>
	<C3A1EF35-6CB6-4674-8B0B-44CD1657FE87@boeing.com>
	<4D9CAD1F.6060500@garzik.org>
	<BANLkTinjn5nt4-0cSo6nUfG8Vt1UrL2Q0g@mail.gmail.com>
	<071A08F2C6A57E4E94D980ECA553F87416BDD0@039-SN1MPN1-004.039d.mgd.msft.net>
	<BANLkTin1KoJ8EsV49naEAZjmq=EZLHXZpQ@mail.gmail.com>
	<071A08F2C6A57E4E94D980ECA553F87416D3E7@039-SN1MPN1-004.039d.mgd.msft.net>
 <BANLkTi=jLZrS+rOBOMq=v3aMCPjNAUjS4w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from va3ehsobe006.messaging.microsoft.com ([216.32.180.16]:42989
	"EHLO VA3EHSOBE007.bigfish.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751058Ab1DHIbl convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 8 Apr 2011 04:31:41 -0400
In-Reply-To: <BANLkTi=jLZrS+rOBOMq=v3aMCPjNAUjS4w@mail.gmail.com>
Content-Language: en-US
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Leon Woestenberg <leon.woestenberg@gmail.com>
Cc: "Moffett, Kyle D" <Kyle.D.Moffett@boeing.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Tejun Heo <htejun@gmail.com>, Jeff Garzik <jeff@garzik.org>, Linux PPC <linuxppc-dev@ozlabs.org>, Gupta Maneesh-B18878 <B18878@freescale.com>

Hi Leon,


> -----Original Message-----
> From: Leon Woestenberg [mailto:leon.woestenberg@gmail.com]
> Sent: Friday, April 08, 2011 1:55 PM
> To: Kushwaha Prabhakar-B32579
> Cc: Moffett, Kyle D; linux-ide@vger.kernel.org; Tejun Heo; Jeff Garzi=
k;
> Linux PPC; Gupta Maneesh-B18878
> Subject: Re: known working sata_sil24.c setup on powerpc platforms?
>=20
> Hello Prabhakar,
>=20
> On Fri, Apr 8, 2011 at 5:44 AM, Kushwaha Prabhakar-B32579
> <B32579@freescale.com> wrote:
> >> -----Original Message-----
> >> From: linux-ide-owner@vger.kernel.org [mailto:linux-ide-
> >> owner@vger.kernel.org] On Behalf Of Leon Woestenberg
> >> Sent: Thursday, April 07, 2011 10:23 PM
> >> To: Kushwaha Prabhakar-B32579
> >> Cc: Moffett, Kyle D; Linux PPC; linux-ide@vger.kernel.org; Tejun H=
eo;
> >> Jeff Garzik
> >> Subject: Re: known working sata_sil24.c setup on powerpc platforms=
?
> >>
> >> On Thu, Apr 7, 2011 at 6:48 AM, Kushwaha Prabhakar-B32579
> >> <B32579@freescale.com> wrote:
> >> > Can you please check p2020rdb.dts for IDSEL entries for pci0/1 n=
ode?
> >> >
> >> > In order to work in legacy mode, IDSEL entries are required.
> >> >
> >> No, the p1020rdb and p2020rdb do not have the IDSEL entries:
> >> What would the correct IDSEL entries be?
> >
> > For legacy interrupt to work IDSEL values are required.. please fin=
d
> the correct IDSEL values for pci0/1.
> >
> > =A0 =A0 =A0 =A0pci0: pcie@ffe09000 {
> > ...
> > Please try with this.. I am in process of pushing these IDSEL value=
s to
> upstream.
> >
>=20
> Do you have these for P1020RDB  as well? I found a P1020RDB board tha=
t
> has the CE10 errata fixed, so IRQ0 is properly pulled up.
>=20

  Same IDSEL values are valid for P1020RDB also.

--Prabhakar


