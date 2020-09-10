Return-Path: <SRS0=Rbkm=CT=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2BEAC43461
	for <linux-ide@archiver.kernel.org>; Thu, 10 Sep 2020 06:27:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B15B207FB
	for <linux-ide@archiver.kernel.org>; Thu, 10 Sep 2020 06:27:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729741AbgIJG0z (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 10 Sep 2020 02:26:55 -0400
Received: from mail-oo1-f65.google.com ([209.85.161.65]:44790 "EHLO
        mail-oo1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727055AbgIJG0r (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 10 Sep 2020 02:26:47 -0400
Received: by mail-oo1-f65.google.com with SMTP id 4so1169563ooh.11;
        Wed, 09 Sep 2020 23:26:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hMYWnen1mp2PndBlySJixNLe9ykpSa1kAF8b27d2SW4=;
        b=j3SLHG6t3RlCeO2Rol2D1kZWPKSi6GSVj3sX7Sn2UwotvjE+jS9wegZs14jI/Q4t5W
         PliN6cZvI2xV94aqmrc6yV3s22Xl6h8LggD+Rx4StDrFwf3DrhHrk11Qo0bz8irVOiLS
         Jsszk7NtkD6JuDqfXbHD/CRKnp4wST+CIWEE72tDLylfNBmLxrTbN6Yg1mHxUIMWKjJS
         JfMvvVlqawMw+0Gy7w2f4+vGA2dKB1hQFELK3AXdPWTZuHO54QOAOXw4waCkr10paRfv
         TURHkqD1alpBME5TR1g9xYepraN0OXFHkdnHs6ZK+ihaNu2MXl8LYjO8t/LwHTsF7E09
         nTfQ==
X-Gm-Message-State: AOAM531ie4WOtBzVWL0pzAkSeQcFUa2kGVH/k5xsLNj0RoC0DaTDBrzN
        6ltREe4AfXpynZfi9ZvUZmc6HjiaH8W2pbvOYYiV5HK+pRo=
X-Google-Smtp-Source: ABdhPJwHAxLWbiJvqI4z5ncngizc77OWVEiCuTTKUyB3gH9LhEOE2S354S2jGEyEqCnaWU7DIGJt2lytkJHFPfZJVZM=
X-Received: by 2002:a4a:4201:: with SMTP id h1mr3337821ooj.1.1599719206860;
 Wed, 09 Sep 2020 23:26:46 -0700 (PDT)
MIME-Version: 1.0
References: <00ee44fe6ecdce1c783c3cc3b1b9a62b498dcdb2.1597736545.git.fthain@telegraphics.com.au>
 <CAMuHMdWAi6+75Mq0U8x7Ut6viHvF7XEZAcYnxq=jJmtJyAX8pw@mail.gmail.com> <alpine.LNX.2.23.453.2009100920001.8@nippy.intranet>
In-Reply-To: <alpine.LNX.2.23.453.2009100920001.8@nippy.intranet>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 10 Sep 2020 08:26:35 +0200
Message-ID: <CAMuHMdVMvhJRHOwJapi+LAdPbPuoT73ST_Nj0qeCqQd3XWvoSQ@mail.gmail.com>
Subject: Re: [PATCH] ide/macide: Convert Mac IDE driver to platform driver
To:     Finn Thain <fthain@telegraphics.com.au>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Joshua Thompson <funaho@jurai.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-ide@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Hi Finn,

On Thu, Sep 10, 2020 at 2:23 AM Finn Thain <fthain@telegraphics.com.au> wrote:
> On Wed, 9 Sep 2020, Geert Uytterhoeven wrote:
> > > --- a/arch/m68k/mac/config.c +++ b/arch/m68k/mac/config.c
> >
> > > @@ -940,6 +941,50 @@ static const struct resource mac_scsi_ccl_rsrc[] __initconst = {
> > >         },
> > >  };
> > >
> > > +static const struct resource mac_ide_quadra_rsrc[] __initconst = {
> > > +       {
> > > +               .flags = IORESOURCE_MEM,
> > > +               .start = 0x50F1A000,
> > > +               .end   = 0x50F1A103,
> > > +       }, {
> > > +               .flags = IORESOURCE_IRQ,
> > > +               .start = IRQ_NUBUS_F,
> > > +               .end   = IRQ_NUBUS_F,
> > > +       },
> > > +};
> > > +
> > > +static const struct resource mac_ide_pb_rsrc[] __initconst = {
> > > +       {
> > > +               .flags = IORESOURCE_MEM,
> > > +               .start = 0x50F1A000,
> > > +               .end   = 0x50F1A103,
> > > +       }, {
> > > +               .flags = IORESOURCE_IRQ,
> > > +               .start = IRQ_NUBUS_C,
> > > +               .end   = IRQ_NUBUS_C,
> > > +       },
> > > +};
> >
> > As the above two variants are almost identical, perhaps it makes sense
> > to drop one of them, drop the const, and override the irq values
> > dynamically?
> >
>
> I prefer a declarative or data-driven style, even if it takes a few more
> lines of code. But there is a compromise:
>
> static const struct resource mac_ide_quadra_rsrc[] __initconst = {
>         DEFINE_RES_MEM(0x50F1A000, 0x104),
>         DEFINE_RES_IRQ(IRQ_NUBUS_F),
> }
>
> static const struct resource mac_ide_pb_rsrc[] __initconst = {
>         DEFINE_RES_MEM(0x50F1A000, 0x104),
>         DEFINE_RES_IRQ(IRQ_NUBUS_C),
> }
>
> The reason I didn't use these macros was to avoid making the reader go and
> look up their definitions. Anyway, would that style be preferred here?

I think the DEFINE_RES_*() are sufficiently common (well, in pre-DT
platforms ;-)

> I could do the same with the mac_ide_baboon_rsrc[] initializer:
>
> static const struct resource mac_pata_baboon_rsrc[] __initconst = {
>         DEFINE_RES_MEM(0x50F1A000, 0x38),
>         DEFINE_RES_MEM(0x50F1A038, 0x04),
>         DEFINE_RES_IRQ(IRQ_BABOON_1),
> };
>
> ... but that would lose the IORESOURCE_IRQ_SHAREABLE flag. I'm not sure
> whether that matters (it's a vestige of macide.c).

You can still use DEFINE_RES_NAMED() to pass the flags.
Would you consider that to be a good compromise?

> > > +static const struct resource mac_pata_baboon_rsrc[] __initconst = {
> > > +       {
> > > +               .flags = IORESOURCE_MEM,
> > > +               .start = 0x50F1A000,
> > > +               .end   = 0x50F1A037,
> > > +       }, {
> > > +               .flags = IORESOURCE_MEM,
> > > +               .start = 0x50F1A038,
> > > +               .end   = 0x50F1A03B,
> > > +       }, {
> > > +               .flags = IORESOURCE_IRQ | IORESOURCE_IRQ_SHAREABLE,
> > > +               .start = IRQ_BABOON_1,
> > > +               .end   = IRQ_BABOON_1,
> > > +       },
> > > +};
> > > +
> > > +static const struct pata_platform_info mac_pata_baboon_data __initconst = {
> > > +       .ioport_shift  = 2,
> > > +};
> >
> > Just wondering: how is this implemented in drivers/ide/macide.c, which
> > doesn't use the platform info?
>
> That factor of 4 is embedded in the address caclulation:
>
>         for (i = 0; i < 8; i++)
>                 hw->io_ports_array[i] = base + i * 4;

IC. But in the new code, the platform info is passed for Baboon only,
while the old code used it for all variants.

> > > --- a/drivers/ide/macide.c
> > > +++ b/drivers/ide/macide.c
> > > @@ -18,10 +18,11 @@
> > >  #include <linux/delay.h>
> > >  #include <linux/ide.h>
> > >  #include <linux/module.h>
> > > +#include <linux/platform_device.h>
> > >
> > >  #include <asm/macintosh.h>
> > > -#include <asm/macints.h>
> > > -#include <asm/mac_baboon.h>
> > > +
> > > +#define DRV_NAME "mac_ide"
> > >
> > >  #define IDE_BASE 0x50F1A000    /* Base address of IDE controller */
> >
> > Do you still need this definition?
> > Yes, because it's still used to access IDE_IFR.
> > Ideally, that should be converted to use the base from the resource,
> > too.
> >
>
> Yes, that was my thought too. I can make the change if you like, but I
> can't test it until I set up the appropriate hardware (MAC_IDE_QUADRA or
> MAC_IDE_PB). I do own that hardware but it is located in Melbourne and it
> is now illegal to visit Melbourne without official papers. Besides, once I
> can test on that hardware I can replace the entire driver anyway, and
> this kind of refactoring would become moot.

OK.

> > > @@ -109,42 +110,65 @@ static const char *mac_ide_name[] =
> > >   * Probe for a Macintosh IDE interface
> > >   */
> > >
> > > -static int __init macide_init(void)
> > > +static int mac_ide_probe(struct platform_device *pdev)
> > >  {
> > > -       unsigned long base;
> > > -       int irq;
> > > +       struct resource *mem, *irq;
> > >         struct ide_hw hw, *hws[] = { &hw };
> > >         struct ide_port_info d = macide_port_info;
> > > +       struct ide_host *host;
> > > +       int rc;
> > >
> > >         if (!MACH_IS_MAC)
> > >                 return -ENODEV;
> > >
> > > -       switch (macintosh_config->ide_type) {
> > > -       case MAC_IDE_QUADRA:
> > > -               base = IDE_BASE;
> > > -               irq = IRQ_NUBUS_F;
> > > -               break;
> > > -       case MAC_IDE_PB:
> > > -               base = IDE_BASE;
> > > -               irq = IRQ_NUBUS_C;
> > > -               break;
> > > -       case MAC_IDE_BABOON:
> > > -               base = BABOON_BASE;
> > > -               d.port_ops = NULL;
> >
> > How does the driver know not to use the special port_ops after
> > this change?
> >
>
> The driver always uses the special port_ops after this change because it
> no longer handles the MAC_IDE_BABOON case. That case is handled by either

non-MAC_IDE_BABOON case?

> drivers/ata/pata_platform.c or drivers/ide/ide_platform.c, depending on
> .config.

Ideally, we do need to differentiate, right?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
