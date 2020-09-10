Return-Path: <SRS0=Rbkm=CT=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD80BC433E2
	for <linux-ide@archiver.kernel.org>; Thu, 10 Sep 2020 23:05:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C63920731
	for <linux-ide@archiver.kernel.org>; Thu, 10 Sep 2020 23:05:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725562AbgIJXFZ (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 10 Sep 2020 19:05:25 -0400
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:43682 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725294AbgIJXFX (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 10 Sep 2020 19:05:23 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by kvm5.telegraphics.com.au (Postfix) with ESMTP id 2132F2A937;
        Thu, 10 Sep 2020 19:05:17 -0400 (EDT)
Date:   Fri, 11 Sep 2020 09:05:21 +1000 (AEST)
From:   Finn Thain <fthain@telegraphics.com.au>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
cc:     "David S. Miller" <davem@davemloft.net>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Joshua Thompson <funaho@jurai.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-ide@vger.kernel.org
Subject: Re: [PATCH] ide/macide: Convert Mac IDE driver to platform driver
In-Reply-To: <CAMuHMdVMvhJRHOwJapi+LAdPbPuoT73ST_Nj0qeCqQd3XWvoSQ@mail.gmail.com>
Message-ID: <alpine.LNX.2.23.453.2009110847480.8@nippy.intranet>
References: <00ee44fe6ecdce1c783c3cc3b1b9a62b498dcdb2.1597736545.git.fthain@telegraphics.com.au> <CAMuHMdWAi6+75Mq0U8x7Ut6viHvF7XEZAcYnxq=jJmtJyAX8pw@mail.gmail.com> <alpine.LNX.2.23.453.2009100920001.8@nippy.intranet>
 <CAMuHMdVMvhJRHOwJapi+LAdPbPuoT73ST_Nj0qeCqQd3XWvoSQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On Thu, 10 Sep 2020, Geert Uytterhoeven wrote:

> On Thu, Sep 10, 2020 at 2:23 AM Finn Thain <fthain@telegraphics.com.au> wrote:
> > I prefer a declarative or data-driven style, even if it takes a few 
> > more lines of code. But there is a compromise:
> >
> > static const struct resource mac_ide_quadra_rsrc[] __initconst = {
> >         DEFINE_RES_MEM(0x50F1A000, 0x104),
> >         DEFINE_RES_IRQ(IRQ_NUBUS_F),
> > }
> >
> > static const struct resource mac_ide_pb_rsrc[] __initconst = {
> >         DEFINE_RES_MEM(0x50F1A000, 0x104),
> >         DEFINE_RES_IRQ(IRQ_NUBUS_C),
> > }
> >
> > The reason I didn't use these macros was to avoid making the reader go and
> > look up their definitions. Anyway, would that style be preferred here?
> 
> I think the DEFINE_RES_*() are sufficiently common (well, in pre-DT
> platforms ;-)
> 

OK, I'll use the macros in v2.

> > I could do the same with the mac_ide_baboon_rsrc[] initializer:
> >
> > static const struct resource mac_pata_baboon_rsrc[] __initconst = {
> >         DEFINE_RES_MEM(0x50F1A000, 0x38),
> >         DEFINE_RES_MEM(0x50F1A038, 0x04),
> >         DEFINE_RES_IRQ(IRQ_BABOON_1),
> > };
> >
> > ... but that would lose the IORESOURCE_IRQ_SHAREABLE flag. I'm not sure
> > whether that matters (it's a vestige of macide.c).
> 
> You can still use DEFINE_RES_NAMED() to pass the flags.
> Would you consider that to be a good compromise?
> 

Sure. I was happy with v1. I'm not that worried about brevity.

Anyway, the question remains, is the flag actually needed. I can't see a 
need for it so I'll omit the flag in v2 and ask Stan to test again.

> > > > +static const struct resource mac_pata_baboon_rsrc[] __initconst = {
> > > > +       {
> > > > +               .flags = IORESOURCE_MEM,
> > > > +               .start = 0x50F1A000,
> > > > +               .end   = 0x50F1A037,
> > > > +       }, {
> > > > +               .flags = IORESOURCE_MEM,
> > > > +               .start = 0x50F1A038,
> > > > +               .end   = 0x50F1A03B,
> > > > +       }, {
> > > > +               .flags = IORESOURCE_IRQ | IORESOURCE_IRQ_SHAREABLE,
> > > > +               .start = IRQ_BABOON_1,
> > > > +               .end   = IRQ_BABOON_1,
> > > > +       },
> > > > +};
> > > > +
> > > > +static const struct pata_platform_info mac_pata_baboon_data __initconst = {
> > > > +       .ioport_shift  = 2,
> > > > +};
> > >
> > > Just wondering: how is this implemented in drivers/ide/macide.c, which
> > > doesn't use the platform info?
> >
> > That factor of 4 is embedded in the address caclulation:
> >
> >         for (i = 0; i < 8; i++)
> >                 hw->io_ports_array[i] = base + i * 4;
> 
> IC. But in the new code, the platform info is passed for Baboon only,
> while the old code used it for all variants.
> 

Correct. Is that a problem for some reason?

> > > > --- a/drivers/ide/macide.c
> > > > +++ b/drivers/ide/macide.c
> > > > @@ -18,10 +18,11 @@
> > > >  #include <linux/delay.h>
> > > >  #include <linux/ide.h>
> > > >  #include <linux/module.h>
> > > > +#include <linux/platform_device.h>
> > > >
> > > >  #include <asm/macintosh.h>
> > > > -#include <asm/macints.h>
> > > > -#include <asm/mac_baboon.h>
> > > > +
> > > > +#define DRV_NAME "mac_ide"
> > > >
> > > >  #define IDE_BASE 0x50F1A000    /* Base address of IDE controller */
> > >
> > > Do you still need this definition?
> > > Yes, because it's still used to access IDE_IFR.
> > > Ideally, that should be converted to use the base from the resource,
> > > too.
> > >
> >
> > Yes, that was my thought too. I can make the change if you like, but I
> > can't test it until I set up the appropriate hardware (MAC_IDE_QUADRA or
> > MAC_IDE_PB). I do own that hardware but it is located in Melbourne and it
> > is now illegal to visit Melbourne without official papers. Besides, once I
> > can test on that hardware I can replace the entire driver anyway, and
> > this kind of refactoring would become moot.
> 
> OK.
> 
> > > > @@ -109,42 +110,65 @@ static const char *mac_ide_name[] =
> > > >   * Probe for a Macintosh IDE interface
> > > >   */
> > > >
> > > > -static int __init macide_init(void)
> > > > +static int mac_ide_probe(struct platform_device *pdev)
> > > >  {
> > > > -       unsigned long base;
> > > > -       int irq;
> > > > +       struct resource *mem, *irq;
> > > >         struct ide_hw hw, *hws[] = { &hw };
> > > >         struct ide_port_info d = macide_port_info;
> > > > +       struct ide_host *host;
> > > > +       int rc;
> > > >
> > > >         if (!MACH_IS_MAC)
> > > >                 return -ENODEV;
> > > >
> > > > -       switch (macintosh_config->ide_type) {
> > > > -       case MAC_IDE_QUADRA:
> > > > -               base = IDE_BASE;
> > > > -               irq = IRQ_NUBUS_F;
> > > > -               break;
> > > > -       case MAC_IDE_PB:
> > > > -               base = IDE_BASE;
> > > > -               irq = IRQ_NUBUS_C;
> > > > -               break;
> > > > -       case MAC_IDE_BABOON:
> > > > -               base = BABOON_BASE;
> > > > -               d.port_ops = NULL;
> > >
> > > How does the driver know not to use the special port_ops after
> > > this change?
> > >
> >
> > The driver always uses the special port_ops after this change because it
> > no longer handles the MAC_IDE_BABOON case. That case is handled by either
> 
> non-MAC_IDE_BABOON case?
> 
> > drivers/ata/pata_platform.c or drivers/ide/ide_platform.c, depending on
> > .config.
> 
> Ideally, we do need to differentiate, right?
> 

Sorry, I'm lost.

The commit log explains that the macide driver is only intended to support 
two of the three variants, because the generic drivers are already able to 
support the third variant (Baboon). Stan confirmed this on his PB 190.

But, IIUC, you seem to want macide to continue to support all three 
variants (?) The existing code to implement that has an old bug that 
reassigns d.port_ops when it is const. IMO, the const is correct because 
macide should concern itself with mac hardware quirks and should not try 
to mimic a generic driver by setting d.port_ops = NULL. Does that make 
sense?

> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> 
