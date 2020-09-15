Return-Path: <SRS0=lv1h=CY=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78B2BC433E2
	for <linux-ide@archiver.kernel.org>; Tue, 15 Sep 2020 01:17:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3EFA820732
	for <linux-ide@archiver.kernel.org>; Tue, 15 Sep 2020 01:17:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725999AbgIOBRu (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 14 Sep 2020 21:17:50 -0400
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:52064 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726019AbgIOBRt (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 14 Sep 2020 21:17:49 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by kvm5.telegraphics.com.au (Postfix) with ESMTP id CA72D2A026;
        Mon, 14 Sep 2020 21:17:43 -0400 (EDT)
Date:   Tue, 15 Sep 2020 11:17:43 +1000 (AEST)
From:   Finn Thain <fthain@telegraphics.com.au>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
cc:     "David S. Miller" <davem@davemloft.net>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Joshua Thompson <funaho@jurai.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-ide@vger.kernel.org
Subject: Re: [PATCH v2] ide/macide: Convert Mac IDE driver to platform
 driver
In-Reply-To: <CAMuHMdUOdOkBE72ouk0W_bXnoSTFqLsLKag+2LSRz+Qox6MoxQ@mail.gmail.com>
Message-ID: <alpine.LNX.2.23.453.2009150945480.6@nippy.intranet>
References: <3cf40b9df80a99a3eee6d3af79437016038f0a44.1600051331.git.fthain@telegraphics.com.au> <CAMuHMdUOdOkBE72ouk0W_bXnoSTFqLsLKag+2LSRz+Qox6MoxQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On Mon, 14 Sep 2020, Geert Uytterhoeven wrote:

> Hi Finn,
> 
> On Mon, Sep 14, 2020 at 4:47 AM Finn Thain <fthain@telegraphics.com.au> wrote:
> > Add platform devices for the Mac IDE controller variants. Convert the
> > macide module into a platform driver to support two of those variants.
> > For the third, use a generic "pata_platform" driver instead.
> > This enables automatic loading of the appropriate module and begins
> > the process of replacing the driver with libata alternatives.
> >
> > Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> > Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> > Cc: Joshua Thompson <funaho@jurai.org>
> > References: commit 5ed0794cde593 ("m68k/atari: Convert Falcon IDE drivers to platform drivers")
> > References: commit 7ad19a99ad431 ("ide: officially deprecated the legacy IDE driver")
> > Tested-by: Stan Johnson <userm57@yahoo.com>
> > Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
> > ---
> > This patch was tested successfully on a Powerbook 190 (MAC_IDE_BABOON)
> > using both pata_platform and ide_platform drivers.
> > The next step will be to try using these generic drivers with the other
> > IDE controller variants (MAC_IDE_QUADRA or MAC_IDE_PB) so that the macide
> > driver can be entirely replaced with libata drivers.
> >
> > Changed since v1:
> >  - Adopted DEFINE_RES_MEM and DEFINE_RES_IRQ macros.
> >  - Dropped IORESOURCE_IRQ_SHAREABLE flag as it is ignored by pata_platform.c
> >    and IRQF_SHARED makes no difference in this case.
> >  - Removed redundant release_mem_region() call.
> >  - Enabled CONFIG_BLK_DEV_PLATFORM in mac_defconfig. We might also enable
> >    CONFIG_PATA_PLATFORM but IMO migration to libata should be a separate
> >    patch (as this patch has some unrelated benefits).
> 
> Thanks for the update!
> 
> BTW, who do you envision taking this (or the next version)? IDE or m68k?
> 

It's unclear from the diff stat. But the focus is on the platform which 
probably means it is more interesting to you, as the arch maintainer.

> > --- a/arch/m68k/configs/mac_defconfig
> > +++ b/arch/m68k/configs/mac_defconfig
> > @@ -317,6 +317,7 @@ CONFIG_DUMMY_IRQ=m
> >  CONFIG_IDE=y
> >  CONFIG_IDE_GD_ATAPI=y
> >  CONFIG_BLK_DEV_IDECD=y
> > +CONFIG_BLK_DEV_PLATFORM=y
> 
> I guess we want this in multi_defconfig, too?
> 

Right. I'll add that in v3.

> >  CONFIG_BLK_DEV_MAC_IDE=y
> >  CONFIG_RAID_ATTRS=m
> >  CONFIG_SCSI=y
> 
> > --- a/drivers/ide/macide.c
> > +++ b/drivers/ide/macide.c
> 
> > @@ -109,42 +110,61 @@ static const char *mac_ide_name[] =
> >   * Probe for a Macintosh IDE interface
> >   */
> >
> > -static int __init macide_init(void)
> > +static int mac_ide_probe(struct platform_device *pdev)
> >  {
> 
> >         printk(KERN_INFO "ide: Macintosh %s IDE controller\n",
> >                          mac_ide_name[macintosh_config->ide_type - 1]);
> >
> > -       macide_setup_ports(&hw, base, irq);
> > +       macide_setup_ports(&hw, mem->start, irq->start);
> >
> > -       return ide_host_add(&d, hws, 1, NULL);
> > +       rc = ide_host_add(&d, hws, 1, &host);
> > +       if (rc)
> > +               return rc;
> > +
> > +       platform_set_drvdata(pdev, host);
> 
> Move one up, to play it safe?
> 

You mean, before calling ide_host_add? The 'host' pointer is uninitialized 
prior to that call.

> > +       return 0;
> >  }
> >
> > -module_init(macide_init);
> > +static int mac_ide_remove(struct platform_device *pdev)
> > +{
> > +       struct ide_host *host = dev_get_drvdata(&pdev->dev);
> 
> As you use platform_set_drvdata() above, you might as well use the
> platform_get_drvdata() helper here, for symmetry.
> 

Will do.

Thanks for your review.

> Gr{oetje,eeting}s,
> 
>                         Geert
