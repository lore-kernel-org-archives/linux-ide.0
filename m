Return-Path: <SRS0=rygF=Y5=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39B09C49EAC
	for <linux-ide@archiver.kernel.org>; Tue,  5 Nov 2019 08:11:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B066214B2
	for <linux-ide@archiver.kernel.org>; Tue,  5 Nov 2019 08:11:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388018AbfKEILS (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 5 Nov 2019 03:11:18 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:33445 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388013AbfKEILS (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 5 Nov 2019 03:11:18 -0500
Received: by mail-oi1-f195.google.com with SMTP id m193so16739579oig.0;
        Tue, 05 Nov 2019 00:11:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CTR6h9BdcbK2gA4XTci6l5XJM1OLEpKatiMre83pJKQ=;
        b=XvNLt1/rAaps9Tinqhh1Rvv3KnVQoA+gIYpXvBnF8N9gm3+w/vGhPEwRzDy5D5qL/v
         jWszrKFC3pP8/p/4yAMb79RFfAcQIedpaRKJXKsB/rcl2m9pif00h93sP1rlBtAFmsDg
         jIagaRiVx4toxKMQeo1a+x3GaZ16982MwzgtvVsQqd4J/mO2IASWU4AsG09ImxktWicD
         7tLf777h3+VCSMArIuU2dGo79psEAsEC7H5PrhlOsqXga+llcZVOc7+Ybbl1j+jrFkDz
         RJN0IvgpIgc959ifqe/mC0gMNuMFAm//rVK56ZXEeVOS5+O8ZsNx9or7nxTY4IjodbUq
         hpiw==
X-Gm-Message-State: APjAAAXTJwSkG4fIMA+WlcuWAfWi0GcUEosA3I94gl3sJ0MWvcfOJCt3
        WC4pGsvfSeLycJUgbk9t6ubM+X3xy8tSv6IzSaC35BKw
X-Google-Smtp-Source: APXvYqwyFzZqK4lpRYY/gRIhMiinb2VhwCHV34VIcKNw7M7Mn9tXbhSm1YvTNb5OU7QZAHFwduvO4Pv60wkhaXJXuNc=
X-Received: by 2002:aca:fc92:: with SMTP id a140mr2708293oii.153.1572941477445;
 Tue, 05 Nov 2019 00:11:17 -0800 (PST)
MIME-Version: 1.0
References: <4cb95fe6-c2ea-0195-9124-fc2e1223ab38@gmail.com> <1572935872-28394-1-git-send-email-schmitzmic@gmail.com>
In-Reply-To: <1572935872-28394-1-git-send-email-schmitzmic@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 5 Nov 2019 09:11:06 +0100
Message-ID: <CAMuHMdXM+h_GsbkSvyfpLJ0DJixmr-wOS_d5qQrZ8e7VY_bbPg@mail.gmail.com>
Subject: Re: [PATCH] ide: falconide: convert to platform driver
To:     Michael Schmitz <schmitzmic@gmail.com>
Cc:     "Linux/m68k" <linux-m68k@vger.kernel.org>,
        linux-ide@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Michael Schmitz <schmitz@debian.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Hi Michael,

On Tue, Nov 5, 2019 at 7:38 AM Michael Schmitz <schmitzmic@gmail.com> wrote:
> With the introduction of a platform device for the Atari Falcon IDE
> interface, the old Falcon IDE driver no longer loads (resource already
> claimed by the platform device).
>
> Convert falconide driver to use the same platform device that is used
> by pata_falcon also.
>
> Tested (as built-in driver) on my Atari Falcon.
>
> Signed-off-by: Michael Schmitz <schmitzmic@gmail.com>
> CC: Geert Uytterhoeven <geert@linux-m68k.org>

Thanks for your patch!

> --- a/drivers/ide/falconide.c
> +++ b/drivers/ide/falconide.c
> @@ -15,6 +15,7 @@
>  #include <linux/blkdev.h>
>  #include <linux/ide.h>
>  #include <linux/init.h>
> +#include <linux/platform_device.h>
>
>  #include <asm/setup.h>
>  #include <asm/atarihw.h>
> @@ -23,6 +24,7 @@
>  #include <asm/ide.h>
>
>  #define DRV_NAME "falconide"
> +#define DRV_VERSION "0.1.0"

Does anyone care about that version?
Will it ever be updated?

> @@ -169,10 +177,21 @@ static int __init falconide_init(void)
>  err_free:
>         ide_host_free(host);
>  err:
> -       release_mem_region(ATA_HD_BASE, 0x40);
> +       release_mem_region(res->start, resource_size(res));
>         return rc;
>  }
>
> -module_init(falconide_init);
> +static struct platform_driver ide_falcon_driver = {
> +       .driver   = {
> +               .name   = "atari-falcon-ide",
> +       },
> +};

Missing .remove() callback.

> +
> +module_platform_driver_probe(ide_falcon_driver, falconide_init);
> +
>
> +MODULE_AUTHOR("Geert Uytterhoeven");
> +MODULE_DESCRIPTION("low-level driver for Atari Falcon IDE");
>  MODULE_LICENSE("GPL");
> +MODULE_ALIAS("platform:atari-falcon-ide");
> +MODULE_VERSION(DRV_VERSION);

I'd drop the MODULE_VERSION().

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
