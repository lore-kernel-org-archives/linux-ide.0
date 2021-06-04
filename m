Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B348FC47097
	for <linux-ide@archiver.kernel.org>; Fri,  4 Jun 2021 00:19:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A7C16140A
	for <linux-ide@archiver.kernel.org>; Fri,  4 Jun 2021 00:19:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbhFDAVW (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 3 Jun 2021 20:21:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbhFDAVV (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 3 Jun 2021 20:21:21 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 292DDC06174A;
        Thu,  3 Jun 2021 17:19:20 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id v14so6434542pgi.6;
        Thu, 03 Jun 2021 17:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=vhTNJZ5hFmJN8pQNiIScImR+l1Uy4dWCQItlFqyJ2Ew=;
        b=jbq2YfssteQ4nlOX92DtjVSLog7aUHDXqegQcCHGiVyz5iJJoPTb6sFZhd5X6v4dXV
         XYQf1M1UybgKffR4vqo2TCKcdARLVgMbmFjkXLY78kt8qtBsLO6RHVKgZzXQkGihVeNn
         1f3LIa1/MLPjpKC1EAWbHqWLWDsfUuJtnXjXHZETSiGMdFNC9hC4kkqtPpDz20PVo0kW
         HemkQFKOTE9JfcssX+hKKfAB6G/aWWf+ChAP6VfjE5sVnwKkZ4RxZJVV4GEvW2oWuV+C
         DWxyh0tl4Kfe1PBB4QmtFjG5GIeBlGC2gPfzz8ycpfDxAMw08cR0cRBqTPJQlLzt9Qma
         rSyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=vhTNJZ5hFmJN8pQNiIScImR+l1Uy4dWCQItlFqyJ2Ew=;
        b=qYnBbD6GL8HX+OoIGzyi5g6ToegeYXHkzOybkdvRh/fQWv9uPUpulehWPlJfaoIVW7
         8C1DgngoH9aZYd5Vbos8wuA2Fl+a52nX0OgG1ACAi5sM7nSCNfwPYS+UW/UfWUxVem7y
         ll/h0irJ/Bf87BGOEp+MyZNCAbGQ7zrTCye/apQc4t9HzGqUgu56Su3hQ7nWTpYpUzEA
         j0o5vqGumO8xF/AZ9+kDGQ2BdwPqliMFTGaoWOKuCPPgFq/5FI03/1f5/0b4Sw86fNNs
         Tn+azOOIAxXhXs72foZI1pAkU76N+qSBTa/qpSyLw/QzwaYIO+KMJVyxrskeCn/8as3G
         ydGw==
X-Gm-Message-State: AOAM531FID//A7CcshUdhyWLVHhuwmPWwx0lOrRyGIi444oQsYJvc8rm
        BG6Rw1o8ENfsM5kvnK+3wJPQo7NEPLo=
X-Google-Smtp-Source: ABdhPJzNqqfSsIxSWV0riynaNw6UXyVY8GP+wGBa6caolBdsLDqp/x9iQPwtrqo2p+4LIgpsoA1BKQ==
X-Received: by 2002:a05:6a00:882:b029:2de:b01d:755a with SMTP id q2-20020a056a000882b02902deb01d755amr1944523pfj.43.1622765959163;
        Thu, 03 Jun 2021 17:19:19 -0700 (PDT)
Received: from ?IPv6:2001:df0:0:200c:a568:11f5:f38b:e899? ([2001:df0:0:200c:a568:11f5:f38b:e899])
        by smtp.gmail.com with ESMTPSA id w59sm3110358pjj.13.2021.06.03.17.19.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Jun 2021 17:19:18 -0700 (PDT)
Subject: Re: [PATCH RFC 1/2] m68k: io_mm.h: conditionalize ISA address
 translation on Atari
To:     Finn Thain <fthain@linux-m68k.org>
Cc:     linux-m68k@vger.kernel.org, geert@linux-m68k.org,
        linux-ide@vger.kernel.org
References: <CAMuHMdUskb3oicq8Kbf6MY_4mn4-Y1pJ-om4fny7k48gndscgg@mail.gmail.com>
 <1622611267-15825-1-git-send-email-schmitzmic@gmail.com>
 <1622611267-15825-2-git-send-email-schmitzmic@gmail.com>
 <25ab336d-e0e0-41a8-d468-ecbf8d83d2b@linux-m68k.org>
From:   Michael Schmitz <schmitzmic@gmail.com>
Message-ID: <143313da-d294-f89b-d285-235230514c5a@gmail.com>
Date:   Fri, 4 Jun 2021 12:19:13 +1200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <25ab336d-e0e0-41a8-d468-ecbf8d83d2b@linux-m68k.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Hi Finn,

thanks for your review!

On 3/06/21 8:23 pm, Finn Thain wrote:
> On Wed, 2 Jun 2021, Michael Schmitz wrote:
>
>> Current io_mm.h uses address translation and ROM port IO primitives when
>> port addresses are below 1024, and raw untranslated MMIO IO primitives
>> else when CONFIG_ATARI_ROM_ISA is set. This is done regardless of the
>> m68k machine type a multi-platform kernel runs on. As a consequence,
>> the Q40 IDE driver in multiplatform kernels cannot work.
>> Conversely, the Atari IDE driver uses wrong address translation if a
>> multiplatform Q40 and Atari kernel does _not_ set CONFIG_ATARI_ROM_ISA.
>>
>> Replace MMIO by ISA IO primitives for addresses > 1024 (if isa_type
>> is ISA_TYPE_ENEC), and change the ISA address translation used for
>> Atari to a no-op for those addresses.
>>
>> Switch readb()/writeb() and readw()/writew() to their ISA equivalents
>> also. Change the address translation functions to return the identity
>> translation if CONFIG_ATARI_ROM_ISA is not defined, and set MULTI_ISA
>> for kernels where Q40 and Atari are both configured so this can actually
>> work (isa_type set to Q40 at compile time else).
>>
> Thanks, this does fix the problem I had with CONFIG_ATARI && CONFIG_ISA.
>
>> Signed-off-by: Michael Schmity <schmitzmic@gmail.com>
> Checkpatch points out a typo here.
I noticed :-) Fat-fingered the commit in a hurry (and didn't run 
checkpatch).
>
> Also, I think this should get a 'Fixes' tag so it will be backported.
I wasn't sure what to use as commit ID to be fixed ... Looks like 
84b16b7b0d5c818fadc731a69965dc76dce0c91e is the one to blame. Hmm - I 
thought that code was older than that...
>
>> ---
>>   arch/m68k/include/asm/io_mm.h | 64 +++++++++++++++++++++++++++----------------
>>   1 file changed, 40 insertions(+), 24 deletions(-)
>>
>> diff --git a/arch/m68k/include/asm/io_mm.h b/arch/m68k/include/asm/io_mm.h
>> index d41fa48..2275e54 100644
>> --- a/arch/m68k/include/asm/io_mm.h
>> +++ b/arch/m68k/include/asm/io_mm.h
>> @@ -52,7 +52,11 @@
>>   #define Q40_ISA_MEM_B(madr)  (q40_isa_mem_base+1+4*((unsigned long)(madr)))
>>   #define Q40_ISA_MEM_W(madr)  (q40_isa_mem_base+  4*((unsigned long)(madr)))
>>   
>> +#ifdef CONFIG_ATARI
>> +#define MULTI_ISA 1
>> +#else
>>   #define MULTI_ISA 0
>> +#endif /* Atari */
>>   #endif /* Q40 */
>>   
> I have to wonder whether there is a nice simple definition for MULTI_ISA.

As I understand it, MULTI_ISA means that different byte orders and/or 
different address translations need to be used in the same kernel, so 
all that cannot be decided at build time.

As long as there is only a single platform that will use this code (ISA 
only used on a single platform, and neither Atari IDE nor EtherNEC 
used), MULTI_ISA is not needed.

If we have Kconfig symbols for 'single platform only', and 
'multi-platform ISA use', that might be shorter to write and easier to 
understand. Geert?

> Such a definition would make this file a lot more easily understood. Maybe
> that flag could be implemented as a Kconfig symbol. I guess that's out of
> scope though.

That Kconfig symbol would best sit in Kconfig.machine but have to be 
aware of definitions in a number of driver Kconfigs. Haven't tried if 
that works. But I agree it is out of scope for now.

The question then becomes - should I move the MULTI_ISA definitions out 
of the Q40 branch and out of the later Amiga Gayle PCMCIA branch to the 
head of the file and add a comment explaining the rationale? Too much 
churn for now?

>
>>   #ifdef CONFIG_AMIGA_PCMCIA
>> @@ -135,9 +139,12 @@ static inline u8 __iomem *isa_itb(unsigned long addr)
>>       case ISA_TYPE_AG: return (u8 __iomem *)AG_ISA_IO_B(addr);
>>   #endif
>>   #ifdef CONFIG_ATARI_ROM_ISA
>> -    case ISA_TYPE_ENEC: return (u8 __iomem *)ENEC_ISA_IO_B(addr);
>> +    case ISA_TYPE_ENEC: if (addr < 1024)
>> +				return (u8 __iomem *)ENEC_ISA_IO_B(addr);
>> +			else
>> +				return (u8 __iomem *)(addr);
> There is some trailing whitespace added here that 'git am' complains
> about.
>
> Also, I think a 'fallthrough' statement would be better than adding a new
> else branch that duplicates the new default case below.

I'm still unsure whether changing the default branch for the sake of 
fixing Atari behaviour is a sane idea - I was hoping for comments either 
way.

But if it's changed, you are correct that having the control flow fall 
through instead of taking a redundant else branch is better.

Essentially, changing that hunk to

  #ifdef CONFIG_ATARI_ROM_ISA
-    case ISA_TYPE_ENEC: return (u8 __iomem *)ENEC_ISA_IO_B(addr);
+    case ISA_TYPE_ENEC: if (addr < 1024)
+				return (u8 __iomem *)ENEC_ISA_IO_B(addr);

here (and elsewhere below)?

Cheers,

     Michael


>
>>   #endif
>> -    default: return NULL; /* avoid warnings, just in case */
>> +    default: return (u8 __iomem *)(addr); /* avoid warnings, just in case */
>>       }
>>   }
>>   static inline u16 __iomem *isa_itw(unsigned long addr)
>> @@ -151,9 +158,12 @@ static inline u16 __iomem *isa_itw(unsigned long addr)
>>       case ISA_TYPE_AG: return (u16 __iomem *)AG_ISA_IO_W(addr);
>>   #endif
>>   #ifdef CONFIG_ATARI_ROM_ISA
>> -    case ISA_TYPE_ENEC: return (u16 __iomem *)ENEC_ISA_IO_W(addr);
>> +    case ISA_TYPE_ENEC: if (addr < 1024)
>> +				return (u16 __iomem *)ENEC_ISA_IO_W(addr);
>> +			else
>> +				return (u16 __iomem *)(addr);
>>   #endif
>> -    default: return NULL; /* avoid warnings, just in case */
>> +    default: return (u16 __iomem *)(addr); /* avoid warnings, just in case */
> Same here.
>
>>       }
>>   }
>>   static inline u32 __iomem *isa_itl(unsigned long addr)
>> @@ -177,9 +187,12 @@ static inline u8 __iomem *isa_mtb(unsigned long addr)
>>       case ISA_TYPE_AG: return (u8 __iomem *)addr;
>>   #endif
>>   #ifdef CONFIG_ATARI_ROM_ISA
>> -    case ISA_TYPE_ENEC: return (u8 __iomem *)ENEC_ISA_MEM_B(addr);
>> +    case ISA_TYPE_ENEC: if (addr < 1024)
>> +				return (u8 __iomem *)ENEC_ISA_MEM_B(addr);
>> +			else
>> +				return (u8 __iomem *)(addr);
>>   #endif
>> -    default: return NULL; /* avoid warnings, just in case */
>> +    default: return (u8 __iomem *)(addr); /* avoid warnings, just in case */
> And here.
>
>>       }
>>   }
>>   static inline u16 __iomem *isa_mtw(unsigned long addr)
>> @@ -193,9 +206,12 @@ static inline u16 __iomem *isa_mtw(unsigned long addr)
>>       case ISA_TYPE_AG: return (u16 __iomem *)addr;
>>   #endif
>>   #ifdef CONFIG_ATARI_ROM_ISA
>> -    case ISA_TYPE_ENEC: return (u16 __iomem *)ENEC_ISA_MEM_W(addr);
>> +    case ISA_TYPE_ENEC: if (addr < 1024)
>> +				return (u16 __iomem *)ENEC_ISA_MEM_W(addr);
>> +			else
>> +				return (u16 __iomem *)(addr);
>>   #endif
>> -    default: return NULL; /* avoid warnings, just in case */
>> +    default: return (u16 __iomem *)(addr); /* avoid warnings, just in case */
> And here.
>
>>       }
>>   }
>>   
>> @@ -344,31 +360,31 @@ static inline void isa_delay(void)
>>    * ROM port ISA and everything else regular ISA for IDE. read,write defined
>>    * below.
>>    */
>> -#define inb(port)	((port) < 1024 ? isa_rom_inb(port) : in_8(port))
>> -#define inb_p(port)	((port) < 1024 ? isa_rom_inb_p(port) : in_8(port))
>> -#define inw(port)	((port) < 1024 ? isa_rom_inw(port) : in_le16(port))
>> -#define inw_p(port)	((port) < 1024 ? isa_rom_inw_p(port) : in_le16(port))
>> +#define inb(port)	(((port) < 1024 && ISA_TYPE == ISA_TYPE_ENEC) ? isa_rom_inb(port) : isa_inb(port))
>> +#define inb_p(port)	(((port) < 1024 && ISA_TYPE == ISA_TYPE_ENEC) ? isa_rom_inb_p(port) : isa_inb_p(port))
>> +#define inw(port)	(((port) < 1024 && ISA_TYPE == ISA_TYPE_ENEC) ? isa_rom_inw(port) : isa_inw(port))
>> +#define inw_p(port)	(((port) < 1024 && ISA_TYPE == ISA_TYPE_ENEC) ? isa_rom_inw_p(port) : isa_inw_p(port))
>>   #define inl		isa_inl
>>   #define inl_p		isa_inl_p
>>   
>> -#define outb(val, port)	((port) < 1024 ? isa_rom_outb((val), (port)) : out_8((port), (val)))
>> -#define outb_p(val, port) ((port) < 1024 ? isa_rom_outb_p((val), (port)) : out_8((port), (val)))
>> -#define outw(val, port)	((port) < 1024 ? isa_rom_outw((val), (port)) : out_le16((port), (val)))
>> -#define outw_p(val, port) ((port) < 1024 ? isa_rom_outw_p((val), (port)) : out_le16((port), (val)))
>> +#define outb(val, port)	(((port) < 1024 && ISA_TYPE == ISA_TYPE_ENEC) ? isa_rom_outb((val), (port)) : isa_outb((val), (port)))
>> +#define outb_p(val, port) (((port) < 1024 && ISA_TYPE == ISA_TYPE_ENEC) ? isa_rom_outb_p((val), (port)) : isa_outb_p((val), (port)))
>> +#define outw(val, port)	(((port) < 1024 && ISA_TYPE == ISA_TYPE_ENEC) ? isa_rom_outw((val), (port)) : isa_outw((val), (port)))
>> +#define outw_p(val, port) (((port) < 1024 && ISA_TYPE == ISA_TYPE_ENEC) ? isa_rom_outw_p((val), (port)) : isa_outw_p((val), (port)))
>>   #define outl		isa_outl
>>   #define outl_p		isa_outl_p
>>   
>> -#define insb(port, buf, nr)	((port) < 1024 ? isa_rom_insb((port), (buf), (nr)) : isa_insb((port), (buf), (nr)))
>> -#define insw(port, buf, nr)	((port) < 1024 ? isa_rom_insw((port), (buf), (nr)) : isa_insw((port), (buf), (nr)))
>> +#define insb(port, buf, nr)	(((port) < 1024 && ISA_TYPE == ISA_TYPE_ENEC) ? isa_rom_insb((port), (buf), (nr)) : isa_insb((port), (buf), (nr)))
>> +#define insw(port, buf, nr)	(((port) < 1024 && ISA_TYPE == ISA_TYPE_ENEC) ? isa_rom_insw((port), (buf), (nr)) : isa_insw((port), (buf), (nr)))
>>   #define insl			isa_insl
>> -#define outsb(port, buf, nr)	((port) < 1024 ? isa_rom_outsb((port), (buf), (nr)) : isa_outsb((port), (buf), (nr)))
>> -#define outsw(port, buf, nr)	((port) < 1024 ? isa_rom_outsw((port), (buf), (nr)) : isa_outsw((port), (buf), (nr)))
>> +#define outsb(port, buf, nr)	(((port) < 1024 && ISA_TYPE == ISA_TYPE_ENEC) ? isa_rom_outsb((port), (buf), (nr)) : isa_outsb((port), (buf), (nr)))
>> +#define outsw(port, buf, nr)	(((port) < 1024 && ISA_TYPE == ISA_TYPE_ENEC) ? isa_rom_outsw((port), (buf), (nr)) : isa_outsw((port), (buf), (nr)))
>>   #define outsl			isa_outsl
>>   
>> -#define readb(addr)		in_8(addr)
>> -#define writeb(val, addr)	out_8((addr), (val))
>> -#define readw(addr)		in_le16(addr)
>> -#define writew(val, addr)	out_le16((addr), (val))
>> +#define readb   isa_readb
>> +#define readw   isa_readw
>> +#define writeb  isa_writeb
>> +#define writew  isa_writew
>>   #endif /* CONFIG_ATARI_ROM_ISA */
>>   
>>   #define readl(addr)      in_le32(addr)
>>
