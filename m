Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93994C4743C
	for <linux-ide@archiver.kernel.org>; Mon,  7 Jun 2021 07:50:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 792A160FE9
	for <linux-ide@archiver.kernel.org>; Mon,  7 Jun 2021 07:50:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229545AbhFGHwF (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 7 Jun 2021 03:52:05 -0400
Received: from mail-vs1-f48.google.com ([209.85.217.48]:43731 "EHLO
        mail-vs1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbhFGHwE (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 7 Jun 2021 03:52:04 -0400
Received: by mail-vs1-f48.google.com with SMTP id s22so8404594vsl.10;
        Mon, 07 Jun 2021 00:50:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1QMWibDQD2VEzLX93a/inP4iAQa+7zK93ajeKJClirc=;
        b=NwB4bjRUzEmbudXwMTUPtRloOQacweTuBE2GMidSsl52EWzR6UiYNFB4g03EGZANzw
         /jn+8Bu4f9E9kIqbJk+7ULRIS1cL3Y1pRBTivCrE13brpZYj8+h8X7KnYAVQH6HeF4qO
         bkqaacsH6tnQtfmWMoRR9nRcAs+/ByHhDYZwfJzQnmYhRbW0aHt8rCllDogKBDJvFHjf
         dViXlhdZlaCs9bvTEd4KJN+Ds6zks0y8yJluHZrBWAfW+V/a+zD4RotqkwanMbK6n4+4
         pXd52D49yAZIA8Ri7Zc1tkmWxegd824N8So1rCdV54hpFKx6T/CAxzPt2YpMIAGQbXaF
         RXYA==
X-Gm-Message-State: AOAM5312IsjvjvU4Lmmgn35PqWjkLndUfdc9gFv64/dm6XHNUTmq6aXO
        p8i5AWwJdWhTGmUp6G4yk8tZrEY2BgkU5A9XJvVbQkWFTyc=
X-Google-Smtp-Source: ABdhPJz5+qh36g8UyuxbNZGgXwoaCZd/ZhhKVz0EoZQ+Z9hd64UrfNpm5IXnNmy5bnqPH2U+m6XXbjx9YKd0UpGiiLY=
X-Received: by 2002:a05:6102:c4c:: with SMTP id y12mr3802651vss.18.1623052199912;
 Mon, 07 Jun 2021 00:49:59 -0700 (PDT)
MIME-Version: 1.0
References: <1622611267-15825-1-git-send-email-schmitzmic@gmail.com> <1622957313-321-1-git-send-email-schmitzmic@gmail.com>
In-Reply-To: <1622957313-321-1-git-send-email-schmitzmic@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 7 Jun 2021 09:49:48 +0200
Message-ID: <CAMuHMdWxYJ-ZvbTUhcnye=3ztCp7qTHpX0aqLWKtXk2NEZx+Vg@mail.gmail.com>
Subject: Re: [PATCH] m68k: Fix multiplatform ISA support
To:     Michael Schmitz <schmitzmic@gmail.com>
Cc:     "Linux/m68k" <linux-m68k@vger.kernel.org>,
        linux-ide@vger.kernel.org, Finn Thain <fthain@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Hi Michael,

On Sun, Jun 6, 2021 at 7:28 AM Michael Schmitz <schmitzmic@gmail.com> wrote:
> Current io_mm.h uses address translation and ROM port IO primitives when
> port addresses are below 1024, and raw untranslated MMIO IO primitives
> else when CONFIG_ATARI_ROM_ISA is set. This is done regardless of the
> m68k machine type a multi-platform kernel runs on. As a consequence,
> the Q40 IDE driver in multiplatform kernels cannot work.
> Conversely, the Atari IDE driver uses wrong address translation if a
> multiplatform Q40 and Atari kernel does _not_ set CONFIG_ATARI_ROM_ISA.
>
> Replace MMIO by ISA IO primitives for addresses > 1024 (if isa_type
> is ISA_TYPE_ENEC), and change the ISA address translation used for
> Atari to a no-op for those addresses.
>
> Switch readb()/writeb() and readw()/writew() to their ISA equivalents
> also. Change the address translation functions to return the identity
> translation if CONFIG_ATARI_ROM_ISA is not defined, and set MULTI_ISA
> for kernels where Q40 and Atari are both configured so this can actually
> work (isa_type set to Q40 at compile time else).

Thanks for your patch!

> Fixes:  84b16b7b0d5c818fadc731a69965dc76dce0c91e

Fixes: 84b16b7b0d5c818f ("m68k/atari: ROM port ISA adapter support")

Hint:

    $ git help fixes
    'fixes' is aliased to 'show --format='Fixes: %h ("%s")' -s'
    $ git fixes 84b16b7b0d5c818fadc731a69965dc76dce0c91e
    Fixes: 84b16b7b0d5c818f ("m68k/atari: ROM port ISA adapter support")

> Signed-off-by: Michael Schmitz <schmitzmic@gmail.com>

> --- a/arch/m68k/include/asm/io_mm.h
> +++ b/arch/m68k/include/asm/io_mm.h
> @@ -113,7 +117,7 @@
>
>  #ifdef MULTI_ISA
>  extern int isa_type;
> -extern int isa_sex;
> +extern int isa_sex;    /* Atari relies on this to be zero-initialized */

Shouldn't that comment be next to its definition in
arch/m68k/kernel/setup_mm.c?


> @@ -135,9 +139,11 @@ static inline u8 __iomem *isa_itb(unsigned long addr)
>      case ISA_TYPE_AG: return (u8 __iomem *)AG_ISA_IO_B(addr);
>  #endif
>  #ifdef CONFIG_ATARI_ROM_ISA
> -    case ISA_TYPE_ENEC: return (u8 __iomem *)ENEC_ISA_IO_B(addr);
> +    case ISA_TYPE_ENEC: if (addr < 1024)
> +                               return (u8 __iomem *)ENEC_ISA_IO_B(addr);
> +                       fallthrough; /* not ROM port? fallback below! */
>  #endif
> -    default: return NULL; /* avoid warnings, just in case */
> +    default: return (u8 __iomem *)(addr); /* avoid warnings, just in case */
>      }

Moving the default out of the switch() statement, as suggested by Finn,
would make this more future-proof, as any case (not just the last one)
can fall through to the default, using break.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
