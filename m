Return-Path: <SRS0=lv1h=CY=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7013C2D0E0
	for <linux-ide@archiver.kernel.org>; Tue, 15 Sep 2020 07:15:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4B72206BE
	for <linux-ide@archiver.kernel.org>; Tue, 15 Sep 2020 07:15:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726125AbgIOHP3 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 15 Sep 2020 03:15:29 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:39329 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726114AbgIOHP1 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 15 Sep 2020 03:15:27 -0400
Received: by mail-ot1-f68.google.com with SMTP id u25so2280245otq.6;
        Tue, 15 Sep 2020 00:15:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0AAGDKBZ0tFUr5jZMaLm57FUfXngPQn4Fl7eT0hJb94=;
        b=LBvZdPi5b8z7Pf914TrPv2mremD6kGRtz1OXrkI2Ibm7AvHwE2l3NuMuCMBKMj9iGb
         Fx87uQGb0HVlW89R+qJTub4pg4hTIXTKg1yyIwDp5eOAshXTOY0vDXQ4dHFE0FnGegJF
         LrQNSBLhd2J3bzUmOayXMiuNLsc0/d3gBAHwg4isFiFLGfYFnfDMrcg14J3HRbPtUn5s
         tHOlpqa0th3oQAlOKbaYWYHEp0PK6tp7o9HH715sclBlPnx/cnVy33pArh1qDPuUZk+x
         aCIHfL3ZYujfEOiiSZFR6K+hVRnWIwGBZ7UbuU89FAovtMNyAzkqjx7iX7+HS9h12ykE
         OfyA==
X-Gm-Message-State: AOAM532lCbRn2/R/15kCqClN7f1KPveLYvhsXx6B9wNpSVEEiYJA6w0H
        v9H9rzdi88Nz/wlVLjemg5CAo7roS4NSKb9tfs8=
X-Google-Smtp-Source: ABdhPJzpO6RY/Lf4aDWUwHVYZc+GKQNaoNRQKjM2D7I9mlw4/3hODeF9iB9mFH88D/jBylkfQL8N1JMQjv4xKH0nCAY=
X-Received: by 2002:a05:6830:1008:: with SMTP id a8mr11032303otp.107.1600154122683;
 Tue, 15 Sep 2020 00:15:22 -0700 (PDT)
MIME-Version: 1.0
References: <3cf40b9df80a99a3eee6d3af79437016038f0a44.1600051331.git.fthain@telegraphics.com.au>
 <CAMuHMdUOdOkBE72ouk0W_bXnoSTFqLsLKag+2LSRz+Qox6MoxQ@mail.gmail.com> <alpine.LNX.2.23.453.2009150945480.6@nippy.intranet>
In-Reply-To: <alpine.LNX.2.23.453.2009150945480.6@nippy.intranet>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 15 Sep 2020 09:15:11 +0200
Message-ID: <CAMuHMdX1GXMGg1mviE_msM1vx0ZLEKEPT4AacSBjYDzN6sZVmw@mail.gmail.com>
Subject: Re: [PATCH v2] ide/macide: Convert Mac IDE driver to platform driver
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

On Tue, Sep 15, 2020 at 3:17 AM Finn Thain <fthain@telegraphics.com.au> wrote:
> On Mon, 14 Sep 2020, Geert Uytterhoeven wrote:
> > On Mon, Sep 14, 2020 at 4:47 AM Finn Thain <fthain@telegraphics.com.au> wrote:
> > > Add platform devices for the Mac IDE controller variants. Convert the
> > > macide module into a platform driver to support two of those variants.
> > > For the third, use a generic "pata_platform" driver instead.
> > > This enables automatic loading of the appropriate module and begins
> > > the process of replacing the driver with libata alternatives.
> > >
> > > Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> > > Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> > > Cc: Joshua Thompson <funaho@jurai.org>
> > > References: commit 5ed0794cde593 ("m68k/atari: Convert Falcon IDE drivers to platform drivers")
> > > References: commit 7ad19a99ad431 ("ide: officially deprecated the legacy IDE driver")
> > > Tested-by: Stan Johnson <userm57@yahoo.com>
> > > Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
> > > ---
> > > This patch was tested successfully on a Powerbook 190 (MAC_IDE_BABOON)
> > > using both pata_platform and ide_platform drivers.
> > > The next step will be to try using these generic drivers with the other
> > > IDE controller variants (MAC_IDE_QUADRA or MAC_IDE_PB) so that the macide
> > > driver can be entirely replaced with libata drivers.
> > >
> > > Changed since v1:
> > >  - Adopted DEFINE_RES_MEM and DEFINE_RES_IRQ macros.
> > >  - Dropped IORESOURCE_IRQ_SHAREABLE flag as it is ignored by pata_platform.c
> > >    and IRQF_SHARED makes no difference in this case.
> > >  - Removed redundant release_mem_region() call.
> > >  - Enabled CONFIG_BLK_DEV_PLATFORM in mac_defconfig. We might also enable
> > >    CONFIG_PATA_PLATFORM but IMO migration to libata should be a separate
> > >    patch (as this patch has some unrelated benefits).
> >
> > Thanks for the update!
> >
> > BTW, who do you envision taking this (or the next version)? IDE or m68k?
> >
>
> It's unclear from the diff stat. But the focus is on the platform which
> probably means it is more interesting to you, as the arch maintainer.

Fair enough.

Looking for an Acked-by from the IDE maintainer...

> > > --- a/drivers/ide/macide.c
> > > +++ b/drivers/ide/macide.c
> >
> > > @@ -109,42 +110,61 @@ static const char *mac_ide_name[] =
> > >   * Probe for a Macintosh IDE interface
> > >   */
> > >
> > > -static int __init macide_init(void)
> > > +static int mac_ide_probe(struct platform_device *pdev)
> > >  {
> >
> > >         printk(KERN_INFO "ide: Macintosh %s IDE controller\n",
> > >                          mac_ide_name[macintosh_config->ide_type - 1]);
> > >
> > > -       macide_setup_ports(&hw, base, irq);
> > > +       macide_setup_ports(&hw, mem->start, irq->start);
> > >
> > > -       return ide_host_add(&d, hws, 1, NULL);
> > > +       rc = ide_host_add(&d, hws, 1, &host);
> > > +       if (rc)
> > > +               return rc;
> > > +
> > > +       platform_set_drvdata(pdev, host);
> >
> > Move one up, to play it safe?
> >
>
> You mean, before calling ide_host_add? The 'host' pointer is uninitialized
> prior to that call.

Oh right, so the IDE subsystem doesn't let you use the drvdata inside
your driver (besides in remove()) in a safe way :-(

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
