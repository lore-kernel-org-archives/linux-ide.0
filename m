From: "Joel Soete" <soete.joel@tiscali.be>
Subject: Re: a fix for NS87415 on C3K broken
Date: Wed, 22 Sep 2004 19:21:08 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <41501936000007AF@mail-7-bnl.tiscali.it>
References: <20040922163708.GD4766@colo.lackof.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-7-bnl.tiscali.it ([213.205.33.227]:11611 "EHLO
	mail-7-bnl.tiscali.it") by vger.kernel.org with ESMTP
	id S266486AbUIVRVY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 22 Sep 2004 13:21:24 -0400
In-Reply-To: <20040922163708.GD4766@colo.lackof.org>
List-Id: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>, Grant Grundler <grundler@parisc-linux.org>, linux-ide@vger.kernel.org, parisc-linux@parisc-linux.org


Hello Grant,

> On Wed, Sep 22, 2004 at 12:41:21PM +0200, Joel Soete wrote:
> > Hello Grant, Bartlomiej and *,
> >
> > I test this patch:
> > --- arch/parisc/kernel/pci.c.Orig	2004-09-22 09:47:02.000000000 +02=
00
> > +++ arch/parisc/kernel/pci.c	2004-09-22 11:26:02.104187784 +0200
> > @@ -146,6 +146,9 @@
> >  	return str;
> >  }
> >=20
> > +/* Used in drivers/pci/quirks.c */
> > +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_NS, PCI_DEVICE_ID_NS_87415,
superio_fixup_pci);
>=20
> Uhm...any clue why this works?
No more clue sorry; I just notived that boot message of 2.6.8.1-pa7:
lba version TR4.0 (0x5) found at 0xfffffffffed30000
PCI: Enabled native mode for NS87415 (pif=3D0x8f)

became with 2.6.9-rc2:
lba version TR4.0 (0x5) found at 0xfffffffffed30000
PCI: Ignoring BAR0-3 of IDE controller 0000:00:0e.0
PCI: Enabled native mode for NS87415 (pif=3D0x8f)

(so PCI: Enabled native mode for NS87415 precede by a weird 'ignoring .=
=2E.
IDE controler)

I so just try to move back the pcibios_fixups initialisation at its pre=
vious
place and the message ''ignoring ... IDE controler" disapear ?)
=20
> The same entry in drivers/parisc/superio.c should work too but it doe=
sn't.
> I'd rather fix that than just blindly moving it.
>=20
no pb

> > That fix the NS87415 pb on my c2k model :)
> > Can somebody check it with some c3k model?
>=20
> I expect c3k also to work. I'm not going to test it.
>=20
>=20
> BTW, I've prepared a patch which moves IDE knowledge
> out of superio.c driver and into drivers/ide/pci/ns87415.c.
> I've not submitted it yet because I haven't successfully tested it
> and it still contains debug printk's.
> It builds and anyone curious is welcome to look at it:
>     ftp://ftp.parisc-linux.org/patches/diff-2.6.9-rc2-ns87415_suckyio=
_cleanup-01
>=20
I will also try it :)

> Moving the DECLARE_PCI_FIXUP_HEADER() around is probably the clue
> I needed to resolve this.
>=20
I am curious to find an expalnation too.

Thanks,
    Joel

-----------------------------------------------------------------------=
----
Tiscali ADSL GO, 29,50 Euro/mois pendant toute une ann=E9e, profitez-en=
=2E..
http://reg.tiscali.be/adsl/welcome.asp?lg=3DFR




