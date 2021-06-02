Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38EFCC4708F
	for <linux-ide@archiver.kernel.org>; Wed,  2 Jun 2021 07:09:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1DB0F610CB
	for <linux-ide@archiver.kernel.org>; Wed,  2 Jun 2021 07:09:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230406AbhFBHLg (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 2 Jun 2021 03:11:36 -0400
Received: from mail-vs1-f52.google.com ([209.85.217.52]:41503 "EHLO
        mail-vs1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230351AbhFBHLf (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 2 Jun 2021 03:11:35 -0400
Received: by mail-vs1-f52.google.com with SMTP id u188so571468vsu.8;
        Wed, 02 Jun 2021 00:09:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aDfOZIPp/DQdDwllGfuuwcapXxfMCQWA9iGpJNEEkmA=;
        b=X9ZYtyLQBLc1HnOJdY9fSuoGeNTulUyGHyTO3MSjd5HSK41R5GuP1S1FGu6C4RCkJj
         ZlUMKsGUjmqqknFJ/9WZw7iIuVpKKqYlQD/dSv9bhNkDrPXXByGi9FxYlRsrW1pS7AY6
         TqZP+Z92b1b5dYb9nUArKWObln6soOAFd6ruN4FljFGjPzZU7diQOa2wQLABt0nx+NNc
         F+KQFzUFx4TJlXBMVDZrdzUQFt+qOR3OUdgxlDu3kFYEh+z32D33UHyyRVelc2H6kJ3m
         DE7hP+v2J8gn2BaucwUpzHnRT/+b9hsJ9fHXnu0LikVTM/FFSIVs00z+v0WOV/Q8mLXQ
         tCMQ==
X-Gm-Message-State: AOAM532H0PYxhqdEozBa9p7OTUmWFQ1d+/xsnWZGPTRqyx+FsnwsXLHt
        NofBxV/ChJbX/XE/UmJ9mA/EgtPKJRuRL1VksQA=
X-Google-Smtp-Source: ABdhPJx3DbjAXC/MQ44J+ZWm3E8MP7EeN8pJL3p9/I3BNgqO2/QPEz3o01bpqGUnS/9uVpudjdkDhSq7Fdr2oy/zVKg=
X-Received: by 2002:a05:6102:392:: with SMTP id m18mr22741551vsq.40.1622617791410;
 Wed, 02 Jun 2021 00:09:51 -0700 (PDT)
MIME-Version: 1.0
References: <CAMuHMdUskb3oicq8Kbf6MY_4mn4-Y1pJ-om4fny7k48gndscgg@mail.gmail.com>
 <1622611267-15825-1-git-send-email-schmitzmic@gmail.com> <1622611267-15825-3-git-send-email-schmitzmic@gmail.com>
In-Reply-To: <1622611267-15825-3-git-send-email-schmitzmic@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 2 Jun 2021 09:09:40 +0200
Message-ID: <CAMuHMdWhdSVCktaVZY+XHeyfeP8uw-RAcOWe--HsBn9Qf5_NOQ@mail.gmail.com>
Subject: Re: [PATCH RFC 2/2] m68k: setup_mm.c: set isa_sex for Atari if
 ATARI_ROM_ISA not used
To:     Michael Schmitz <schmitzmic@gmail.com>
Cc:     "Linux/m68k" <linux-m68k@vger.kernel.org>,
        linux-ide@vger.kernel.org, fthain@linux-m68k.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Hi Michael,

On Wed, Jun 2, 2021 at 7:21 AM Michael Schmitz <schmitzmic@gmail.com> wrote:
> For multiplatform kernels where CONFIG_ATARI_ROM_ISA is not set,
> at least isa_sex must be set correctly to allow for correct I/O
> primitive selection in shared drivers.
>
> Signed-off-by: Michael Schmitz <schmitzmic@gmail.com>

Thanks for your patch!


> --- a/arch/m68k/kernel/setup_mm.c
> +++ b/arch/m68k/kernel/setup_mm.c
> @@ -386,6 +386,10 @@ void __init setup_arch(char **cmdline_p)
>                 isa_type = ISA_TYPE_ENEC;
>                 isa_sex = 0;
>         }
> +#else
> +       if (MACH_IS_ATARI) {
> +               isa_sex = 0;

I find it strange that you set isa_sex, but not isa_type?
However, this is inside the CONFIG_ISA && MULTI_ISA block, so
what kind of ISA does this correspond to?

> +       }
>  #endif
>  #endif

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
