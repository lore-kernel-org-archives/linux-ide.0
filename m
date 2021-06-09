Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09933C47095
	for <linux-ide@archiver.kernel.org>; Wed,  9 Jun 2021 06:31:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E53CE610A1
	for <linux-ide@archiver.kernel.org>; Wed,  9 Jun 2021 06:31:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232798AbhFIGdB (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 9 Jun 2021 02:33:01 -0400
Received: from mail-vs1-f45.google.com ([209.85.217.45]:43787 "EHLO
        mail-vs1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231847AbhFIGdA (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 9 Jun 2021 02:33:00 -0400
Received: by mail-vs1-f45.google.com with SMTP id s22so12272992vsl.10;
        Tue, 08 Jun 2021 23:31:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AXXJVR5Kvh9DfRAdNlNbcwWy6ZK6zdovOov80Vu519Q=;
        b=GE+9YkMVeQjRyWZa5J5Esvoi+qnhKhxXky/ExZ46oneXyeRKipmQvJgd9d8Nyzf2oA
         v87eSl/t7uE5IH/RJVYDzn58vOgDVCBozDatQ5mk4y7p9b97ZQtyRbrQUtXZgU7/xcvD
         yLBevPV6whh71HVGIw3pbdXcqH1mejc0O9FSpXtBIiTGX8Lu1Qz1NGeB+sVFvBz0wjaH
         7Ksg0++Dkq/MGjrm0xyRYg82ND7DuHc9w6wBoF3QMBaxUecRrDiMFRFAVPTU9c07/kKm
         LoI29ymTpCu2zJ2CbSkOyEgZ+p/88iZbA94sfaDoN1eEyCUW655o5FZUZh5vm3Ixq4Jb
         rIqg==
X-Gm-Message-State: AOAM532hYsKSsmMs6D7PrIDPm7eix75tPop1uo4QP7Oxcv1buFi4EB8V
        5lx5YkPpp8JwbD2rJIffWiCd48pMBwRwg+gN6Vk=
X-Google-Smtp-Source: ABdhPJytskfX8RUZ+4NhknMctxOwBSUBELeh6tvFA09PULcHxmJwYO2ANDAZkYVxZDa/Or7kb9nCfGg8yyfm0oSnUI0=
X-Received: by 2002:a67:3c2:: with SMTP id 185mr3441670vsd.42.1623220266397;
 Tue, 08 Jun 2021 23:31:06 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1623131194.git.fthain@linux-m68k.org> <e781c54ae2c837c3c15b2505c5cde19b8b340a59.1623131194.git.fthain@linux-m68k.org>
In-Reply-To: <e781c54ae2c837c3c15b2505c5cde19b8b340a59.1623131194.git.fthain@linux-m68k.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 9 Jun 2021 08:30:55 +0200
Message-ID: <CAMuHMdVXPfV20TQgpczGVGELFQ4gcqhgX=K=Hb1k-7Ph6j4jZg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] m68k/q40: Replace q40ide driver with pata_falcon
 and falconide
To:     Finn Thain <fthain@linux-m68k.org>
Cc:     Jens Axboe <axboe@kernel.dk>,
        "David S. Miller" <davem@davemloft.net>,
        Michael Schmitz <schmitzmic@gmail.com>,
        Richard Zidlicky <rz@linux-m68k.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-ide@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On Tue, Jun 8, 2021 at 8:04 AM Finn Thain <fthain@linux-m68k.org> wrote:
> This allows m68k q40 systems to switch from the deprecated IDE subsystem
> to libata.
>
> Enhance the byte-swapping falconide and pata_falcon platform drivers to
> accept an irq resource, for use on q40. Atari ST-DMA IRQ arrangements seem
> to co-exist with q40 IRQ arrangements without too much mess.
>
> The new IO resources were added solely for the purpose of making
> request_region() reservations identical to those made by q40ide: these
> regions aren't used for actual IO.
>
> Cc: Michael Schmitz <schmitzmic@gmail.com>
> Cc: Richard Zidlicky <rz@linux-m68k.org>
> Reviewed-and-tested-by: Michael Schmitz <schmitzmic@gmail.com>
> Signed-off-by: Finn Thain <fthain@linux-m68k.org>

Thanks for your patch!

>  arch/m68k/atari/config.c          |  12 +--
>  arch/m68k/configs/multi_defconfig |   1 -
>  arch/m68k/configs/q40_defconfig   |   2 +-
>  arch/m68k/q40/config.c            |  37 +++++--
>  drivers/ata/Kconfig               |   6 +-
>  drivers/ata/pata_falcon.c         |  62 ++++++++---
>  drivers/ide/Kconfig               |  18 +---
>  drivers/ide/Makefile              |   1 -
>  drivers/ide/falconide.c           |  75 ++++++++-----
>  drivers/ide/q40ide.c              | 168 ------------------------------
>  10 files changed, 137 insertions(+), 245 deletions(-)
>  delete mode 100644 drivers/ide/q40ide.c

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
