Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FCF0C71133
	for <linux-ide@archiver.kernel.org>; Fri, 25 Aug 2023 07:47:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235307AbjHYHqo convert rfc822-to-8bit (ORCPT
        <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 25 Aug 2023 03:46:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232871AbjHYHqR (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 25 Aug 2023 03:46:17 -0400
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A60B1FCA;
        Fri, 25 Aug 2023 00:46:15 -0700 (PDT)
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-58dfe2d5b9aso9768677b3.1;
        Fri, 25 Aug 2023 00:46:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692949574; x=1693554374;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hmuu7tjKFZL2mLy2Y+9/5DqiZXG4gabZ0aTQgtMWJjg=;
        b=SC/wgkFOluzIuyHcZvI0GTJn/IT28o4QRwqQIw+ILcomaTEaUUQ+gnlppXviliWDUL
         n+emuHrBXeGic23y4UOVYLFeEsIEaE6uXeIXnCv0S35Xxr8vw7acwor7evvvTcIth5w3
         7Rf+fmAftDY5384/6hWt59CsHyZ8j3NmLcTt1AlCv7lyxnzyLedq5+rN82CNlNL+8htT
         9K3v7bmKJHkV+I2qNAz/aYkiFH/UQxDFLb3TODGObcLKHr11KmugSqFc21gOxBcnh/Su
         ztMek0eFKkP5WcaXpgLAMldLow4Z58X6wrzwwqe8FXCXI4sP9hscreF4xQE2TD5l8LWU
         VoWg==
X-Gm-Message-State: AOJu0YyBeTXRcfz42WduPjBCo5ZAqchhqth6kl9ePAAKnV2MFQzZ8hIK
        wDtNt/4Pgzw9AfwrYnJduTzxfXGFOqQtRQ==
X-Google-Smtp-Source: AGHT+IHTBAIaBUottLmggBqPb5omOjnlmf/dvwEIEeYVKjIEsIS0jqKkFSH0p6cG7ZaD9X6Dww0hGw==
X-Received: by 2002:a0d:ca0b:0:b0:57a:3942:bb74 with SMTP id m11-20020a0dca0b000000b0057a3942bb74mr16612403ywd.17.1692949574319;
        Fri, 25 Aug 2023 00:46:14 -0700 (PDT)
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com. [209.85.219.169])
        by smtp.gmail.com with ESMTPSA id z4-20020a816504000000b00576c727498dsm376606ywb.92.2023.08.25.00.46.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Aug 2023 00:46:13 -0700 (PDT)
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-d74a012e613so978242276.1;
        Fri, 25 Aug 2023 00:46:13 -0700 (PDT)
X-Received: by 2002:a25:a28e:0:b0:d6b:1531:bc6c with SMTP id
 c14-20020a25a28e000000b00d6b1531bc6cmr16464181ybi.6.1692949573305; Fri, 25
 Aug 2023 00:46:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230825011335.25808-1-schmitzmic@gmail.com> <20230825011335.25808-3-schmitzmic@gmail.com>
In-Reply-To: <20230825011335.25808-3-schmitzmic@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 25 Aug 2023 09:46:02 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUhw-mvGXRRimfp1SAMaRzOfQuO=k81LaZbXuNPV0igQQ@mail.gmail.com>
Message-ID: <CAMuHMdUhw-mvGXRRimfp1SAMaRzOfQuO=k81LaZbXuNPV0igQQ@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] ata: pata_falcon: add data_swab option to
 byte-swap disk data
To:     Michael Schmitz <schmitzmic@gmail.com>
Cc:     s.shtylyov@omp.ru, dlemoal@kernel.org, linux-ide@vger.kernel.org,
        linux-m68k@vger.kernel.org, will@sowerbutts.com, rz@linux-m68k.org,
        Finn Thain <fthain@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Hi Michael,

On Fri, Aug 25, 2023 at 3:13 AM Michael Schmitz <schmitzmic@gmail.com> wrote:
> Some users of pata_falcon on Q40 have IDE disks in default
> IDE little endian byte order, whereas legacy disks use
> host-native big-endian byte order as on the Atari Falcon.
>
> Add module parameter 'data_swab' to allow connecting drives
> with non-native data byte order. Drives selected by the
> data_swap bit mask will have their user data byte-swapped to
> host byte order, i.e. 'pata_falcon.data_swab=2' will byte-swap
> all user data on drive B, leaving data on drive A in native
> byte order. On Q40, drives on a second IDE interface may be
> added to the bit mask as bits 2 and 3.
>
> Default setting is no byte swapping, i.e. compatibility with
> the native Falcon or Q40 operating system disk format.
>
> Cc: William R Sowerbutts <will@sowerbutts.com>
> Cc: Finn Thain <fthain@linux-m68k.org>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Tested-by: William R Sowerbutts <will@sowerbutts.com>
> Signed-off-by: Michael Schmitz <schmitzmic@gmail.com>
> Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
> Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
>
> ---
>
> Changes since v4:
>
> Damien Le Moal:
> - spell out bitmask shift calculation

Thanks for the update!

Sorry to bother you again...

> --- a/drivers/ata/pata_falcon.c
> +++ b/drivers/ata/pata_falcon.c

> @@ -124,7 +129,7 @@ static int __init pata_falcon_init_one(struct platform_device *pdev)
>         struct ata_host *host;
>         struct ata_port *ap;
>         void __iomem *base, *ctl_base;
> -       int irq = 0, io_offset = 1, reg_shift = 2; /* Falcon defaults */
> +       int irq = 0, io_offset = 1, reg_shift = 2, mask_shift; /* Falcon defaults */

The comment does not apply to the mask_shift variable, unless you
pre-initialize it to 0...

>
>         dev_info(&pdev->dev, "Atari Falcon and Q40/Q60 PATA controller\n");
>
> @@ -194,6 +199,12 @@ static int __init pata_falcon_init_one(struct platform_device *pdev)
>         ata_port_desc(ap, "cmd %px ctl %px data %px",
>                       base, ctl_base, ap->ioaddr.data_addr);
>
> +       if (pdev->id > 0)
> +               mask_shift = 2;
> +       else
> +               mask_shift = 0;

... and drop the else.

> +       ap->private_data = (void *)(uintptr_t)(pata_falcon_swap_mask >> mask_shift);
> +
>         irq_res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
>         if (irq_res && irq_res->start > 0) {
>                 irq = irq_res->start;

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
