Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84517C4743C
	for <linux-ide@archiver.kernel.org>; Mon,  7 Jun 2021 08:02:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69A82611BE
	for <linux-ide@archiver.kernel.org>; Mon,  7 Jun 2021 08:02:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230386AbhFGIED (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 7 Jun 2021 04:04:03 -0400
Received: from mail-ua1-f48.google.com ([209.85.222.48]:41733 "EHLO
        mail-ua1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230178AbhFGIEC (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 7 Jun 2021 04:04:02 -0400
Received: by mail-ua1-f48.google.com with SMTP id g34so9192743uah.8;
        Mon, 07 Jun 2021 01:01:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NEhUAL9KEN8OY7pYSd9TQz19k3WBrdBc3QmOvOxJ6KU=;
        b=XKDcronAllebcYjtR1/u+rDvh8QpGTf1t6y/vMi8oguA2KGT7Ah/1UoxVRSFxkiMxW
         p5DwyaZH05LWa5VFh0f2DZOMwCQoPOJcxnnf+l2kvj5qWrPMT+vYEqsiRZk+6BIDf22g
         6nVXS9jySD2qVOluCv9aDIGJO+/zTVJNVxR1xs8rgnZOw79SviFvlQQ/bcR4Qb9ewjFT
         Fb6HBlM71JbfruzqERZw/ZvQ2xkmw1mii9gvrgtD+KSypChiw8PPyX8wNi3O1YXfVL3z
         7WFBjHjkQM61HErd0avC45Vr7AxR6Xnm0yzo4bZv8VxzOJYjLQ02WyIYztnPSqHcd3/j
         H0pA==
X-Gm-Message-State: AOAM532gApuSm5arGvAyFbb7MyNAmn8ywpxD3G0fQP4enzt8rFFAHNLD
        zwv7uGlKG35V4RFgZza5ZyKAguLVusAqvKCD3hM=
X-Google-Smtp-Source: ABdhPJzfDf1O7wKnK6uPwWdIiecBs4GG6ZXcZmPqfKUJGCeYjSysvfdEu//lGfT43R7rqN4NMnR4cPaC1W+D1rBIjj0=
X-Received: by 2002:ab0:2a4e:: with SMTP id p14mr688119uar.2.1623052918420;
 Mon, 07 Jun 2021 01:01:58 -0700 (PDT)
MIME-Version: 1.0
References: <20210605060447.GA18461@allandria.com> <1622958877-2026-1-git-send-email-schmitzmic@gmail.com>
 <1622958877-2026-2-git-send-email-schmitzmic@gmail.com>
In-Reply-To: <1622958877-2026-2-git-send-email-schmitzmic@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 7 Jun 2021 10:01:47 +0200
Message-ID: <CAMuHMdUH1LJrrU2VKbtgYvvSVgKk-=1yOW9kWot3EKk=kADZcA@mail.gmail.com>
Subject: Re: [PATCH RFC 1/2] m68k: io_mm.h - add APNE 100 MBit support
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
> Add code to support 10 Mbit and 100 Mbit mode for APNE driver.
>
> A new ISA type ISA_TYPE_AG100 switches the Amiga ISA inb accessor
> to word access as required by the 100 Mbit cards.

missing "dynamically".

>
> Patch modified after patch "[PATCH RFC net-next] Amiga PCMCIA
> 100 MBit card support" submitted to netdev 2018/09/16 by Alex
> Kazik <alex@kazik.de>.
>
> Signed-off-by: Michael Schmitz <schmitzmic@gmail.com>

Thanks for your patch!

> --- a/arch/m68k/include/asm/io_mm.h
> +++ b/arch/m68k/include/asm/io_mm.h
> @@ -101,6 +101,11 @@
>  #define ISA_TYPE_Q40  (1)
>  #define ISA_TYPE_AG   (2)
>  #define ISA_TYPE_ENEC (3)
> +#define ISA_TYPE_AG100 (4)     /* for 100 MBit APNE card */

As this type may be needed for other cards, perhaps it should be
named after what it really does, i.e. always using 16-bit accesses?
ISA_TYPE_AG16?

> +
> +#if defined(CONFIG_APNE100MBIT)

#ifdef

> +#define MULTI_ISA 1
> +#endif
>
>  #if defined(CONFIG_Q40) && !defined(MULTI_ISA)
>  #define ISA_TYPE ISA_TYPE_Q40
> @@ -135,6 +140,9 @@ static inline u8 __iomem *isa_itb(unsigned long addr)
>  #ifdef CONFIG_Q40
>      case ISA_TYPE_Q40: return (u8 __iomem *)Q40_ISA_IO_B(addr);
>  #endif
> +#if defined(CONFIG_APNE100MBIT)

#ifdef

> +    case ISA_TYPE_AG100: fallthrough;

Fallthrough to what? Oh, to ISA_TYPE_AG.
Please make this clear, and safer, by moving this inside the #ifdef
below (CONFIG_APNE100MBIT depends on CONFIG_AMIGA_PCMCIA).

> +#endif
>  #ifdef CONFIG_AMIGA_PCMCIA
>      case ISA_TYPE_AG: return (u8 __iomem *)AG_ISA_IO_B(addr);
>  #endif

> @@ -212,13 +232,16 @@ static inline u16 __iomem *isa_mtw(unsigned long addr)
>  }
>
>
> -#define isa_inb(port)      in_8(isa_itb(port))

Why move it below? Because its comment does not apply to the below?

>  #define isa_inw(port)      (ISA_SEX ? in_be16(isa_itw(port)) : in_le16(isa_itw(port)))
>  #define isa_inl(port)      (ISA_SEX ? in_be32(isa_itl(port)) : in_le32(isa_itl(port)))
>  #define isa_outb(val,port) out_8(isa_itb(port),(val))
>  #define isa_outw(val,port) (ISA_SEX ? out_be16(isa_itw(port),(val)) : out_le16(isa_itw(port),(val)))
>  #define isa_outl(val,port) (ISA_SEX ? out_be32(isa_itl(port),(val)) : out_le32(isa_itl(port),(val)))
>
> +/* for APNE 100 Mbit cards - hope the APNE 100 case will be eliminated as
> + * dead code if MULTI_ISA is not set */

I don't think this comment is needed.

> +#define isa_inb(port)      ((ISA_TYPE == ISA_TYPE_AG100) ? ((port) & 1 ? isa_inw((port) - 1) & 0xff : isa_inw(port) >> 8) : in_8(isa_itb(port))
> +
>  #define isa_readb(p)       in_8(isa_mtb((unsigned long)(p)))
>  #define isa_readw(p)       \
>         (ISA_SEX ? in_be16(isa_mtw((unsigned long)(p))) \

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
