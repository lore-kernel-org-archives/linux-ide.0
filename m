Return-Path: <SRS0=jKCH=W6=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56CC1C3A5A2
	for <linux-ide@archiver.kernel.org>; Tue,  3 Sep 2019 12:44:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3276420674
	for <linux-ide@archiver.kernel.org>; Tue,  3 Sep 2019 12:44:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728865AbfICMoY (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 3 Sep 2019 08:44:24 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:46751 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728983AbfICMoY (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 3 Sep 2019 08:44:24 -0400
Received: by mail-oi1-f195.google.com with SMTP id t24so12583554oij.13;
        Tue, 03 Sep 2019 05:44:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YIMNXxwLXbmr0qSldo8Vj3h5er3qrI7OSMrddj6hZmE=;
        b=agf6jWWSSH3RKDq0sn6gg7AeNz90RJtyQra3XZmUI7zb34LJEvSkMH875CPdcH/bif
         vL7QhHOUBI4+0sdBGaKf1t/dpg4HCDKFmD5KOhzVHqEJvOZMdAyJOoA7KiztPycglqLu
         nLzZBhCJjgRJuRUNv5M5xNIAVFy+3G2enSE1x3urqS6f7FTxTX+3zm6tep6tiyBfcdxY
         kiO/q6asn1hi+IQKAJ3XrHdWO28Er8p0NjHGJaF4+xa/1tpNNySFD0+TCLoNfqzI9Y7N
         GaYQeurnWyOQVMEUMYv8RRyEKh2xI0qCjKzL5IJUs3EDdcRnYs7pbK2goZ4wALDtrn0T
         2f3g==
X-Gm-Message-State: APjAAAV4qFK3FdNgjh4oFGQ9K9ZXjAf2meNPvSowhi/ZEppPoWFpt48l
        dOAxlMgBWQmR3lEX0FS+mBZ2LhsF/PXznZi+irk=
X-Google-Smtp-Source: APXvYqz+a9nv4GrvvQ0moC6Y63nwVmY08nRiRklB+FY+3ztJSDGy6wAzmENurCcXPzOekkIFnEsvAFrqmUw+dSK99Qs=
X-Received: by 2002:aca:ea82:: with SMTP id i124mr21756297oih.153.1567514663372;
 Tue, 03 Sep 2019 05:44:23 -0700 (PDT)
MIME-Version: 1.0
References: <1562018556-15090-1-git-send-email-schmitzmic@gmail.com> <1562018556-15090-3-git-send-email-schmitzmic@gmail.com>
In-Reply-To: <1562018556-15090-3-git-send-email-schmitzmic@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 3 Sep 2019 14:44:12 +0200
Message-ID: <CAMuHMdXeb2gUz92C-QqWmVLnpncArMkzgsJKNSz3F8J6ri89TQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] drivers/ata: convert pata_falcon to arch platform device
To:     Michael Schmitz <schmitzmic@gmail.com>
Cc:     "Linux/m68k" <linux-m68k@vger.kernel.org>,
        linux-ide@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Hi Michael,

On Tue, Jul 2, 2019 at 12:02 AM Michael Schmitz <schmitzmic@gmail.com> wrote:
> The Atari platform device setup now provides a platform device
> for the Falcon IDE interface. Use this in place of the simple platform
> device set up in the old pata_falcon probe code.
>
> Signed-off-by: Michael Schmitz <schmitzmic@gmail.com>

Thanks for your patch!

> --- a/drivers/ata/pata_falcon.c
> +++ b/drivers/ata/pata_falcon.c
> @@ -120,23 +120,21 @@ static int pata_falcon_set_mode(struct ata_link *link,
>         .set_mode       = pata_falcon_set_mode,
>  };
>
> -static int pata_falcon_init_one(void)
> +static int __init pata_falcon_init_one(struct platform_device *pdev)
>  {
> +       struct resource *res;
>         struct ata_host *host;
>         struct ata_port *ap;
> -       struct platform_device *pdev;
>         void __iomem *base;
>
> -       if (!MACH_IS_ATARI || !ATARIHW_PRESENT(IDE))
> -               return -ENODEV;
> -
> -       pr_info(DRV_NAME ": Atari Falcon PATA controller\n");
> +       dev_info(&pdev->dev, ": Atari Falcon PATA controller\n");
>
> -       pdev = platform_device_register_simple(DRV_NAME, 0, NULL, 0);
> -       if (IS_ERR(pdev))
> -               return PTR_ERR(pdev);
> +       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +       if (!res)
> +               return -ENODEV;
>
> -       if (!devm_request_mem_region(&pdev->dev, ATA_HD_BASE, 0x40, DRV_NAME)) {

ATA_HD_BASE is now unused, and can be removed.

> +       if (!devm_request_mem_region(&pdev->dev, res->start,
> +                                    resource_size(res), DRV_NAME)) {
>                 pr_err(DRV_NAME ": resources busy\n");

dev_err(&pdev->dev, "resources busy\n");

>                 return -EBUSY;
>         }

> @@ -174,9 +172,26 @@ static int pata_falcon_init_one(void)
>         return ata_host_activate(host, 0, NULL, 0, &pata_falcon_sht);
>  }
>
> -module_init(pata_falcon_init_one);
> +static int __exit pata_falcon_remove_one(struct platform_device *pdev)
> +{
> +       struct ata_host *host = platform_get_drvdata(pdev);
> +
> +       ata_host_detach(host);
> +
> +       return 0;
> +}
> +
> +static struct platform_driver pata_falcon_driver = {
> +       .remove = __exit_p(pata_falcon_remove_one),
> +       .driver   = {
> +               .name   = "atari-falcon-ide",
> +       },
> +};
> +
> +module_platform_driver_probe(pata_falcon_driver, pata_falcon_init_one);

This doesn't seem to work in the builtin case (e.g. atari_defconfig with
ide replaced by ata): no hard drives are detected.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
