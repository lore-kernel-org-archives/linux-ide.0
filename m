Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0656C433F5
	for <linux-ide@archiver.kernel.org>; Wed, 24 Nov 2021 07:51:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240005AbhKXHyt (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 24 Nov 2021 02:54:49 -0500
Received: from mail-ua1-f43.google.com ([209.85.222.43]:41760 "EHLO
        mail-ua1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230121AbhKXHyq (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 24 Nov 2021 02:54:46 -0500
Received: by mail-ua1-f43.google.com with SMTP id p37so3238050uae.8;
        Tue, 23 Nov 2021 23:51:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1o7i2EeTnXlSwxgTkGX9jNcaWmEVbqja1xakXVbX7mI=;
        b=5qZNp2mPso0rAibR116MA4bpaEKELwjl4bFLrqe3XXrY/8K0EVS6VXp66HMeICA71L
         dr441Up9eculzwJSNZHrjVujwqdNUZDp+BiXZXuMtSmMfmAngOpmY/H3uSU6sSTOnSGA
         X4iv/VrF0IWvAS9m19m7AEm/ZRxaUMfQI9k42AETvDHwZ/mgw3hMGnhjrZB3dcRk6Rgn
         oYmarXxL3GfKsJFKYVH0VR3DpnNZBAMdZGPEXZ2GUrA/gfopez3PvZ2PuJbXR2zVTSue
         x8b+VV/1SL6VIK7J6Gc0ZGPcixX8YdLzeRIIqOqvvuYczFggX8o5G7uQlp/hwTU/toye
         WfJQ==
X-Gm-Message-State: AOAM532uGpZaV8Us+yM/Y+dBuBGWtWcO6mGtikEEq4eRXM5y36JGHlZT
        x6YK8vDT3Gp7i5Dn5Oiyi0U8IEDXgHF3fw==
X-Google-Smtp-Source: ABdhPJy6nE0CJlpnmHUr+59nczBzEac3wMxD7rmJuv+XU2NzDsmgMg2BQIaIE3igTC5CBjaGkWh6dg==
X-Received: by 2002:a9f:248b:: with SMTP id 11mr7136586uar.14.1637740296417;
        Tue, 23 Nov 2021 23:51:36 -0800 (PST)
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com. [209.85.222.49])
        by smtp.gmail.com with ESMTPSA id 17sm7730604uaq.10.2021.11.23.23.51.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Nov 2021 23:51:36 -0800 (PST)
Received: by mail-ua1-f49.google.com with SMTP id j14so3215026uan.10;
        Tue, 23 Nov 2021 23:51:35 -0800 (PST)
X-Received: by 2002:a67:af0a:: with SMTP id v10mr19242969vsl.35.1637740295605;
 Tue, 23 Nov 2021 23:51:35 -0800 (PST)
MIME-Version: 1.0
References: <44e0213a681f3c8ee4c6ab2ef9d61ce3ac00e368.1637727935.git.fthain@linux-m68k.org>
In-Reply-To: <44e0213a681f3c8ee4c6ab2ef9d61ce3ac00e368.1637727935.git.fthain@linux-m68k.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 24 Nov 2021 08:51:24 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXTxTABOoVgC6fVR44dxUZZEbZV=ewSk9vKFY=U5u+fcw@mail.gmail.com>
Message-ID: <CAMuHMdXTxTABOoVgC6fVR44dxUZZEbZV=ewSk9vKFY=U5u+fcw@mail.gmail.com>
Subject: Re: [PATCH] pata_falcon: Add missing __iomem annotations
To:     Finn Thain <fthain@linux-m68k.org>
Cc:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Michael Schmitz <schmitzmic@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Hi Finn,

On Wed, Nov 24, 2021 at 8:36 AM Finn Thain <fthain@linux-m68k.org> wrote:
> The zero day bot reported some sparse complaints in pata_falcon.c. E.g.
>
> drivers/ata/pata_falcon.c:58:41: warning: cast removes address space '__iomem' of expression
> drivers/ata/pata_falcon.c:58:41: warning: incorrect type in argument 1 (different address spaces)
> drivers/ata/pata_falcon.c:58:41:    expected unsigned short volatile [noderef] [usertype] __iomem *port
> drivers/ata/pata_falcon.c:58:41:    got unsigned short [usertype] *
>
> The same thing shows up in 8 places, all told. Avoid this by use of
> __iomem type casts.
>
> Cc: Michael Schmitz <schmitzmic@gmail.com>
> Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Cc: Jens Axboe <axboe@kernel.dk>
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Finn Thain <fthain@linux-m68k.org>

Thanks for your patch!

> --- a/drivers/ata/pata_falcon.c
> +++ b/drivers/ata/pata_falcon.c
> @@ -55,14 +55,14 @@ static unsigned int pata_falcon_data_xfer(struct ata_queued_cmd *qc,
>         /* Transfer multiple of 2 bytes */
>         if (rw == READ) {
>                 if (swap)
> -                       raw_insw_swapw((u16 *)data_addr, (u16 *)buf, words);
> +                       raw_insw_swapw((u16 __iomem *)data_addr, (u16 *)buf, words);
>                 else
> -                       raw_insw((u16 *)data_addr, (u16 *)buf, words);
> +                       raw_insw((u16 __iomem *)data_addr, (u16 *)buf, words);
>         } else {
>                 if (swap)
> -                       raw_outsw_swapw((u16 *)data_addr, (u16 *)buf, words);
> +                       raw_outsw_swapw((u16 __iomem *)data_addr, (u16 *)buf, words);
>                 else
> -                       raw_outsw((u16 *)data_addr, (u16 *)buf, words);
> +                       raw_outsw((u16 __iomem *)data_addr, (u16 *)buf, words);

Can't you just drop the casts? data_addr is an __iomem void *.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
