Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEEDBC48BCD
	for <linux-ide@archiver.kernel.org>; Wed,  9 Jun 2021 06:36:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE82961181
	for <linux-ide@archiver.kernel.org>; Wed,  9 Jun 2021 06:36:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233352AbhFIGh5 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 9 Jun 2021 02:37:57 -0400
Received: from mail-vs1-f46.google.com ([209.85.217.46]:38806 "EHLO
        mail-vs1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230484AbhFIGh5 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 9 Jun 2021 02:37:57 -0400
Received: by mail-vs1-f46.google.com with SMTP id x8so12294622vso.5;
        Tue, 08 Jun 2021 23:35:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vxukHC4Wgy7zmN1ZcFXu/gA0XKDegK4j3Ypbo+XEbdw=;
        b=Hf5p+zbmUzYnZTQpzE2MrpE6bOHLoBXCNlRDcT0sInKPaAbM2aOrf8t+LnjNOdR19Q
         xkPH2CS7a7/2sW3AzNqLbgt8vvQPgtVkw6kW8KVnrYQtQfU9aEZDas0psVGXk14SXmtO
         RsSAGUiFk5wPQsygDtmvxW5XrTB5QYb9gPingSAmVcNVotrXnZ2GoNjOUDRdihrbU3F9
         VlwKL9OV5aBfE8yvtmYOpndOpHobOckTno2bavuOczYfp/c+5AO6cgGiOH8IGl+L5/bI
         2PrBr2bQSfM0gcuZb021Frv9CqS7eJ04bpyXU/LpsRnbQj5V9kUmgVFQhWQBzu3Up9a1
         8Gtg==
X-Gm-Message-State: AOAM5302q0QEdMxM6hkho4xTJjZhEhB5fOaXRc97HU8CaFL9gcv2IZhU
        MaYxO2L/QMn9VEpQR00IBd7sCiQtoJ//m3l8uww=
X-Google-Smtp-Source: ABdhPJwpG9NdoNXHVnRzXIS3OUqBLq51GIEIhGrAbDU3vuptBx8Q4MI8g15SnysXI2KtwuOmAv7hxeGRhapFG7HVbwk=
X-Received: by 2002:a05:6102:c4c:: with SMTP id y12mr3807535vss.18.1623220549935;
 Tue, 08 Jun 2021 23:35:49 -0700 (PDT)
MIME-Version: 1.0
References: <CAMuHMdUskb3oicq8Kbf6MY_4mn4-Y1pJ-om4fny7k48gndscgg@mail.gmail.com>
 <1622611267-15825-1-git-send-email-schmitzmic@gmail.com> <1622611267-15825-2-git-send-email-schmitzmic@gmail.com>
In-Reply-To: <1622611267-15825-2-git-send-email-schmitzmic@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 9 Jun 2021 08:35:38 +0200
Message-ID: <CAMuHMdWD-iECGSE5N+hUK-EdCTzMvhhgjRifih6sdx-NbOem1g@mail.gmail.com>
Subject: Re: [PATCH RFC 1/2] m68k: io_mm.h: conditionalize ISA address
 translation on Atari
To:     Michael Schmitz <schmitzmic@gmail.com>
Cc:     "Linux/m68k" <linux-m68k@vger.kernel.org>,
        linux-ide@vger.kernel.org, Finn Thain <fthain@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Hi Michael,

On Wed, Jun 2, 2021 at 7:21 AM Michael Schmitz <schmitzmic@gmail.com> wrote:
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
>
> Signed-off-by: Michael Schmity <schmitzmic@gmail.com>

> --- a/arch/m68k/include/asm/io_mm.h
> +++ b/arch/m68k/include/asm/io_mm.h
> @@ -52,7 +52,11 @@
>  #define Q40_ISA_MEM_B(madr)  (q40_isa_mem_base+1+4*((unsigned long)(madr)))
>  #define Q40_ISA_MEM_W(madr)  (q40_isa_mem_base+  4*((unsigned long)(madr)))
>
> +#ifdef CONFIG_ATARI
> +#define MULTI_ISA 1
> +#else
>  #define MULTI_ISA 0
> +#endif /* Atari */
>  #endif /* Q40 */
>
>  #ifdef CONFIG_AMIGA_PCMCIA
> @@ -135,9 +139,12 @@ static inline u8 __iomem *isa_itb(unsigned long addr)
>      case ISA_TYPE_AG: return (u8 __iomem *)AG_ISA_IO_B(addr);
>  #endif
>  #ifdef CONFIG_ATARI_ROM_ISA
> -    case ISA_TYPE_ENEC: return (u8 __iomem *)ENEC_ISA_IO_B(addr);
> +    case ISA_TYPE_ENEC: if (addr < 1024)
> +                               return (u8 __iomem *)ENEC_ISA_IO_B(addr);
> +                       else
> +                               return (u8 __iomem *)(addr);

While putting a simple return on the same line as the case keyword,
please start the if statement on a new line.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
