Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8220C47095
	for <linux-ide@archiver.kernel.org>; Wed,  9 Jun 2021 06:27:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BCF6661040
	for <linux-ide@archiver.kernel.org>; Wed,  9 Jun 2021 06:27:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231569AbhFIG3P (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 9 Jun 2021 02:29:15 -0400
Received: from mail-ua1-f46.google.com ([209.85.222.46]:41948 "EHLO
        mail-ua1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232540AbhFIG3O (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 9 Jun 2021 02:29:14 -0400
Received: by mail-ua1-f46.google.com with SMTP id g34so12483490uah.8;
        Tue, 08 Jun 2021 23:27:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4fj15iHDE4EFRmdRKw+InwfdANDxyy1h2Pcw1pJ7br4=;
        b=dhR7hrvEl626d/YKTal/evaxZoWoX6ItbhFB/BdrkKJY3hpgLyz6LO1/ze76iX0wgp
         oEv2jR57AG+bcXkiCxt0PVF/HrZ5f36fuZZa+aCN/cAXHPh2Cpa6CMIxAA5b755aPwKm
         Aior0Htc0ilOAtLVmyqCZtwnFBd8IlBZyFK81DY2WsIvb+IqD2xpsrPkbP4IVungfvQz
         hpNSYWRAWD5g68dIFGwpoIIP3NsAJPPPymA6BWqfve0wCRLRUuoZl/L1ivhPZCRVdBli
         j0R2sp213MwE3ZVF09j75fRzSNg1XEmYsO7NTfDUkfbKNBmTYu5xVCnP+QkuPtglnjA+
         pSkA==
X-Gm-Message-State: AOAM530HUOH1saFNYi88NeMgxaxSG9qiWNMnFzKPt8N+oyHNyUzfNyuL
        RZfSWUMET5T3lY/fQEW3zI97MxTXaPc/Kw15NMMf5S8G91HOQw==
X-Google-Smtp-Source: ABdhPJxOT1OQWZmJ0L718G4ODcg41DXYgKnREAhbxodoTZAVg+J1tMSfO4J0OJrSKInRNpUlS+s+kLY88BqtDrhoGjM=
X-Received: by 2002:ab0:63d9:: with SMTP id i25mr14918511uap.106.1623220030058;
 Tue, 08 Jun 2021 23:27:10 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1623131194.git.fthain@linux-m68k.org> <8ec3037e69f5ec9f7dbbafc642638f03eff29927.1623131194.git.fthain@linux-m68k.org>
In-Reply-To: <8ec3037e69f5ec9f7dbbafc642638f03eff29927.1623131194.git.fthain@linux-m68k.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 9 Jun 2021 08:26:58 +0200
Message-ID: <CAMuHMdUXtnzMOBxR_c+i1OomxwV3xC6k9PGLHkQueFaxudQd_w@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] m68k/mac: Replace macide driver with generic
 platform drivers
To:     Finn Thain <fthain@linux-m68k.org>
Cc:     Jens Axboe <axboe@kernel.dk>,
        "David S. Miller" <davem@davemloft.net>,
        Michael Schmitz <schmitzmic@gmail.com>,
        Joshua Thompson <funaho@jurai.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-ide@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On Tue, Jun 8, 2021 at 8:04 AM Finn Thain <fthain@linux-m68k.org> wrote:
> This allows m68k mac systems to switch from the deprecated IDE subsystem
> to libata.
>
> This was tested on my Quadra 630. I haven't tested it on my PowerBook 150
> because I don't have a RAM adapter board for it. It appears that the
> hardware I tested doesn't need macide_clear_irq() or macide_test_irq().
> If it did, the generic driver would not have worked. It's possible that
> those routines are needed for the PowerBook 150 but we can cross that
> bridge if and when we come to it.
>
> BTW, macide_clear_irq() appears to suffer from a race condition. The write
> to the interrupt flags register could have unintended side effects as it
> may alter other flag bits. Fortunately, all of the other bits are unused
> by Linux. When tested on my Quadra 630, the assignment *ide_ifr &= ~0x20
> was observed to have no effect on bit 5, so it may be redundant anyway.
>
> Cc: Michael Schmitz <schmitzmic@gmail.com>
> Cc: Joshua Thompson <funaho@jurai.org>
> Reviewed-by: Michael Schmitz <schmitzmic@gmail.com>
> Signed-off-by: Finn Thain <fthain@linux-m68k.org>

Thanks for your patch!

>  arch/m68k/configs/mac_defconfig   |   1 -
>  arch/m68k/configs/multi_defconfig |   1 -
>  arch/m68k/mac/config.c            |  24 +++--
>  drivers/ide/Kconfig               |  14 ---
>  drivers/ide/Makefile              |   1 -
>  drivers/ide/macide.c              | 161 ------------------------------
>  6 files changed, 14 insertions(+), 188 deletions(-)
>  delete mode 100644 drivers/ide/macide.c

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
