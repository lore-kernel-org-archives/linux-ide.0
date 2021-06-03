Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15F2AC47082
	for <linux-ide@archiver.kernel.org>; Thu,  3 Jun 2021 08:23:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF55A613DE
	for <linux-ide@archiver.kernel.org>; Thu,  3 Jun 2021 08:23:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbhFCIYv (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 3 Jun 2021 04:24:51 -0400
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:50956 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbhFCIYv (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 3 Jun 2021 04:24:51 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by kvm5.telegraphics.com.au (Postfix) with ESMTP id C3CED299E7;
        Thu,  3 Jun 2021 04:23:04 -0400 (EDT)
Date:   Thu, 3 Jun 2021 18:23:15 +1000 (AEST)
From:   Finn Thain <fthain@linux-m68k.org>
To:     Michael Schmitz <schmitzmic@gmail.com>
cc:     linux-m68k@vger.kernel.org, geert@linux-m68k.org,
        linux-ide@vger.kernel.org
Subject: Re: [PATCH RFC 1/2] m68k: io_mm.h: conditionalize ISA address
 translation on Atari
In-Reply-To: <1622611267-15825-2-git-send-email-schmitzmic@gmail.com>
Message-ID: <25ab336d-e0e0-41a8-d468-ecbf8d83d2b@linux-m68k.org>
References: <CAMuHMdUskb3oicq8Kbf6MY_4mn4-Y1pJ-om4fny7k48gndscgg@mail.gmail.com> <1622611267-15825-1-git-send-email-schmitzmic@gmail.com> <1622611267-15825-2-git-send-email-schmitzmic@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On Wed, 2 Jun 2021, Michael Schmitz wrote:

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

Thanks, this does fix the problem I had with CONFIG_ATARI && CONFIG_ISA.

> Signed-off-by: Michael Schmity <schmitzmic@gmail.com>

Checkpatch points out a typo here.

Also, I think this should get a 'Fixes' tag so it will be backported.

> ---
>  arch/m68k/include/asm/io_mm.h | 64 +++++++++++++++++++++++++++----------------
>  1 file changed, 40 insertions(+), 24 deletions(-)
> 
> diff --git a/arch/m68k/include/asm/io_mm.h b/arch/m68k/include/asm/io_mm.h
> index d41fa48..2275e54 100644
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

I have to wonder whether there is a nice simple definition for MULTI_ISA. 
Such a definition would make this file a lot more easily understood. Maybe 
that flag could be implemented as a Kconfig symbol. I guess that's out of 
scope though.

>  #ifdef CONFIG_AMIGA_PCMCIA
> @@ -135,9 +139,12 @@ static inline u8 __iomem *isa_itb(unsigned long addr)
>      case ISA_TYPE_AG: return (u8 __iomem *)AG_ISA_IO_B(addr);
>  #endif
>  #ifdef CONFIG_ATARI_ROM_ISA
> -    case ISA_TYPE_ENEC: return (u8 __iomem *)ENEC_ISA_IO_B(addr);
> +    case ISA_TYPE_ENEC: if (addr < 1024) 
> +				return (u8 __iomem *)ENEC_ISA_IO_B(addr);
> +			else
> +				return (u8 __iomem *)(addr);

There is some trailing whitespace added here that 'git am' complains 
about.

Also, I think a 'fallthrough' statement would be better than adding a new 
else branch that duplicates the new default case below.

>  #endif
> -    default: return NULL; /* avoid warnings, just in case */
> +    default: return (u8 __iomem *)(addr); /* avoid warnings, just in case */
>      }
>  }
>  static inline u16 __iomem *isa_itw(unsigned long addr)
> @@ -151,9 +158,12 @@ static inline u16 __iomem *isa_itw(unsigned long addr)
>      case ISA_TYPE_AG: return (u16 __iomem *)AG_ISA_IO_W(addr);
>  #endif
>  #ifdef CONFIG_ATARI_ROM_ISA
> -    case ISA_TYPE_ENEC: return (u16 __iomem *)ENEC_ISA_IO_W(addr);
> +    case ISA_TYPE_ENEC: if (addr < 1024)
> +				return (u16 __iomem *)ENEC_ISA_IO_W(addr);
> +			else
> +				return (u16 __iomem *)(addr);
>  #endif
> -    default: return NULL; /* avoid warnings, just in case */
> +    default: return (u16 __iomem *)(addr); /* avoid warnings, just in case */

Same here.

>      }
>  }
>  static inline u32 __iomem *isa_itl(unsigned long addr)
> @@ -177,9 +187,12 @@ static inline u8 __iomem *isa_mtb(unsigned long addr)
>      case ISA_TYPE_AG: return (u8 __iomem *)addr;
>  #endif
>  #ifdef CONFIG_ATARI_ROM_ISA
> -    case ISA_TYPE_ENEC: return (u8 __iomem *)ENEC_ISA_MEM_B(addr);
> +    case ISA_TYPE_ENEC: if (addr < 1024)
> +				return (u8 __iomem *)ENEC_ISA_MEM_B(addr);
> +			else
> +				return (u8 __iomem *)(addr);
>  #endif
> -    default: return NULL; /* avoid warnings, just in case */
> +    default: return (u8 __iomem *)(addr); /* avoid warnings, just in case */

And here.

