Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0963AC4743E
	for <linux-ide@archiver.kernel.org>; Sun,  6 Jun 2021 04:53:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7FC361380
	for <linux-ide@archiver.kernel.org>; Sun,  6 Jun 2021 04:53:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229508AbhFFEzH (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sun, 6 Jun 2021 00:55:07 -0400
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:35116 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbhFFEzG (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sun, 6 Jun 2021 00:55:06 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by kvm5.telegraphics.com.au (Postfix) with ESMTP id 149CA2A273;
        Sun,  6 Jun 2021 00:53:12 -0400 (EDT)
Date:   Sun, 6 Jun 2021 14:53:26 +1000 (AEST)
From:   Finn Thain <fthain@linux-m68k.org>
To:     Michael Schmitz <schmitzmic@gmail.com>
cc:     Brad Boyer <flar@allandria.com>, linux-m68k@vger.kernel.org,
        geert@linux-m68k.org, linux-ide@vger.kernel.org,
        ALeX Kazik <alex@kazik.de>
Subject: Re: [PATCH RFC 1/2] m68k: io_mm.h: conditionalize ISA address
 translation on Atari
In-Reply-To: <5bed9868-2cb6-6604-abb9-faa9361fa3e3@gmail.com>
Message-ID: <bfce51f-a393-7c3e-77f0-a99595a0d037@linux-m68k.org>
References: <CAMuHMdUskb3oicq8Kbf6MY_4mn4-Y1pJ-om4fny7k48gndscgg@mail.gmail.com> <1622611267-15825-1-git-send-email-schmitzmic@gmail.com> <1622611267-15825-2-git-send-email-schmitzmic@gmail.com> <25ab336d-e0e0-41a8-d468-ecbf8d83d2b@linux-m68k.org>
 <143313da-d294-f89b-d285-235230514c5a@gmail.com> <d7165fdd-9269-7bd2-185-c6193f864722@linux-m68k.org> <535b7829-f16f-4ddc-a676-dbb10c7a4a35@gmail.com> <20210604224955.GA12141@allandria.com> <eefa79e9-01d3-9179-9ca6-57500b9ab7c2@gmail.com>
 <20210605060447.GA18461@allandria.com> <5bed9868-2cb6-6604-abb9-faa9361fa3e3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On Sun, 6 Jun 2021, Michael Schmitz wrote:

> 
> This patch to io_mm.h (on top of my current patch), plus setting isa_type to
> ISA_TPYE_AG100 using a module parameter, should do the trick:
> 
> diff --git a/arch/m68k/include/asm/io_mm.h b/arch/m68k/include/asm/io_mm.h
> index f6b487b..6f79a5e 100644
> --- a/arch/m68k/include/asm/io_mm.h
> +++ b/arch/m68k/include/asm/io_mm.h
> @@ -102,6 +102,11 @@
>  #define ISA_TYPE_AG   (2)
>  #define ISA_TYPE_ENEC (3)
> 
> +#if defined(CONFIG_AMIGA_PCMCIA_100)
> +#define ISA_TYPE_AG100 (4)     /* for 100 MBit APNE card */

IMHO this would be simpler if that #define was unconditional like the 
others.

> +#define MULTI_ISA 1

Hmm...

> +#endif
> +
>  #if defined(CONFIG_Q40) && !defined(MULTI_ISA)
>  #define ISA_TYPE ISA_TYPE_Q40
>  #define ISA_SEX  0
> @@ -135,6 +140,9 @@ static inline u8 __iomem *isa_itb(unsigned long addr)
>  #ifdef CONFIG_Q40
>      case ISA_TYPE_Q40: return (u8 __iomem *)Q40_ISA_IO_B(addr);
>  #endif
> +#if defined(CONFIG_AMIGA_PCMCIA_100)
> +    case ISA_TYPE_AG100: fallthrough;
> +#endif

I wonder whether that 'fallthrough' is needed. One would hope not...

>  #ifdef CONFIG_AMIGA_PCMCIA
>      case ISA_TYPE_AG: return (u8 __iomem *)AG_ISA_IO_B(addr);
>  #endif
> @@ -153,6 +161,9 @@ static inline u16 __iomem *isa_itw(unsigned long addr)
>  #ifdef CONFIG_Q40
>      case ISA_TYPE_Q40: return (u16 __iomem *)Q40_ISA_IO_W(addr);
>  #endif
> +#if defined(CONFIG_AMIGA_PCMCIA_100)
> +    case ISA_TYPE_AG100: fallthrough;
> +#endif
>  #ifdef CONFIG_AMIGA_PCMCIA
>      case ISA_TYPE_AG: return (u16 __iomem *)AG_ISA_IO_W(addr);
>  #endif
> @@ -168,6 +179,9 @@ static inline u32 __iomem *isa_itl(unsigned long addr)
>  {
>    switch(ISA_TYPE)
>      {
> +#if defined(CONFIG_AMIGA_PCMCIA_100)
> +    case ISA_TYPE_AG100: fallthrough;
> +#endif
>  #ifdef CONFIG_AMIGA_PCMCIA
>      case ISA_TYPE_AG: return (u32 __iomem *)AG_ISA_IO_W(addr);
>  #endif
> @@ -181,6 +195,9 @@ static inline u8 __iomem *isa_mtb(unsigned long addr)
>  #ifdef CONFIG_Q40
>      case ISA_TYPE_Q40: return (u8 __iomem *)Q40_ISA_MEM_B(addr);
>  #endif
> +#if defined(CONFIG_AMIGA_PCMCIA_100)
> +    case ISA_TYPE_AG100: fallthrough;
> +#endif
>  #ifdef CONFIG_AMIGA_PCMCIA
>      case ISA_TYPE_AG: return (u8 __iomem *)addr;
>  #endif
> @@ -199,6 +216,9 @@ static inline u16 __iomem *isa_mtw(unsigned long addr)
>  #ifdef CONFIG_Q40
>      case ISA_TYPE_Q40: return (u16 __iomem *)Q40_ISA_MEM_W(addr);
>  #endif
> +#if defined(CONFIG_AMIGA_PCMCIA_100)
> +    case ISA_TYPE_AG100: fallthrough;
> +#endif
>  #ifdef CONFIG_AMIGA_PCMCIA
>      case ISA_TYPE_AG: return (u16 __iomem *)addr;
>  #endif
> @@ -219,6 +239,11 @@ static inline u16 __iomem *isa_mtw(unsigned long addr)
>  #define isa_outw(val,port) (ISA_SEX ? out_be16(isa_itw(port),(val)) :
> out_le16(isa_itw(port),(val)))
>  #define isa_outl(val,port) (ISA_SEX ? out_be32(isa_itl(port),(val)) :
> out_le32(isa_itl(port),(val)))
> 
> +#if defined(CONFIG_AMIGA_PCMCIA_100)
> +#undef isa_inb
> +#define isa_inb(port)      ((ISA_TYPE == ISA_TYPE_AG100) ? ((port) & 1 ?
> isa_inw((port) - 1) & 0xff : isa_inw(port) >> 8) : in_8(isa_itb(port))
> +#endif
> +

Would (port & ~1) be faster than (port - 1) here?

Also, I don't think you need '#if defined' here. When 
!defined(CONFIG_AMIGA_PCMCIA_100), I think ISA_TYPE should be a 
compile-time constant 0, and the dead code will get tossed out anyway.

>  #define isa_readb(p)       in_8(isa_mtb((unsigned long)(p)))
>  #define isa_readw(p)       \
>         (ISA_SEX ? in_be16(isa_mtw((unsigned long)(p))) \
> 
> (linebreak-mangled, sorry).
> 
> The card reset patch hunk from Alex' patch can probably go into the APNE
> driver regardless?
> 
> It's been quite a while - can you still try and build/test this change, Alex?

Note that isa_type is never assigned to ISA_TYPE_AG100 in 
arch/m68k/kernel/setup_mm.c which means (IIUC) this patch won't take 
effect with MULTI_ISA == 1.
