From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 5/5] ide: Force VIA IDE legacy interrupts for AmigaOne boards
Date: Sun, 11 Jan 2009 17:51:55 +0100
Message-ID: <200901111751.55757.bzolnier@gmail.com>
References: <20090107135457.234150@gmx.net> <fa686aa40901070713kca10b27y6c6aac03e6224fac@mail.gmail.com> <20090107152722.140970@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.186]:56241 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752935AbZAKRsP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 11 Jan 2009 12:48:15 -0500
Received: by fk-out-0910.google.com with SMTP id 18so5194520fkq.5
        for <linux-ide@vger.kernel.org>; Sun, 11 Jan 2009 09:48:12 -0800 (PST)
In-Reply-To: <20090107152722.140970@gmx.net>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Gerhard Pircher <gerhard_pircher@gmx.net>
Cc: Grant Likely <grant.likely@secretlab.ca>, linuxppc-dev@ozlabs.org, linux-ide@vger.kernel.org

On Wednesday 07 January 2009, Gerhard Pircher wrote:
> 
> -------- Original-Nachricht --------
> > Datum: Wed, 7 Jan 2009 08:13:06 -0700
> > Von: "Grant Likely" <grant.likely@secretlab.ca>
> > An: "Gerhard Pircher" <gerhard_pircher@gmx.net>
> > CC: linuxppc-dev@ozlabs.org, bzolnier@gmail.com
> > Betreff: Re: [PATCH 5/5] ide: Force VIA IDE legacy interrupts for AmigaOne boards
> 
> > On Wed, Jan 7, 2009 at 7:12 AM, Gerhard Pircher <gerhard_pircher@gmx.net>
> > wrote:
> > > The AmigaOne uses the onboard VIA IDE controller in legacy mode (like
> > the
> > > Pegasos).
> > >
> > > Signed-off-by: Gerhard Pircher <gerhard_pircher@gmx.net>
> > > ---
> > >  drivers/ide/via82cxxx.c |    5 +++++
> > >  1 files changed, 5 insertions(+), 0 deletions(-)
> > 
> > This patch needs to also be posted on the linux-ide mailing list.
> Ouch, I only sent it to the maintainer. I'll fix that.

[ Please also keep all previous recipients on cc: when doing so. ]

> > > diff --git a/drivers/ide/via82cxxx.c b/drivers/ide/via82cxxx.c
> > > index 2a812d3..086f476 100644
> > > --- a/drivers/ide/via82cxxx.c
> > > +++ b/drivers/ide/via82cxxx.c
> > > @@ -450,6 +450,11 @@ static int __devinit via_init_one(struct pci_dev
> > *dev, const struct pci_device_i
> > >                d.host_flags |= IDE_HFLAG_FORCE_LEGACY_IRQS;
> > >  #endif
> > >
> > > +#ifdef CONFIG_AMIGAONE
> > > +       if (machine_is(amigaone))
> > > +               d.host_flags |= IDE_HFLAG_FORCE_LEGACY_IRQS;
> > > +#endif
> > > +
> > 
> > I know you're just following the example of the PEGASOS workaround
> > immediately above; but the #defines are really ugly.  I wonder if
> > there is there a cleaner way to manipulate the flags.
> AFAIK the via82cxxx driver doesn't make use of the pci_get_legacy_ide_irq
> approach.

I applied your patch for 2.6.29 but for 2.6.30 I would ask you to clean
up #ifdefs by using ide_pci_is_in_compatibility_mode() helper instead for
checking if IDE_HFLAG_FORCE_LEGACY_IRQS should be set.

[ Some time ago Pegasos got PCI quirk to put controller in the legacy mode
  (arch/powerpc/platforms/chrp/pci.c) so it is OK to also remove Pegasos'
  special case while at it. ]

Thanks,
Bart
