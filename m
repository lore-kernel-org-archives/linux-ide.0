Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B0A6C47082
	for <linux-ide@archiver.kernel.org>; Mon,  7 Jun 2021 12:56:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B10360240
	for <linux-ide@archiver.kernel.org>; Mon,  7 Jun 2021 12:56:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbhFGM61 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 7 Jun 2021 08:58:27 -0400
Received: from mail-vs1-f48.google.com ([209.85.217.48]:41574 "EHLO
        mail-vs1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230145AbhFGM60 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 7 Jun 2021 08:58:26 -0400
Received: by mail-vs1-f48.google.com with SMTP id c1so2408955vsh.8;
        Mon, 07 Jun 2021 05:56:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NKFYA0rVo8pDDw3kqdWXLZF1QMNcT83wO8lP+2uYg3I=;
        b=bVfh8Z8qT1kaBB4btl4fbQ4NBGvgk6WsSJo7GnWHOuJ2iQuTegfkIe4ecr49M+xqis
         H4w6l8N65QXE4M1AWyUzDc0QvwDeikt5rYGWxOBqcBrAB3Rmqm1pk8B09WdNif9gTgGw
         xZpsyHHdY3/ueM9dOzdoSuNYPt1imt129x5tZZBZl/A8WhRend8sFkW9kTBt6j4KgPOH
         an/WMoXbKJjmwkdWjfiP845xSidA/LHljY2SDdkgTlIk6ZLQ66S77967ym2W1tzUa7U7
         bGVTg6M9ZF/F8OLE3cNuG4S+mw7tIGBk1hESdCNV0cHx+7hTPAXP0oMSpMghupABAA2R
         C48A==
X-Gm-Message-State: AOAM533yF1tpJOEFAQxLaEjxG9/GBIk5gJ4tCsNleMd86dMYbj4QIkrP
        8XWz4yEXE2+XDYtBcGEKK4NpRDXAy0wmKLcqakM=
X-Google-Smtp-Source: ABdhPJzUtDvgpW/g1ADKtzeLLT+XbV3CaoKPpoIwtbMz1ogDAj4PP0yO79AYml3nrvytqf4H1IMt+p9MLBJdpHlXmXo=
X-Received: by 2002:a05:6102:2011:: with SMTP id p17mr8293272vsr.40.1623070584665;
 Mon, 07 Jun 2021 05:56:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210605060447.GA18461@allandria.com> <1622958877-2026-1-git-send-email-schmitzmic@gmail.com>
 <1622958877-2026-3-git-send-email-schmitzmic@gmail.com>
In-Reply-To: <1622958877-2026-3-git-send-email-schmitzmic@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 7 Jun 2021 14:56:13 +0200
Message-ID: <CAMuHMdXOnAwrdjnqwWeMGBv8Y+eKk1SQSs+tHnFL9Q89W3gGhQ@mail.gmail.com>
Subject: Re: [PATCH RFC 2/2] net/8390: apne.c - add 100 Mbit support to apne.c driver
To:     Michael Schmitz <schmitzmic@gmail.com>
Cc:     "Linux/m68k" <linux-m68k@vger.kernel.org>,
        linux-ide@vger.kernel.org, Finn Thain <fthain@linux-m68k.org>,
        ALeX Kazik <alex@kazik.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Hi Michael,

On Sun, Jun 6, 2021 at 7:54 AM Michael Schmitz <schmitzmic@gmail.com> wrote:
> Add Kconfig option, module parameter and PCMCIA reset code
> required to support 100 Mbit PCMCIA ethernet cards on Amiga.
>
> 10 Mbit and 100 Mbit mode are supported by the same module.
> A module parameter switches Amiga ISA IO accessors to word
> access by changing isa_type at runtime. Additional code to
> reset the PCMCIA hardware is also added to the driver probe.
>
> Patch modified after patch "[PATCH RFC net-next] Amiga PCMCIA
> 100 MBit card support" submitted to netdev 2018/09/16 by Alex
> Kazik <alex@kazik.de>.
>
> Signed-off-by: Michael Schmitz <schmitzmic@gmail.com>

> --- a/drivers/net/ethernet/8390/apne.c
> +++ b/drivers/net/ethernet/8390/apne.c
> @@ -120,6 +120,10 @@ static u32 apne_msg_enable;
>  module_param_named(msg_enable, apne_msg_enable, uint, 0444);
>  MODULE_PARM_DESC(msg_enable, "Debug message level (see linux/netdevice.h for bitmap)");
>
> +static u32 apne_100_mbit;
> +module_param_named(apne_100_mbit, uint, 0);

error: macro "module_param_named" requires 4 arguments, but only 3 given

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
