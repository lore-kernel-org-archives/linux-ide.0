From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 5/5] ide: Force VIA IDE legacy interrupts for AmigaOne boards
Date: Mon, 12 Jan 2009 18:55:55 +0100
Message-ID: <200901121855.55827.bzolnier@gmail.com>
References: <20090107135457.234150@gmx.net> <200901111751.55757.bzolnier@gmail.com> <20090111200530.113910@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f21.google.com ([209.85.218.21]:46800 "EHLO
	mail-bw0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751131AbZALSF4 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 12 Jan 2009 13:05:56 -0500
Received: by bwz14 with SMTP id 14so32582089bwz.13
        for <linux-ide@vger.kernel.org>; Mon, 12 Jan 2009 10:05:52 -0800 (PST)
In-Reply-To: <20090111200530.113910@gmx.net>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Gerhard Pircher <gerhard_pircher@gmx.net>
Cc: linux-ide@vger.kernel.org, linuxppc-dev@ozlabs.org, grant.likely@secretlab.ca

On Sunday 11 January 2009, Gerhard Pircher wrote:
> 
> -------- Original-Nachricht --------
> > Datum: Sun, 11 Jan 2009 17:51:55 +0100
> > Von: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> > An: "Gerhard Pircher" <gerhard_pircher@gmx.net>
> > CC: "Grant Likely" <grant.likely@secretlab.ca>, linuxppc-dev@ozlabs.org, linux-ide@vger.kernel.org
> > Betreff: Re: [PATCH 5/5] ide: Force VIA IDE legacy interrupts for AmigaOne boards
> 
> > On Wednesday 07 January 2009, Gerhard Pircher wrote:
> > > 
> > > -------- Original-Nachricht --------
> > > > Datum: Wed, 7 Jan 2009 08:13:06 -0700
> > > > Von: "Grant Likely" <grant.likely@secretlab.ca>
> > > > An: "Gerhard Pircher" <gerhard_pircher@gmx.net>
> > > > CC: linuxppc-dev@ozlabs.org, bzolnier@gmail.com
> > > > Betreff: Re: [PATCH 5/5] ide: Force VIA IDE legacy interrupts for
> > AmigaOne boards
> > > 
> > > > On Wed, Jan 7, 2009 at 7:12 AM, Gerhard Pircher
> > <gerhard_pircher@gmx.net>
> > > > wrote:
> > > > > The AmigaOne uses the onboard VIA IDE controller in legacy mode
> > > > >(like the Pegasos).
> > > > >
> > > > > Signed-off-by: Gerhard Pircher <gerhard_pircher@gmx.net>
> > > > > ---
> > > > >  drivers/ide/via82cxxx.c |    5 +++++
> > > > >  1 files changed, 5 insertions(+), 0 deletions(-)
> > > > 
> > > > This patch needs to also be posted on the linux-ide mailing list.
> > > Ouch, I only sent it to the maintainer. I'll fix that.
> > 
> > [ Please also keep all previous recipients on cc: when doing so. ]
> Okay, I'll keep that in mind.
> 
> > > > > diff --git a/drivers/ide/via82cxxx.c b/drivers/ide/via82cxxx.c
> > > > > index 2a812d3..086f476 100644
> > > > > --- a/drivers/ide/via82cxxx.c
> > > > > +++ b/drivers/ide/via82cxxx.c
> > > > > @@ -450,6 +450,11 @@ static int __devinit via_init_one(struct
> > pci_dev
> > > > *dev, const struct pci_device_i
> > > > >                d.host_flags |= IDE_HFLAG_FORCE_LEGACY_IRQS;
> > > > >  #endif
> > > > >
> > > > > +#ifdef CONFIG_AMIGAONE
> > > > > +       if (machine_is(amigaone))
> > > > > +               d.host_flags |= IDE_HFLAG_FORCE_LEGACY_IRQS;
> > > > > +#endif
> > > > > +
> > > > 
> > > > I know you're just following the example of the PEGASOS workaround
> > > > immediately above; but the #defines are really ugly.  I wonder if
> > > > there is there a cleaner way to manipulate the flags.
> > > AFAIK the via82cxxx driver doesn't make use of the
> > > pci_get_legacy_ide_irq approach.
> > 
> > I applied your patch for 2.6.29 but for 2.6.30 I would ask you to clean
> > up #ifdefs by using ide_pci_is_in_compatibility_mode() helper instead for
> > checking if IDE_HFLAG_FORCE_LEGACY_IRQS should be set.
> Wouldn't it be better, if I clean this up now? (I have to resend my AmigaOne
> platform patches anyway).

Replacement patch instead of incremental one is also fine with me -- given 
that it can wait for 2.6.30.

> > [ Some time ago Pegasos got PCI quirk to put controller in the legacy mode
> >   (arch/powerpc/platforms/chrp/pci.c) so it is OK to also remove Pegasos'
> >   special case while at it. ]
> Okay, so the change shouldn't break IDE for Pegasos machines (I don't have
> a Pegasos for testing).

Yes but there may be some other platforms (not necessarily powerpc ones)
that may be affected (i.e. they can depend indirectly on IRQ auto-probing
during IDE probe) so cleanup patch needs to spend some time in linux-next.

Thanks,
Bart
