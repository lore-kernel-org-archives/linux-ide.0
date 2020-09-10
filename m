Return-Path: <SRS0=Rbkm=CT=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78B1EC43461
	for <linux-ide@archiver.kernel.org>; Thu, 10 Sep 2020 02:00:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4456120708
	for <linux-ide@archiver.kernel.org>; Thu, 10 Sep 2020 02:00:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729449AbgIJCAR (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 9 Sep 2020 22:00:17 -0400
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:41474 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729413AbgIJBku (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 9 Sep 2020 21:40:50 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by kvm5.telegraphics.com.au (Postfix) with ESMTP id 5FCBA2BA1F;
        Wed,  9 Sep 2020 20:23:28 -0400 (EDT)
Date:   Thu, 10 Sep 2020 10:23:30 +1000 (AEST)
From:   Finn Thain <fthain@telegraphics.com.au>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
cc:     "David S. Miller" <davem@davemloft.net>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Joshua Thompson <funaho@jurai.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-ide@vger.kernel.org
Subject: Re: [PATCH] ide/macide: Convert Mac IDE driver to platform driver
In-Reply-To: <CAMuHMdWAi6+75Mq0U8x7Ut6viHvF7XEZAcYnxq=jJmtJyAX8pw@mail.gmail.com>
Message-ID: <alpine.LNX.2.23.453.2009100920001.8@nippy.intranet>
References: <00ee44fe6ecdce1c783c3cc3b1b9a62b498dcdb2.1597736545.git.fthain@telegraphics.com.au> <CAMuHMdWAi6+75Mq0U8x7Ut6viHvF7XEZAcYnxq=jJmtJyAX8pw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On Wed, 9 Sep 2020, Geert Uytterhoeven wrote:

> 
> Thanks for your patch!
> 

Thanks for your review.

> > --- a/arch/m68k/mac/config.c +++ b/arch/m68k/mac/config.c
> 
> > @@ -940,6 +941,50 @@ static const struct resource mac_scsi_ccl_rsrc[] __initconst = {
> >         },
> >  };
> >
> > +static const struct resource mac_ide_quadra_rsrc[] __initconst = {
> > +       {
> > +               .flags = IORESOURCE_MEM,
> > +               .start = 0x50F1A000,
> > +               .end   = 0x50F1A103,
> > +       }, {
> > +               .flags = IORESOURCE_IRQ,
> > +               .start = IRQ_NUBUS_F,
> > +               .end   = IRQ_NUBUS_F,
> > +       },
> > +};
> > +
> > +static const struct resource mac_ide_pb_rsrc[] __initconst = {
> > +       {
> > +               .flags = IORESOURCE_MEM,
> > +               .start = 0x50F1A000,
> > +               .end   = 0x50F1A103,
> > +       }, {
> > +               .flags = IORESOURCE_IRQ,
> > +               .start = IRQ_NUBUS_C,
> > +               .end   = IRQ_NUBUS_C,
> > +       },
> > +};
> 
> As the above two variants are almost identical, perhaps it makes sense 
> to drop one of them, drop the const, and override the irq values 
> dynamically?
> 

I prefer a declarative or data-driven style, even if it takes a few more 
lines of code. But there is a compromise:

static const struct resource mac_ide_quadra_rsrc[] __initconst = {
	DEFINE_RES_MEM(0x50F1A000, 0x104),
	DEFINE_RES_IRQ(IRQ_NUBUS_F),
}

static const struct resource mac_ide_pb_rsrc[] __initconst = {
	DEFINE_RES_MEM(0x50F1A000, 0x104),
	DEFINE_RES_IRQ(IRQ_NUBUS_C),
}

The reason I didn't use these macros was to avoid making the reader go and 
look up their definitions. Anyway, would that style be preferred here?

I could do the same with the mac_ide_baboon_rsrc[] initializer:

static const struct resource mac_pata_baboon_rsrc[] __initconst = {
        DEFINE_RES_MEM(0x50F1A000, 0x38),
        DEFINE_RES_MEM(0x50F1A038, 0x04),
        DEFINE_RES_IRQ(IRQ_BABOON_1),
};

... but that would lose the IORESOURCE_IRQ_SHAREABLE flag. I'm not sure 
whether that matters (it's a vestige of macide.c).

> > +
> > +static const struct resource mac_pata_baboon_rsrc[] __initconst = {
> > +       {
> > +               .flags = IORESOURCE_MEM,
> > +               .start = 0x50F1A000,
> > +               .end   = 0x50F1A037,
> > +       }, {
> > +               .flags = IORESOURCE_MEM,
> > +               .start = 0x50F1A038,
> > +               .end   = 0x50F1A03B,
> > +       }, {
> > +               .flags = IORESOURCE_IRQ | IORESOURCE_IRQ_SHAREABLE,
> > +               .start = IRQ_BABOON_1,
> > +               .end   = IRQ_BABOON_1,
> > +       },
> > +};
> > +
> > +static const struct pata_platform_info mac_pata_baboon_data __initconst = {
> > +       .ioport_shift  = 2,
> > +};
> 
> Just wondering: how is this implemented in drivers/ide/macide.c, which
> doesn't use the platform info?
> 

That factor of 4 is embedded in the address caclulation:

        for (i = 0; i < 8; i++)
                hw->io_ports_array[i] = base + i * 4;

> > --- a/drivers/ide/macide.c
> > +++ b/drivers/ide/macide.c
> > @@ -18,10 +18,11 @@
> >  #include <linux/delay.h>
> >  #include <linux/ide.h>
> >  #include <linux/module.h>
> > +#include <linux/platform_device.h>
> >
> >  #include <asm/macintosh.h>
> > -#include <asm/macints.h>
> > -#include <asm/mac_baboon.h>
> > +
> > +#define DRV_NAME "mac_ide"
> >
> >  #define IDE_BASE 0x50F1A000    /* Base address of IDE controller */
> 
> Do you still need this definition?
> Yes, because it's still used to access IDE_IFR.
> Ideally, that should be converted to use the base from the resource,
> too.
> 

Yes, that was my thought too. I can make the change if you like, but I 
can't test it until I set up the appropriate hardware (MAC_IDE_QUADRA or 
MAC_IDE_PB). I do own that hardware but it is located in Melbourne and it 
is now illegal to visit Melbourne without official papers. Besides, once I 
can test on that hardware I can replace the entire driver anyway, and 
this kind of refactoring would become moot.

> >
> > @@ -109,42 +110,65 @@ static const char *mac_ide_name[] =
> >   * Probe for a Macintosh IDE interface
> >   */
> >
> > -static int __init macide_init(void)
> > +static int mac_ide_probe(struct platform_device *pdev)
> >  {
> > -       unsigned long base;
> > -       int irq;
> > +       struct resource *mem, *irq;
> >         struct ide_hw hw, *hws[] = { &hw };
> >         struct ide_port_info d = macide_port_info;
> > +       struct ide_host *host;
> > +       int rc;
> >
> >         if (!MACH_IS_MAC)
> >                 return -ENODEV;
> >
> > -       switch (macintosh_config->ide_type) {
> > -       case MAC_IDE_QUADRA:
> > -               base = IDE_BASE;
> > -               irq = IRQ_NUBUS_F;
> > -               break;
> > -       case MAC_IDE_PB:
> > -               base = IDE_BASE;
> > -               irq = IRQ_NUBUS_C;
> > -               break;
> > -       case MAC_IDE_BABOON:
> > -               base = BABOON_BASE;
> > -               d.port_ops = NULL;
> 
> How does the driver know not to use the special port_ops after
> this change?
> 

The driver always uses the special port_ops after this change because it 
no longer handles the MAC_IDE_BABOON case. That case is handled by either 
drivers/ata/pata_platform.c or drivers/ide/ide_platform.c, depending on 
.config.

> > -               irq = IRQ_BABOON_1;
> > -               break;
> > -       default:
> > +       mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +       if (!mem)
> > +               return -ENODEV;
> > +
> > +       irq = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
> > +       if (!irq)
> >                 return -ENODEV;
> > +
> > +       if (!devm_request_mem_region(&pdev->dev, mem->start,
> > +                                    resource_size(mem), DRV_NAME)) {
> > +               dev_err(&pdev->dev, "resources busy\n");
> > +               return -EBUSY;
> >         }
> >
> >         printk(KERN_INFO "ide: Macintosh %s IDE controller\n",
> >                          mac_ide_name[macintosh_config->ide_type - 1]);
> >
> > -       macide_setup_ports(&hw, base, irq);
> > +       macide_setup_ports(&hw, mem->start, irq->start);
> > +
> > +       rc = ide_host_add(&d, hws, 1, &host);
> > +       if (rc)
> > +               goto release_mem;
> > +
> > +       platform_set_drvdata(pdev, host);
> 
> In general, it's safer to move the platform_set_drvdata() call before
> the ide_host_add() call, as the IDE core may start calling into your
> driver as soon as the host has been added.  Fortunately you're using
> dev_get_drvdata() in the .remove() callback only, and not in other parts
> of the driver.
> 

Right.

> > +       return 0;
> > +
> > +release_mem:
> > +       release_mem_region(mem->start, resource_size(mem));
> 
> Not needed, as you used devm_*() for allocation.
> 

OK, I'll remove this. I put it there after I looked at falconide.c and 
wondered whether the automatic release would take place after both init 
failure and exit (or just exit). I see now that pata_gayle.c does it 
differently.

> > +       return rc;
> > +}
> > +
> > +static int mac_ide_remove(struct platform_device *pdev)
> > +{
> > +       struct ide_host *host = dev_get_drvdata(&pdev->dev);
> >
> > -       return ide_host_add(&d, hws, 1, NULL);
> > +       ide_host_remove(host);
> > +       return 0;
> >  }
> 
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