>      }
>  }
>  static inline u16 __iomem *isa_mtw(unsigned long addr)
> @@ -193,9 +206,12 @@ static inline u16 __iomem *isa_mtw(unsigned long addr)
>      case ISA_TYPE_AG: return (u16 __iomem *)addr;
>  #endif
>  #ifdef CONFIG_ATARI_ROM_ISA
> -    case ISA_TYPE_ENEC: return (u16 __iomem *)ENEC_ISA_MEM_W(addr);
> +    case ISA_TYPE_ENEC: if (addr < 1024)
> +				return (u16 __iomem *)ENEC_ISA_MEM_W(addr);
> +			else
> +				return (u16 __iomem *)(addr);
>  #endif
> -    default: return NULL; /* avoid warnings, just in case */
> +    default: return (u16 __iomem *)(addr); /* avoid warnings, just in case */

And here.

>      }
>  }
>  
> @@ -344,31 +360,31 @@ static inline void isa_delay(void)
>   * ROM port ISA and everything else regular ISA for IDE. read,write defined
>   * below.
>   */
> -#define inb(port)	((port) < 1024 ? isa_rom_inb(port) : in_8(port))
> -#define inb_p(port)	((port) < 1024 ? isa_rom_inb_p(port) : in_8(port))
> -#define inw(port)	((port) < 1024 ? isa_rom_inw(port) : in_le16(port))
> -#define inw_p(port)	((port) < 1024 ? isa_rom_inw_p(port) : in_le16(port))
> +#define inb(port)	(((port) < 1024 && ISA_TYPE == ISA_TYPE_ENEC) ? isa_rom_inb(port) : isa_inb(port))
> +#define inb_p(port)	(((port) < 1024 && ISA_TYPE == ISA_TYPE_ENEC) ? isa_rom_inb_p(port) : isa_inb_p(port))
> +#define inw(port)	(((port) < 1024 && ISA_TYPE == ISA_TYPE_ENEC) ? isa_rom_inw(port) : isa_inw(port))
> +#define inw_p(port)	(((port) < 1024 && ISA_TYPE == ISA_TYPE_ENEC) ? isa_rom_inw_p(port) : isa_inw_p(port))
>  #define inl		isa_inl
>  #define inl_p		isa_inl_p
>  
> -#define outb(val, port)	((port) < 1024 ? isa_rom_outb((val), (port)) : out_8((port), (val)))
> -#define outb_p(val, port) ((port) < 1024 ? isa_rom_outb_p((val), (port)) : out_8((port), (val)))
> -#define outw(val, port)	((port) < 1024 ? isa_rom_outw((val), (port)) : out_le16((port), (val)))
> -#define outw_p(val, port) ((port) < 1024 ? isa_rom_outw_p((val), (port)) : out_le16((port), (val)))
> +#define outb(val, port)	(((port) < 1024 && ISA_TYPE == ISA_TYPE_ENEC) ? isa_rom_outb((val), (port)) : isa_outb((val), (port)))
> +#define outb_p(val, port) (((port) < 1024 && ISA_TYPE == ISA_TYPE_ENEC) ? isa_rom_outb_p((val), (port)) : isa_outb_p((val), (port)))
> +#define outw(val, port)	(((port) < 1024 && ISA_TYPE == ISA_TYPE_ENEC) ? isa_rom_outw((val), (port)) : isa_outw((val), (port)))
> +#define outw_p(val, port) (((port) < 1024 && ISA_TYPE == ISA_TYPE_ENEC) ? isa_rom_outw_p((val), (port)) : isa_outw_p((val), (port)))
>  #define outl		isa_outl
>  #define outl_p		isa_outl_p
>  
> -#define insb(port, buf, nr)	((port) < 1024 ? isa_rom_insb((port), (buf), (nr)) : isa_insb((port), (buf), (nr)))
> -#define insw(port, buf, nr)	((port) < 1024 ? isa_rom_insw((port), (buf), (nr)) : isa_insw((port), (buf), (nr)))
> +#define insb(port, buf, nr)	(((port) < 1024 && ISA_TYPE == ISA_TYPE_ENEC) ? isa_rom_insb((port), (buf), (nr)) : isa_insb((port), (buf), (nr)))
> +#define insw(port, buf, nr)	(((port) < 1024 && ISA_TYPE == ISA_TYPE_ENEC) ? isa_rom_insw((port), (buf), (nr)) : isa_insw((port), (buf), (nr)))
>  #define insl			isa_insl
> -#define outsb(port, buf, nr)	((port) < 1024 ? isa_rom_outsb((port), (buf), (nr)) : isa_outsb((port), (buf), (nr)))
> -#define outsw(port, buf, nr)	((port) < 1024 ? isa_rom_outsw((port), (buf), (nr)) : isa_outsw((port), (buf), (nr)))
> +#define outsb(port, buf, nr)	(((port) < 1024 && ISA_TYPE == ISA_TYPE_ENEC) ? isa_rom_outsb((port), (buf), (nr)) : isa_outsb((port), (buf), (nr)))
> +#define outsw(port, buf, nr)	(((port) < 1024 && ISA_TYPE == ISA_TYPE_ENEC) ? isa_rom_outsw((port), (buf), (nr)) : isa_outsw((port), (buf), (nr)))
>  #define outsl			isa_outsl
>  
> -#define readb(addr)		in_8(addr)
> -#define writeb(val, addr)	out_8((addr), (val))
> -#define readw(addr)		in_le16(addr)
> -#define writew(val, addr)	out_le16((addr), (val))
> +#define readb   isa_readb
> +#define readw   isa_readw
> +#define writeb  isa_writeb
> +#define writew  isa_writew
>  #endif /* CONFIG_ATARI_ROM_ISA */
>  
>  #define readl(addr)      in_le32(addr)
> 

