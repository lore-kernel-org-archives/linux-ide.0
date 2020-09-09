Return-Path: <SRS0=nx08=CS=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0F0DC43461
	for <linux-ide@archiver.kernel.org>; Wed,  9 Sep 2020 08:21:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5EE7C2076C
	for <linux-ide@archiver.kernel.org>; Wed,  9 Sep 2020 08:21:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727113AbgIIIV2 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 9 Sep 2020 04:21:28 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:34248 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726036AbgIIIV2 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 9 Sep 2020 04:21:28 -0400
Received: by mail-ot1-f65.google.com with SMTP id h17so1614723otr.1;
        Wed, 09 Sep 2020 01:21:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MNqX1Kt5t6A882o2HZ+jAXfNO+3aimU6By7fOQmqm98=;
        b=f/p8QDtdCXloiyHFHH6IrAWtyomRfgy+/xB+fwvlSppu5VG0cCcH85Wf0aRgEQzz/o
         ZWtNWHI21ZdubUN31HlqChdiXUBp/J6nwsI8DynuUB8Xd9SxlyV9A9fBwKRcWrYXOU/t
         L0MLF3WrT9sseDRxsWyK36SBqkB/2uy9pB7XQ/HfWtw99bx5T3fM7cb2PCdJG1R7e002
         /ljNc/XXWBds4shk6hY/qp7U/GYkLWyM86t5Hh3DL4t47WVNDQlArCDQuQQOFp6VcVXg
         CoI2cK0UiBkRJPDZ+jlcqDUu7yJjHAJkBGTeKYx1zb93FuLovERO0mDCPPzCk9zu9xIT
         czMg==
X-Gm-Message-State: AOAM531/26M/bGpSxP6meJOtltBKf47eyzAfE4ttRag4FScN5hF37Cmr
        UbHIy8RLaOIaqPvidfxhaZRJAfmcdJA4ckC0peQ=
X-Google-Smtp-Source: ABdhPJyvd43SWzG5LyW2aRTw2GwE/DHa8tT1EXEaIPkFBhB8GNPaudlgcawhcfESMDqyZWQtLxKS41hp6S80qQ7ylfw=
X-Received: by 2002:a9d:3b76:: with SMTP id z109mr2012536otb.250.1599639687255;
 Wed, 09 Sep 2020 01:21:27 -0700 (PDT)
MIME-Version: 1.0
References: <00ee44fe6ecdce1c783c3cc3b1b9a62b498dcdb2.1597736545.git.fthain@telegraphics.com.au>
In-Reply-To: <00ee44fe6ecdce1c783c3cc3b1b9a62b498dcdb2.1597736545.git.fthain@telegraphics.com.au>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 9 Sep 2020 10:21:15 +0200
Message-ID: <CAMuHMdWAi6+75Mq0U8x7Ut6viHvF7XEZAcYnxq=jJmtJyAX8pw@mail.gmail.com>
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

On Tue, Aug 18, 2020 at 9:45 AM Finn Thain <fthain@telegraphics.com.au> wrote:
> Add platform devices for the Mac IDE controller variants. Convert the
> macide module into a platform driver to support two of those variants.
> For the third, use a generic "pata_platform" driver instead.
> This enables automatic loading of the appropriate module and begins
> the process of replacing the driver with libata alternatives.
>
> Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: Joshua Thompson <funaho@jurai.org>
> References: commit 5ed0794cde593 ("m68k/atari: Convert Falcon IDE drivers to platform drivers")
> References: commit 7ad19a99ad431 ("ide: officially deprecated the legacy IDE driver")
> Tested-by: Stan Johnson <userm57@yahoo.com>
> Signed-off-by: Finn Thain <fthain@telegraphics.com.au>

Thanks for your patch!

> --- a/arch/m68k/mac/config.c
> +++ b/arch/m68k/mac/config.c

> @@ -940,6 +941,50 @@ static const struct resource mac_scsi_ccl_rsrc[] __initconst = {
>         },
>  };
>
> +static const struct resource mac_ide_quadra_rsrc[] __initconst = {
> +       {
> +               .flags = IORESOURCE_MEM,
> +               .start = 0x50F1A000,
> +               .end   = 0x50F1A103,
> +       }, {
> +               .flags = IORESOURCE_IRQ,
> +               .start = IRQ_NUBUS_F,
> +               .end   = IRQ_NUBUS_F,
> +       },
> +};
> +
> +static const struct resource mac_ide_pb_rsrc[] __initconst = {
> +       {
> +               .flags = IORESOURCE_MEM,
> +               .start = 0x50F1A000,
> +               .end   = 0x50F1A103,
> +       }, {
> +               .flags = IORESOURCE_IRQ,
> +               .start = IRQ_NUBUS_C,
> +               .end   = IRQ_NUBUS_C,
> +       },
> +};

