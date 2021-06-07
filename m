Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D37D7C4743C
	for <linux-ide@archiver.kernel.org>; Mon,  7 Jun 2021 08:20:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD4CD60FF1
	for <linux-ide@archiver.kernel.org>; Mon,  7 Jun 2021 08:20:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229966AbhFGIWn (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 7 Jun 2021 04:22:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbhFGIWn (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 7 Jun 2021 04:22:43 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99481C061766;
        Mon,  7 Jun 2021 01:20:41 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id y11so5100833pgp.11;
        Mon, 07 Jun 2021 01:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=ylO/wdc1VdVFubZnWN/uQDyCsO2dQArrXh03N+cMyz0=;
        b=CiyQ4R9kjfdhFFOdc43dU7C03suZHFuprC0XsS/E2SZT5Amn0ozkqvMosscCSKAbB3
         r78lZYvITFGnhnrNmfHWaUqFXrBZHu6xUlQGpZsUK9H8hmjIaO3BAVesvBLRsa5zNPwS
         Gg294YcLJOQzfgvvBPY3vHRfFzeVFiaFfUgPlLFsNLpD1sgNdKFFLDiKiB2ABxH9aVuU
         W3PObMqRHlkUHCRvoE0SbSXtcUCSjw4w3dA9GdOZDKBaNe9wydTgmZsqfeNEgtgxG6Sg
         GSUMpUN5RaO/wcFflh27fGcsfqvH83RXsnVxxQ8lcRK4wEdlgf19Z7/Bhj1Mp8NOdXGN
         HTOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=ylO/wdc1VdVFubZnWN/uQDyCsO2dQArrXh03N+cMyz0=;
        b=ISDUW/7/FpugL1uzBNESXukbwTMw2vfpY6T+GS9gfqhu0eVWK3wu/f3n1plWi8qPKq
         +52Xxjkv4GIv2xJqJGDMnKuuWhJ0ERuxYq/iOoXUgAZFT3wFXwNi9RRPRp9V6BEoD2Ng
         wuoIFTIATzMKzYXYG9YGK4Z/gFCQ28i0eRqOZMXNEbR+CCetYmY3E20ZENOOqbvnOUzu
         nlqHHnRZSn5n7TQjFaOLaxLunh+mxf1RwXaIn7YueAakf0Jv/7C3/go8lQHwmY5lsTtZ
         aQcpt+PKChEa4jXymL4R8Y/nJ/3CfWvoeVggyw1+/A2WnJa1tO1J2mSCNEmDTmLPKV4L
         7wOA==
X-Gm-Message-State: AOAM530ftayNehkeM0Fz7IODW8Nwn/gRUa5X1qsdQQeE1GomYdS7MZxJ
        8IDIQXrfaOakxCjYQZ1CJ3ALPvbDt0Y=
X-Google-Smtp-Source: ABdhPJx6soFoajJO+cZFdf06o27JcWQzZyEUb1LDwSWB7sGQiXjCWBHtRqCwA8wihLwuRcjnM6gQaQ==
X-Received: by 2002:aa7:900f:0:b029:2ec:82d2:d23 with SMTP id m15-20020aa7900f0000b02902ec82d20d23mr14695373pfo.16.1623054040314;
        Mon, 07 Jun 2021 01:20:40 -0700 (PDT)
Received: from [10.1.1.25] (222-152-189-137-fibre.sparkbb.co.nz. [222.152.189.137])
        by smtp.gmail.com with ESMTPSA id i10sm7619958pfk.74.2021.06.07.01.20.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Jun 2021 01:20:39 -0700 (PDT)
Subject: Re: [PATCH RFC 1/2] m68k: io_mm.h - add APNE 100 MBit support
To:     Geert Uytterhoeven <geert@linux-m68k.org>
References: <20210605060447.GA18461@allandria.com>
 <1622958877-2026-1-git-send-email-schmitzmic@gmail.com>
 <1622958877-2026-2-git-send-email-schmitzmic@gmail.com>
 <CAMuHMdUH1LJrrU2VKbtgYvvSVgKk-=1yOW9kWot3EKk=kADZcA@mail.gmail.com>
Cc:     Linux/m68k <linux-m68k@vger.kernel.org>, linux-ide@vger.kernel.org,
        Finn Thain <fthain@linux-m68k.org>, ALeX Kazik <alex@kazik.de>
From:   Michael Schmitz <schmitzmic@gmail.com>
Message-ID: <85e4f6b6-e9c2-dac7-0c88-b0e18cf1254b@gmail.com>
Date:   Mon, 7 Jun 2021 20:20:33 +1200
User-Agent: Mozilla/5.0 (X11; Linux ppc; rv:45.0) Gecko/20100101
 Icedove/45.4.0
MIME-Version: 1.0
In-Reply-To: <CAMuHMdUH1LJrrU2VKbtgYvvSVgKk-=1yOW9kWot3EKk=kADZcA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Hi Geert,

Thanks for reviewing this one as well!

Am 07.06.2021 um 20:01 schrieb Geert Uytterhoeven:
> Hi Michael,
>
> On Sun, Jun 6, 2021 at 7:54 AM Michael Schmitz <schmitzmic@gmail.com> wrote:
>> Add code to support 10 Mbit and 100 Mbit mode for APNE driver.
>>
>> A new ISA type ISA_TYPE_AG100 switches the Amiga ISA inb accessor
>> to word access as required by the 100 Mbit cards.
>
> missing "dynamically".

OK...

>
>>
>> Patch modified after patch "[PATCH RFC net-next] Amiga PCMCIA
>> 100 MBit card support" submitted to netdev 2018/09/16 by Alex
>> Kazik <alex@kazik.de>.
>>
>> Signed-off-by: Michael Schmitz <schmitzmic@gmail.com>
>
> Thanks for your patch!
>
>> --- a/arch/m68k/include/asm/io_mm.h
>> +++ b/arch/m68k/include/asm/io_mm.h
>> @@ -101,6 +101,11 @@
>>  #define ISA_TYPE_Q40  (1)
>>  #define ISA_TYPE_AG   (2)
>>  #define ISA_TYPE_ENEC (3)
>> +#define ISA_TYPE_AG100 (4)     /* for 100 MBit APNE card */
>
> As this type may be needed for other cards, perhaps it should be
> named after what it really does, i.e. always using 16-bit accesses?
> ISA_TYPE_AG16?

Yep, that sounds better.

>
>> +
>> +#if defined(CONFIG_APNE100MBIT)
>
> #ifdef
>
>> +#define MULTI_ISA 1
>> +#endif
>>
>>  #if defined(CONFIG_Q40) && !defined(MULTI_ISA)
>>  #define ISA_TYPE ISA_TYPE_Q40
>> @@ -135,6 +140,9 @@ static inline u8 __iomem *isa_itb(unsigned long addr)
>>  #ifdef CONFIG_Q40
>>      case ISA_TYPE_Q40: return (u8 __iomem *)Q40_ISA_IO_B(addr);
>>  #endif
>> +#if defined(CONFIG_APNE100MBIT)
>
> #ifdef
>
>> +    case ISA_TYPE_AG100: fallthrough;
>
> Fallthrough to what? Oh, to ISA_TYPE_AG.
> Please make this clear, and safer, by moving this inside the #ifdef
> below (CONFIG_APNE100MBIT depends on CONFIG_AMIGA_PCMCIA).

OK, good point.

>> +#endif
>>  #ifdef CONFIG_AMIGA_PCMCIA
>>      case ISA_TYPE_AG: return (u8 __iomem *)AG_ISA_IO_B(addr);
>>  #endif
>
>> @@ -212,13 +232,16 @@ static inline u16 __iomem *isa_mtw(unsigned long addr)
>>  }
>>
>>
>> -#define isa_inb(port)      in_8(isa_itb(port))
>
> Why move it below? Because its comment does not apply to the below?

Because the new form depends on isa_inw()? I've seen order matter in CPP 
statements before ...

>>  #define isa_inw(port)      (ISA_SEX ? in_be16(isa_itw(port)) : in_le16(isa_itw(port)))
>>  #define isa_inl(port)      (ISA_SEX ? in_be32(isa_itl(port)) : in_le32(isa_itl(port)))
>>  #define isa_outb(val,port) out_8(isa_itb(port),(val))
>>  #define isa_outw(val,port) (ISA_SEX ? out_be16(isa_itw(port),(val)) : out_le16(isa_itw(port),(val)))
>>  #define isa_outl(val,port) (ISA_SEX ? out_be32(isa_itl(port),(val)) : out_le32(isa_itl(port),(val)))
>>
>> +/* for APNE 100 Mbit cards - hope the APNE 100 case will be eliminated as
>> + * dead code if MULTI_ISA is not set */
>
> I don't think this comment is needed.

I'll remove it, then.

Cheers,

	Michael


>
>> +#define isa_inb(port)      ((ISA_TYPE == ISA_TYPE_AG100) ? ((port) & 1 ? isa_inw((port) - 1) & 0xff : isa_inw(port) >> 8) : in_8(isa_itb(port))
>> +
>>  #define isa_readb(p)       in_8(isa_mtb((unsigned long)(p)))
>>  #define isa_readw(p)       \
>>         (ISA_SEX ? in_be16(isa_mtw((unsigned long)(p))) \
>
> Gr{oetje,eeting}s,
>
>                         Geert
>
