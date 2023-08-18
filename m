Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4796CC71157
	for <linux-ide@archiver.kernel.org>; Fri, 18 Aug 2023 14:41:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351383AbjHROko convert rfc822-to-8bit (ORCPT
        <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 18 Aug 2023 10:40:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353226AbjHROkJ (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 18 Aug 2023 10:40:09 -0400
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4321F3C3E;
        Fri, 18 Aug 2023 07:40:06 -0700 (PDT)
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-58c68c79befso9774817b3.3;
        Fri, 18 Aug 2023 07:40:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692369605; x=1692974405;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FEySILuurcW0mSlx9HezwlZiI7Dse5LiXfZpBGjZGgw=;
        b=CdBPTS3Xedfg+Q84xtNKhw+jgRk8HDPtQNc+TJWXB9La/XodBrc0Nf5f3dfVp8QMOr
         oBRRhj84XotnWQPTDo6FvQp6SRCQIYFyUM+KF5EoIlCeX6kWq9pUN7EcJFGDwRTDFZHm
         3vsIgrZOGoQ8MTeYca4O1GPdHJJaf6dsd/D9ExF+J5ppcQtBraYSCTksLm8XxpiJnsIu
         bucvGJ/wGuB3DUBqxjcZDFm/y9JCZoSZc+zK54dl/dXmCFQkxIt0FByX+fxR4yuM35/B
         Gmpbq9/RlwW+mBeNMXtT1WtL3GdVk1vpF/yLpPoQjw3aAKhnuNOwP1kFt8LEQysHtpVL
         HIAg==
X-Gm-Message-State: AOJu0YwKAG47TpYf0SCTC6+FMXXbNfi1QoRI1MuKIB0VXcKUfSdvPKQ/
        /nOFKmo55tcuwRHz2QMKeiskvR+Owogesz55
X-Google-Smtp-Source: AGHT+IEfa4j3sUzayI6ZIn2kfxntbQ+V+kaVTJAjVA05uzYGgMEMWDmKSQT5GZiicsThhk1UWdP2Zw==
X-Received: by 2002:a81:6cd7:0:b0:589:69d4:f117 with SMTP id h206-20020a816cd7000000b0058969d4f117mr2531030ywc.41.1692369605303;
        Fri, 18 Aug 2023 07:40:05 -0700 (PDT)
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com. [209.85.219.181])
        by smtp.gmail.com with ESMTPSA id t189-20020a0deac6000000b00583e52232f1sm525869ywe.112.2023.08.18.07.40.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Aug 2023 07:40:04 -0700 (PDT)
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-d63c0a6568fso977447276.0;
        Fri, 18 Aug 2023 07:40:04 -0700 (PDT)
X-Received: by 2002:a25:8703:0:b0:d74:3b38:ff4f with SMTP id
 a3-20020a258703000000b00d743b38ff4fmr2020822ybl.46.1692369604317; Fri, 18 Aug
 2023 07:40:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230818071405.28581-1-schmitzmic@gmail.com> <20230818071405.28581-3-schmitzmic@gmail.com>
 <16f01be8-de2e-4fb2-50c3-95f030e740ac@linux-m68k.org>
In-Reply-To: <16f01be8-de2e-4fb2-50c3-95f030e740ac@linux-m68k.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 18 Aug 2023 16:39:53 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVVWwaeMTd397z-=D6Cfp31i0a=y_R1OQqUuBytAXKyFQ@mail.gmail.com>
Message-ID: <CAMuHMdVVWwaeMTd397z-=D6Cfp31i0a=y_R1OQqUuBytAXKyFQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] ata: pata_falcon: add data_swab option to
 byte-swap disk data
To:     Finn Thain <fthain@linux-m68k.org>
Cc:     Michael Schmitz <schmitzmic@gmail.com>, dlemoal@kernel.org,
        linux-ide@vger.kernel.org, linux-m68k@vger.kernel.org,
        will@sowerbutts.com, rz@linux-m68k.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Hi Finn,

On Fri, Aug 18, 2023 at 9:43 AM Finn Thain <fthain@linux-m68k.org> wrote:
> On Fri, 18 Aug 2023, Michael Schmitz wrote:
> > Some users of pata_falcon on Q40 have IDE disks in default
> > IDE little endian byte order, whereas legacy disks use
> > host-native big-endian byte order as on the Atari Falcon.
> >
> > Add module parameter 'data_swab' to allow connecting drives
> > with non-native data byte order. Drives selected by the
> > data_swap bit mask will have their user data byte-swapped to
> > host byte order, i.e. 'pata_falcon.data_swab=2' will byte-swap
> > all user data on drive B, leaving data on drive A in native
> > byte order. On Q40, drives on a second IDE interface may be
> > added to the bit mask as bits 2 and 3.
> >
> > Default setting is no byte swapping, i.e. compatibility with
> > the native Falcon or Q40 operating system disk format.
> >
> > Cc: William R Sowerbutts <will@sowerbutts.com>
> > Cc: Finn Thain <fthain@linux-m68k.org>
> > Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> > Signed-off-by: Michael Schmitz <schmitzmic@gmail.com>

> > --- a/drivers/ata/pata_falcon.c
> > +++ b/drivers/ata/pata_falcon.c
> > @@ -199,6 +205,8 @@ static int __init pata_falcon_init_one(struct platform_device *pdev)
> >       ap->ioaddr.altstatus_addr       = ctl_base + io_offset;
> >       ap->ioaddr.ctl_addr             = ctl_base + io_offset;
> >
> > +     ap->private_data = (void *)(uintptr_t)(pata_falcon_swap_mask >> (2 * pdev->id));
> > +
>
> My compiler doesn't need that extra type cast in there...

Because it's a 32-bit compiler ;-)
With a 64-bit compiler, you would get

    warning: cast to pointer from integer of different size
[-Wint-to-pointer-cast]

Alternatively, you can change pata_falcon_swap_mask from int to long.

>
> >       irq_res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
> >       if (irq_res && irq_res->start > 0) {
> >               irq = irq_res->start;
> >


Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