As the above two variants are almost identical, perhaps it makes sense
to drop one of them, drop the const, and override the irq values
dynamically?

> +
> +static const struct resource mac_pata_baboon_rsrc[] __initconst = {
> +       {
> +               .flags = IORESOURCE_MEM,
> +               .start = 0x50F1A000,
> +               .end   = 0x50F1A037,
> +       }, {
> +               .flags = IORESOURCE_MEM,
> +               .start = 0x50F1A038,
> +               .end   = 0x50F1A03B,
> +       }, {
> +               .flags = IORESOURCE_IRQ | IORESOURCE_IRQ_SHAREABLE,
> +               .start = IRQ_BABOON_1,
> +               .end   = IRQ_BABOON_1,
> +       },
> +};
> +
> +static const struct pata_platform_info mac_pata_baboon_data __initconst = {
> +       .ioport_shift  = 2,
> +};

Just wondering: how is this implemented in drivers/ide/macide.c, which
doesn't use the platform info?

> --- a/drivers/ide/macide.c
> +++ b/drivers/ide/macide.c
> @@ -18,10 +18,11 @@
>  #include <linux/delay.h>
>  #include <linux/ide.h>
>  #include <linux/module.h>
> +#include <linux/platform_device.h>
>
>  #include <asm/macintosh.h>
> -#include <asm/macints.h>
> -#include <asm/mac_baboon.h>
> +
> +#define DRV_NAME "mac_ide"
>
>  #define IDE_BASE 0x50F1A000    /* Base address of IDE controller */

Do you still need this definition?
Yes, because it's still used to access IDE_IFR.
Ideally, that should be converted to use the base from the resource,
too.

>
> @@ -109,42 +110,65 @@ static const char *mac_ide_name[] =
>   * Probe for a Macintosh IDE interface
>   */
>
> -static int __init macide_init(void)
> +static int mac_ide_probe(struct platform_device *pdev)
>  {
> -       unsigned long base;
> -       int irq;
> +       struct resource *mem, *irq;
>         struct ide_hw hw, *hws[] = { &hw };
>         struct ide_port_info d = macide_port_info;
> +       struct ide_host *host;
> +       int rc;
>
>         if (!MACH_IS_MAC)
>                 return -ENODEV;
>
> -       switch (macintosh_config->ide_type) {
> -       case MAC_IDE_QUADRA:
> -               base = IDE_BASE;
> -               irq = IRQ_NUBUS_F;
> -               break;
> -       case MAC_IDE_PB:
> -               base = IDE_BASE;
> -               irq = IRQ_NUBUS_C;
> -               break;
> -       case MAC_IDE_BABOON:
> -               base = BABOON_BASE;
> -               d.port_ops = NULL;

How does the driver know not to use the special port_ops after
this change?

> -               irq = IRQ_BABOON_1;
> -               break;
> -       default:
> +       mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +       if (!mem)
> +               return -ENODEV;
> +
> +       irq = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
> +       if (!irq)
>                 return -ENODEV;
> +
> +       if (!devm_request_mem_region(&pdev->dev, mem->start,
> +                                    resource_size(mem), DRV_NAME)) {
> +               dev_err(&pdev->dev, "resources busy\n");
> +               return -EBUSY;
>         }
>
>         printk(KERN_INFO "ide: Macintosh %s IDE controller\n",
>                          mac_ide_name[macintosh_config->ide_type - 1]);
>
> -       macide_setup_ports(&hw, base, irq);
> +       macide_setup_ports(&hw, mem->start, irq->start);
> +
> +       rc = ide_host_add(&d, hws, 1, &host);
> +       if (rc)
> +               goto release_mem;
> +
> +       platform_set_drvdata(pdev, host);

In general, it's safer to move the platform_set_drvdata() call before
the ide_host_add() call, as the IDE core may start calling into your
driver as soon as the host has been added.  Fortunately you're using
dev_get_drvdata() in the .remove() callback only, and not in other parts
of the driver.

> +       return 0;
> +
> +release_mem:
> +       release_mem_region(mem->start, resource_size(mem));

Not needed, as you used devm_*() for allocation.

> +       return rc;
> +}
> +
> +static int mac_ide_remove(struct platform_device *pdev)
> +{
> +       struct ide_host *host = dev_get_drvdata(&pdev->dev);
>
> -       return ide_host_add(&d, hws, 1, NULL);
> +       ide_host_remove(host);
> +       return 0;
>  }


Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
