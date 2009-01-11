From: "Gerhard Pircher" <gerhard_pircher@gmx.net>
Subject: Re: [PATCH 5/5] ide: Force VIA IDE legacy interrupts for AmigaOne
 boards
Date: Sun, 11 Jan 2009 21:05:30 +0100
Message-ID: <20090111200530.113910@gmx.net>
References: <20090107135457.234150@gmx.net>
 <fa686aa40901070713kca10b27y6c6aac03e6224fac@mail.gmail.com>
 <20090107152722.140970@gmx.net> <200901111751.55757.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:58718 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752260AbZAKUFe (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 11 Jan 2009 15:05:34 -0500
In-Reply-To: <200901111751.55757.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linuxppc-dev@ozlabs.org, grant.likely@secretlab.ca


-------- Original-Nachricht --------
> Datum: Sun, 11 Jan 2009 17:51:55 +0100
> Von: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> An: "Gerhard Pircher" <gerhard_pircher@gmx.net>
> CC: "Grant Likely" <grant.likely@secretlab.ca>, linuxppc-dev@ozlabs.o=
rg, linux-ide@vger.kernel.org
> Betreff: Re: [PATCH 5/5] ide: Force VIA IDE legacy interrupts for Ami=
gaOne boards

> On Wednesday 07 January 2009, Gerhard Pircher wrote:
> >=20
> > -------- Original-Nachricht --------
> > > Datum: Wed, 7 Jan 2009 08:13:06 -0700
> > > Von: "Grant Likely" <grant.likely@secretlab.ca>
> > > An: "Gerhard Pircher" <gerhard_pircher@gmx.net>
> > > CC: linuxppc-dev@ozlabs.org, bzolnier@gmail.com
> > > Betreff: Re: [PATCH 5/5] ide: Force VIA IDE legacy interrupts for
> AmigaOne boards
> >=20
> > > On Wed, Jan 7, 2009 at 7:12 AM, Gerhard Pircher
> <gerhard_pircher@gmx.net>
> > > wrote:
> > > > The AmigaOne uses the onboard VIA IDE controller in legacy mode
> > > >(like the Pegasos).
> > > >
> > > > Signed-off-by: Gerhard Pircher <gerhard_pircher@gmx.net>
> > > > ---
> > > >  drivers/ide/via82cxxx.c |    5 +++++
> > > >  1 files changed, 5 insertions(+), 0 deletions(-)
> > >=20
> > > This patch needs to also be posted on the linux-ide mailing list.
> > Ouch, I only sent it to the maintainer. I'll fix that.
>=20
> [ Please also keep all previous recipients on cc: when doing so. ]
Okay, I'll keep that in mind.

> > > > diff --git a/drivers/ide/via82cxxx.c b/drivers/ide/via82cxxx.c
> > > > index 2a812d3..086f476 100644
> > > > --- a/drivers/ide/via82cxxx.c
> > > > +++ b/drivers/ide/via82cxxx.c
> > > > @@ -450,6 +450,11 @@ static int __devinit via_init_one(struct
> pci_dev
> > > *dev, const struct pci_device_i
> > > >                d.host_flags |=3D IDE_HFLAG_FORCE_LEGACY_IRQS;
> > > >  #endif
> > > >
> > > > +#ifdef CONFIG_AMIGAONE
> > > > +       if (machine_is(amigaone))
> > > > +               d.host_flags |=3D IDE_HFLAG_FORCE_LEGACY_IRQS;
> > > > +#endif
> > > > +
> > >=20
> > > I know you're just following the example of the PEGASOS workaroun=
d
> > > immediately above; but the #defines are really ugly.  I wonder if
> > > there is there a cleaner way to manipulate the flags.
> > AFAIK the via82cxxx driver doesn't make use of the
> > pci_get_legacy_ide_irq approach.
>=20
> I applied your patch for 2.6.29 but for 2.6.30 I would ask you to cle=
an
> up #ifdefs by using ide_pci_is_in_compatibility_mode() helper instead=
 for
> checking if IDE_HFLAG_FORCE_LEGACY_IRQS should be set.
Wouldn't it be better, if I clean this up now? (I have to resend my Ami=
gaOne
platform patches anyway).

> [ Some time ago Pegasos got PCI quirk to put controller in the legacy=
 mode
>   (arch/powerpc/platforms/chrp/pci.c) so it is OK to also remove Pega=
sos'
>   special case while at it. ]
Okay, so the change shouldn't break IDE for Pegasos machines (I don't h=
ave
a Pegasos for testing).

Thanks!

Gerhard

--=20
Psssst! Schon vom neuen GMX MultiMessenger geh=F6rt? Der kann`s mit all=
en: http://www.gmx.net/de/go/multimessenger
