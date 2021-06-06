Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0634AC4743E
	for <linux-ide@archiver.kernel.org>; Sun,  6 Jun 2021 05:42:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DDF80611AB
	for <linux-ide@archiver.kernel.org>; Sun,  6 Jun 2021 05:42:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229525AbhFFFok (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sun, 6 Jun 2021 01:44:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbhFFFoj (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sun, 6 Jun 2021 01:44:39 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE09EC061766;
        Sat,  5 Jun 2021 22:42:36 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id 22-20020a17090a0c16b0290164a5354ad0so9891439pjs.2;
        Sat, 05 Jun 2021 22:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=dGIfQnkEBB0LG9x7fr1otv7+6zveCpfYz1mDMhOEA2A=;
        b=L3qOnwa3Z030M7papwiz4qrkH+v0nN+FZ3raqdK3HEa3vFtsQ4ifIT1Ci5AV1UsQLJ
         UPMaBehJGNOdJL91TmT2dt27QfCjkfa+O/soEvYKBDLqdp36zTZxVxans3BlTQDdUj2P
         0iAwKpQV15J+rmvbZDszPABIaO7m1UXXawToi3nu+JLteRYA1TSdS6q/8l/1iufMIoqW
         3KBjsb4pQeNUsni8sVvYAhC+pd3X6PB1rmT13La0i7NjJ1+Dg75diSQ/IbL4gum5ENNI
         dJ/W5E3fH9101o8My1RZ9UllKMns/aNOmw0CxDwvBOmqpXFIc//qTfPucVSxEuJHG6b7
         6N8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=dGIfQnkEBB0LG9x7fr1otv7+6zveCpfYz1mDMhOEA2A=;
        b=VSNVSjzQ9tHoN/MZicXaCjOFYBH6IfBeK4C9jLyg4CVUHsXZgiSOqAumLboqyE3rBD
         SkSJ4VVSmK830mybXls73DW4Mx32hEuB2i+U/toceY2Tb1pemNFtqSPeUf2kiljy3dd8
         /Qvy4IuXKh8Vc7YwTQ4+oQd55dGdznT0lGo0NAcSOtehtTHm9MJsLZLYMTLVOtffWWGX
         d4F9uTOtdO/TU2lnzj8QdoOmalnGHN7w+myJzlh419gPW8Pb0RJOkGfOqc8AOJZeAqgQ
         j21p1ScNDOrKlhHJnaCTN8CHgvZxyPpzYdCW7k0nnHDV4EKE5ar1HBmjX5QAJDTHJuVU
         DmmQ==
X-Gm-Message-State: AOAM530N54e4slxO/gM4U+uU7OMVmwUU0ytvUC9RJYauVo+0xUysM6IN
        lU0MNXnTe4+YC8p9ELSLBWw=
X-Google-Smtp-Source: ABdhPJxGMGhaTdFqqDUaz9vd8Wf/WQhm95lv0BovbprIo7GF98cSqSQB7Q4ntiXymujKxHCHNKCPNw==
X-Received: by 2002:a17:90a:7f92:: with SMTP id m18mr25199479pjl.168.1622958156316;
        Sat, 05 Jun 2021 22:42:36 -0700 (PDT)
Received: from [10.1.1.25] (222-152-189-137-fibre.sparkbb.co.nz. [222.152.189.137])
        by smtp.gmail.com with ESMTPSA id p17sm8512017pjg.54.2021.06.05.22.42.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 05 Jun 2021 22:42:35 -0700 (PDT)
Subject: Re: [PATCH RFC 1/2] m68k: io_mm.h: conditionalize ISA address
 translation on Atari
To:     Finn Thain <fthain@linux-m68k.org>
References: <CAMuHMdUskb3oicq8Kbf6MY_4mn4-Y1pJ-om4fny7k48gndscgg@mail.gmail.com>
 <1622611267-15825-1-git-send-email-schmitzmic@gmail.com>
 <1622611267-15825-2-git-send-email-schmitzmic@gmail.com>
 <25ab336d-e0e0-41a8-d468-ecbf8d83d2b@linux-m68k.org>
 <143313da-d294-f89b-d285-235230514c5a@gmail.com>
 <d7165fdd-9269-7bd2-185-c6193f864722@linux-m68k.org>
 <535b7829-f16f-4ddc-a676-dbb10c7a4a35@gmail.com>
 <20210604224955.GA12141@allandria.com>
 <eefa79e9-01d3-9179-9ca6-57500b9ab7c2@gmail.com>
 <20210605060447.GA18461@allandria.com>
 <5bed9868-2cb6-6604-abb9-faa9361fa3e3@gmail.com>
 <bfce51f-a393-7c3e-77f0-a99595a0d037@linux-m68k.org>
Cc:     Brad Boyer <flar@allandria.com>, linux-m68k@vger.kernel.org,
        geert@linux-m68k.org, linux-ide@vger.kernel.org,
        ALeX Kazik <alex@kazik.de>
From:   Michael Schmitz <schmitzmic@gmail.com>
Message-ID: <460124e6-6ac3-4b94-43de-ebff5cb50cf8@gmail.com>
Date:   Sun, 6 Jun 2021 17:42:30 +1200
User-Agent: Mozilla/5.0 (X11; Linux ppc; rv:45.0) Gecko/20100101
 Icedove/45.4.0
MIME-Version: 1.0
In-Reply-To: <bfce51f-a393-7c3e-77f0-a99595a0d037@linux-m68k.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Hi Finn,

Thanks for the quick review!

Am 06.06.2021 um 16:53 schrieb Finn Thain:
> On Sun, 6 Jun 2021, Michael Schmitz wrote:
>
>>
>> This patch to io_mm.h (on top of my current patch), plus setting isa_type to
>> ISA_TPYE_AG100 using a module parameter, should do the trick:
>>
>> diff --git a/arch/m68k/include/asm/io_mm.h b/arch/m68k/include/asm/io_mm.h
>> index f6b487b..6f79a5e 100644
>> --- a/arch/m68k/include/asm/io_mm.h
>> +++ b/arch/m68k/include/asm/io_mm.h
>> @@ -102,6 +102,11 @@
>>  #define ISA_TYPE_AG   (2)
>>  #define ISA_TYPE_ENEC (3)
>>
>> +#if defined(CONFIG_AMIGA_PCMCIA_100)
>> +#define ISA_TYPE_AG100 (4)     /* for 100 MBit APNE card */
>
> IMHO this would be simpler if that #define was unconditional like the
> others.

Yep, that one could be unconditional (and we could rearrange the defs to 
keep the new type between AG and ENEC).

>
>> +#define MULTI_ISA 1
>
> Hmm...
>

That one I didn't want to make unconditional, in order to allow the 
optimization below.

>> +#endif
>> +
>>  #if defined(CONFIG_Q40) && !defined(MULTI_ISA)
>>  #define ISA_TYPE ISA_TYPE_Q40
>>  #define ISA_SEX  0
>> @@ -135,6 +140,9 @@ static inline u8 __iomem *isa_itb(unsigned long addr)
>>  #ifdef CONFIG_Q40
>>      case ISA_TYPE_Q40: return (u8 __iomem *)Q40_ISA_IO_B(addr);
>>  #endif
>> +#if defined(CONFIG_AMIGA_PCMCIA_100)
>> +    case ISA_TYPE_AG100: fallthrough;
>> +#endif
>
> I wonder whether that 'fallthrough' is needed. One would hope not...

It won't be, but it ought to shut up compiler warnings, no?

>
>>  #ifdef CONFIG_AMIGA_PCMCIA
>>      case ISA_TYPE_AG: return (u8 __iomem *)AG_ISA_IO_B(addr);
>>  #endif
>> @@ -153,6 +161,9 @@ static inline u16 __iomem *isa_itw(unsigned long addr)
>>  #ifdef CONFIG_Q40
>>      case ISA_TYPE_Q40: return (u16 __iomem *)Q40_ISA_IO_W(addr);
>>  #endif
>> +#if defined(CONFIG_AMIGA_PCMCIA_100)
>> +    case ISA_TYPE_AG100: fallthrough;
>> +#endif
>>  #ifdef CONFIG_AMIGA_PCMCIA
>>      case ISA_TYPE_AG: return (u16 __iomem *)AG_ISA_IO_W(addr);
>>  #endif
>> @@ -168,6 +179,9 @@ static inline u32 __iomem *isa_itl(unsigned long addr)
>>  {
>>    switch(ISA_TYPE)
>>      {
>> +#if defined(CONFIG_AMIGA_PCMCIA_100)
>> +    case ISA_TYPE_AG100: fallthrough;
>> +#endif
>>  #ifdef CONFIG_AMIGA_PCMCIA
>>      case ISA_TYPE_AG: return (u32 __iomem *)AG_ISA_IO_W(addr);
>>  #endif
>> @@ -181,6 +195,9 @@ static inline u8 __iomem *isa_mtb(unsigned long addr)
>>  #ifdef CONFIG_Q40
>>      case ISA_TYPE_Q40: return (u8 __iomem *)Q40_ISA_MEM_B(addr);
>>  #endif
>> +#if defined(CONFIG_AMIGA_PCMCIA_100)
>> +    case ISA_TYPE_AG100: fallthrough;
>> +#endif
>>  #ifdef CONFIG_AMIGA_PCMCIA
>>      case ISA_TYPE_AG: return (u8 __iomem *)addr;
>>  #endif
>> @@ -199,6 +216,9 @@ static inline u16 __iomem *isa_mtw(unsigned long addr)
>>  #ifdef CONFIG_Q40
>>      case ISA_TYPE_Q40: return (u16 __iomem *)Q40_ISA_MEM_W(addr);
>>  #endif
>> +#if defined(CONFIG_AMIGA_PCMCIA_100)
>> +    case ISA_TYPE_AG100: fallthrough;
>> +#endif
>>  #ifdef CONFIG_AMIGA_PCMCIA
>>      case ISA_TYPE_AG: return (u16 __iomem *)addr;
>>  #endif
>> @@ -219,6 +239,11 @@ static inline u16 __iomem *isa_mtw(unsigned long addr)
>>  #define isa_outw(val,port) (ISA_SEX ? out_be16(isa_itw(port),(val)) :
>> out_le16(isa_itw(port),(val)))
>>  #define isa_outl(val,port) (ISA_SEX ? out_be32(isa_itl(port),(val)) :
>> out_le32(isa_itl(port),(val)))
>>
>> +#if defined(CONFIG_AMIGA_PCMCIA_100)
>> +#undef isa_inb
>> +#define isa_inb(port)      ((ISA_TYPE == ISA_TYPE_AG100) ? ((port) & 1 ?
>> isa_inw((port) - 1) & 0xff : isa_inw(port) >> 8) : in_8(isa_itb(port))
>> +#endif
>> +
>
> Would (port & ~1) be faster than (port - 1) here?

Perhaps it would - I'd hope the compiler will pick the most efficient 
solution here.

>
> Also, I don't think you need '#if defined' here. When
> !defined(CONFIG_AMIGA_PCMCIA_100), I think ISA_TYPE should be a
> compile-time constant 0, and the dead code will get tossed out anyway.

Right, that's a good point.

>>  #define isa_readb(p)       in_8(isa_mtb((unsigned long)(p)))
>>  #define isa_readw(p)       \
>>         (ISA_SEX ? in_be16(isa_mtw((unsigned long)(p))) \
>>
>> (linebreak-mangled, sorry).
>>
>> The card reset patch hunk from Alex' patch can probably go into the APNE
>> driver regardless?
>>
>> It's been quite a while - can you still try and build/test this change, Alex?
>
> Note that isa_type is never assigned to ISA_TYPE_AG100 in
> arch/m68k/kernel/setup_mm.c which means (IIUC) this patch won't take
> effect with MULTI_ISA == 1.

In order to make this useful, a Kconfig option is needed, and a module 
parameter will set isa_type to ISA_TYPE_AG100 in the APNE probe routine. 
I'll send the complete set as RFC soon. Will include your suggestions 
before doing that, of course.

Cheers,

	Michael



>
