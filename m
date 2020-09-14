Return-Path: <SRS0=CJGR=CX=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4368C2BC11
	for <linux-ide@archiver.kernel.org>; Mon, 14 Sep 2020 12:02:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D58821655
	for <linux-ide@archiver.kernel.org>; Mon, 14 Sep 2020 12:02:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726070AbgINMAv (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 14 Sep 2020 08:00:51 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:37398 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726073AbgINLnJ (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 14 Sep 2020 07:43:09 -0400
Received: by mail-oi1-f193.google.com with SMTP id a3so17531511oib.4;
        Mon, 14 Sep 2020 04:43:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MAnMfyqXWfQGfIGw15jGsaHsgLXdnRjwDpDAGMwU7WA=;
        b=l76HGE1NsOISgVHXfSQ9SiLtk2TOix9aj/YJ0J0SPZudXlpdkLP1v6DcZKG6Ddw8s8
         NNsQ8AokJzRUmpVDqTFD/YUjdgK+hthpTDFcYzkVMMbx07EWRU184ZQ2IZ8EiUVTYLpQ
         eH2MzbpoDVMwRQ8asu6V+mdv4a+LNzOThzg/CSdK4611CwTviLkINyYaX7UIEmWMP2Gh
         ZPvt8yRyvhoVU6zpy+G6EIouGkaXDemsXuXzh3Q2MxMdVJ2SI/ZA+e4aIx1uBaubZwrs
         2J/vGRWq7xpiREnUrJQEl5Su49RQXOB+8I/pVuXhlhLnrkVS8MW5uJubxmLoQOYapX7B
         l/1g==
X-Gm-Message-State: AOAM531Gj3oci8H++Gc8J9k0AZCPxjNVU4Y4mpfnc9k3yiLnkiaEzS4H
        VNDn4pchByt03RdzG7pzf0Z6II4dpUV9/ESl69E=
X-Google-Smtp-Source: ABdhPJx1JN0QWdrAwf9e1fPzpz0MTklVvosg75s+ekjAUlq1Q5Wjd87gxkBY2lffCmxyNTGaVh+NOl9PcAyV+g77LRM=
X-Received: by 2002:aca:3bc3:: with SMTP id i186mr7592032oia.148.1600083788561;
 Mon, 14 Sep 2020 04:43:08 -0700 (PDT)
MIME-Version: 1.0
References: <3cf40b9df80a99a3eee6d3af79437016038f0a44.1600051331.git.fthain@telegraphics.com.au>
In-Reply-To: <3cf40b9df80a99a3eee6d3af79437016038f0a44.1600051331.git.fthain@telegraphics.com.au>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 14 Sep 2020 13:42:57 +0200
Message-ID: <CAMuHMdUOdOkBE72ouk0W_bXnoSTFqLsLKag+2LSRz+Qox6MoxQ@mail.gmail.com>
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

On Mon, Sep 14, 2020 at 4:47 AM Finn Thain <fthain@telegraphics.com.au> wrote:
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
> ---
> This patch was tested successfully on a Powerbook 190 (MAC_IDE_BABOON)
> using both pata_platform and ide_platform drivers.
> The next step will be to try using these generic drivers with the other
> IDE controller variants (MAC_IDE_QUADRA or MAC_IDE_PB) so that the macide
> driver can be entirely replaced with libata drivers.
>
> Changed since v1:
>  - Adopted DEFINE_RES_MEM and DEFINE_RES_IRQ macros.
>  - Dropped IORESOURCE_IRQ_SHAREABLE flag as it is ignored by pata_platform.c
>    and IRQF_SHARED makes no difference in this case.
>  - Removed redundant release_mem_region() call.
>  - Enabled CONFIG_BLK_DEV_PLATFORM in mac_defconfig. We might also enable
>    CONFIG_PATA_PLATFORM but IMO migration to libata should be a separate
>    patch (as this patch has some unrelated benefits).

Thanks for the update!

BTW, who do you envision taking this (or the next version)? IDE or m68k?

> --- a/arch/m68k/configs/mac_defconfig
> +++ b/arch/m68k/configs/mac_defconfig
> @@ -317,6 +317,7 @@ CONFIG_DUMMY_IRQ=m
>  CONFIG_IDE=y
>  CONFIG_IDE_GD_ATAPI=y
>  CONFIG_BLK_DEV_IDECD=y
> +CONFIG_BLK_DEV_PLATFORM=y

I guess we want this in multi_defconfig, too?

>  CONFIG_BLK_DEV_MAC_IDE=y
>  CONFIG_RAID_ATTRS=m
>  CONFIG_SCSI=y

> --- a/drivers/ide/macide.c
> +++ b/drivers/ide/macide.c

> @@ -109,42 +110,61 @@ static const char *mac_ide_name[] =
>   * Probe for a Macintosh IDE interface
>   */
>
> -static int __init macide_init(void)
> +static int mac_ide_probe(struct platform_device *pdev)
>  {

>         printk(KERN_INFO "ide: Macintosh %s IDE controller\n",
>                          mac_ide_name[macintosh_config->ide_type - 1]);
>
> -       macide_setup_ports(&hw, base, irq);
> +       macide_setup_ports(&hw, mem->start, irq->start);
>
> -       return ide_host_add(&d, hws, 1, NULL);
> +       rc = ide_host_add(&d, hws, 1, &host);
> +       if (rc)
> +               return rc;
> +
> +       platform_set_drvdata(pdev, host);

Move one up, to play it safe?

> +       return 0;
>  }
>
> -module_init(macide_init);
> +static int mac_ide_remove(struct platform_device *pdev)
> +{
> +       struct ide_host *host = dev_get_drvdata(&pdev->dev);

As you use platform_set_drvdata() above, you might as well use the
platform_get_drvdata() helper here, for symmetry.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
