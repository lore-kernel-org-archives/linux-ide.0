Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E364C4708F
	for <linux-ide@archiver.kernel.org>; Fri,  4 Jun 2021 07:30:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4FB2061418
	for <linux-ide@archiver.kernel.org>; Fri,  4 Jun 2021 07:30:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbhFDHcD (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 4 Jun 2021 03:32:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbhFDHcD (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 4 Jun 2021 03:32:03 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A3B3C06174A;
        Fri,  4 Jun 2021 00:30:06 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id c13so4232342plz.0;
        Fri, 04 Jun 2021 00:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=QvNeY+TUg2ciFR2d4kkQYc+leD4JwOcx9v8UuLpzU4Y=;
        b=WQfNGq5JRWweovoG5ywR6JELGu1e6Nm/55kzHxS7EzvMadgSfezzJEUtBdbnBhBb/T
         3zxTlmXTe9QcrGE65XVYwxxI6JMCr2D9caJ3Cj0f7j5JmbbcPxv99FQQkPttvWpy0HAB
         BVR/qEz0tpXxaTcPbR4O/Geafm8tydK6w2Nyjm5X4I2wRABHfxyO2WdMiHa0zdzX65y/
         VqMATazJN3kslL+JzhgP9RZtTCERtU5xo0IeQXPz/iZRCY3MQYqhllX/wrk7v5qHuUF+
         Mo3Jg5Er1xjmaJTmH+t/n7bTLkqpId3VHh7/6VFA47osSS2ksWmDu91iwnbKoYTKFMXz
         Va4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=QvNeY+TUg2ciFR2d4kkQYc+leD4JwOcx9v8UuLpzU4Y=;
        b=fdgHwcvtTr30fFyg1fdlOEvHahmNKmOatu4CNdXr3zITjqPhniRuPC/aWCSewKSWuw
         t+tl9Oeo35uAXZuLv3x1t+MBHS4oIOICNkuuv7KzbWhSwV9Li6VMab/oygQSAH+NGc2Y
         7ezOzfl0jCo9e1UHI2oquglqlYeDjSfs1WdIqTFY6tGpu2VvRrGxPDZm4F8T0jNit8+c
         xE7olzabVqAP/rRTzKAjEHPMsaJmrkcSFio7prLTK1Q6hF9I7pbQcdqhL60N4+Gdv0ke
         nbQhdHNpoHEP90KlwZB+O/0ouau2kS4M4MceR9NGOjAH44NhrU02c8+31h/3AdSpPd5s
         a4vg==
X-Gm-Message-State: AOAM533yzzqZv6BItwUcMU9WEwhje/ujaeh8UW7omuJldW5+b1dxds2f
        y2zAxBeESheX5daICpq4Ipyl+e9Erzk=
X-Google-Smtp-Source: ABdhPJycCyKPvUbTl7k3RtMbkFyletjigiBRPUrd4RJk4yc4Y09J06l9Jyl4QaWI5DUmgqHBCnnF1Q==
X-Received: by 2002:a17:902:eaca:b029:109:7460:cc41 with SMTP id p10-20020a170902eacab02901097460cc41mr3079483pld.4.1622791805632;
        Fri, 04 Jun 2021 00:30:05 -0700 (PDT)
Received: from [10.1.1.25] (222-152-189-137-fibre.sparkbb.co.nz. [222.152.189.137])
        by smtp.gmail.com with ESMTPSA id o17sm3990076pjp.33.2021.06.04.00.30.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 Jun 2021 00:30:05 -0700 (PDT)
Subject: Re: [PATCH RFC 1/2] m68k: io_mm.h: conditionalize ISA address
 translation on Atari
To:     Finn Thain <fthain@linux-m68k.org>
References: <CAMuHMdUskb3oicq8Kbf6MY_4mn4-Y1pJ-om4fny7k48gndscgg@mail.gmail.com>
 <1622611267-15825-1-git-send-email-schmitzmic@gmail.com>
 <1622611267-15825-2-git-send-email-schmitzmic@gmail.com>
 <25ab336d-e0e0-41a8-d468-ecbf8d83d2b@linux-m68k.org>
 <143313da-d294-f89b-d285-235230514c5a@gmail.com>
 <d7165fdd-9269-7bd2-185-c6193f864722@linux-m68k.org>
Cc:     linux-m68k@vger.kernel.org, geert@linux-m68k.org,
        linux-ide@vger.kernel.org
From:   Michael Schmitz <schmitzmic@gmail.com>
Message-ID: <535b7829-f16f-4ddc-a676-dbb10c7a4a35@gmail.com>
Date:   Fri, 4 Jun 2021 19:30:00 +1200
User-Agent: Mozilla/5.0 (X11; Linux ppc; rv:45.0) Gecko/20100101
 Icedove/45.4.0
MIME-Version: 1.0
In-Reply-To: <d7165fdd-9269-7bd2-185-c6193f864722@linux-m68k.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Hi Finn,

Am 04.06.2021 um 17:55 schrieb Finn Thain:
> On Fri, 4 Jun 2021, Michael Schmitz wrote:
>
>> of the Q40 branch and out of the later Amiga Gayle PCMCIA branch to the
>> head of the file and add a comment explaining the rationale? Too much
>> churn for now?
>>
>
> Right, it could be too much churn for a bug-fix patch.

I'll leave that for later (but add a comment in the lines inserted).

>>>
>>>>   #ifdef CONFIG_AMIGA_PCMCIA
>>>> @@ -135,9 +139,12 @@ static inline u8 __iomem *isa_itb(unsigned long addr)
>>>>       case ISA_TYPE_AG: return (u8 __iomem *)AG_ISA_IO_B(addr);
>>>>   #endif
>>>>   #ifdef CONFIG_ATARI_ROM_ISA
>>>> -    case ISA_TYPE_ENEC: return (u8 __iomem *)ENEC_ISA_IO_B(addr);
>>>> +    case ISA_TYPE_ENEC: if (addr < 1024)
>>>> +				return (u8 __iomem *)ENEC_ISA_IO_B(addr);
>>>> +			else
>>>> +				return (u8 __iomem *)(addr);
>>> There is some trailing whitespace added here that 'git am' complains
>>> about.
>>>
>>> Also, I think a 'fallthrough' statement would be better than adding a new
>>> else branch that duplicates the new default case below.
>>
>> I'm still unsure whether changing the default branch for the sake of
>> fixing Atari behaviour is a sane idea - I was hoping for comments either
>> way.
>>
>
> You mean, what happens if a random m68k platform (other than amiga, atari
> and q40) were to adopt CONFIG_ISA? I guess it would be nice if that would
> 'just work' but it's probably never going to be needed.

The NULL default was meant to catch incorrect use of config options 
related to CONFIG_ISA. My repurposing the default branch for Atari's 
needs (no translation for IDE) defeats that. But the chance that we run 
into such incorrect use in the future are pretty slim indeed.

Still, my patch changes behaviour in existing drivers. We're quite 
certain it does not matter, but is that good enough to be accepted?

>
>> But if it's changed, you are correct that having the control flow fall
>> through instead of taking a redundant else branch is better.
>>
>> Essentially, changing that hunk to
>>
>>  #ifdef CONFIG_ATARI_ROM_ISA
>> -    case ISA_TYPE_ENEC: return (u8 __iomem *)ENEC_ISA_IO_B(addr);
>> +    case ISA_TYPE_ENEC: if (addr < 1024)
>> +				return (u8 __iomem *)ENEC_ISA_IO_B(addr);
>>
>> here (and elsewhere below)?
>>
>
> I worry about the static checkers that look for missing 'fallthrough' and

Never ran into 'fallthrough' except as comment annotation, but I now see 
that really is a thing these days. Amazing.

> 'break' statements. So I was thinking of something like this:
>
> static inline u8 __iomem *isa_itb(unsigned long addr)
> {
>   switch(ISA_TYPE)
>     {
> #ifdef CONFIG_Q40
>     case ISA_TYPE_Q40: return (u8 __iomem *)Q40_ISA_IO_B(addr);
> #endif
> #ifdef CONFIG_AMIGA_PCMCIA
>     case ISA_TYPE_AG: return (u8 __iomem *)AG_ISA_IO_B(addr);
> #endif
> #ifdef CONFIG_ATARI_ROM_ISA
>     case ISA_TYPE_ENEC:
>         if (addr < 1024)
>             return (u8 __iomem *)ENEC_ISA_IO_B(addr);
>         fallthrough;
> #endif
>     default: return (u8 __iomem *)(addr);
>     }
> }

This one makes it easy to eventually add another ISA_TYPE_ATARI case 
before the default case (which could then revert to NULL if desired).

>
>
> Alternatively you could just move the default out of the switch:
>
> static inline u8 __iomem *isa_itb(unsigned long addr)
> {
>   switch(ISA_TYPE)
>     {
> #ifdef CONFIG_Q40
>     case ISA_TYPE_Q40: return (u8 __iomem *)Q40_ISA_IO_B(addr);
> #endif
> #ifdef CONFIG_AMIGA_PCMCIA
>     case ISA_TYPE_AG: return (u8 __iomem *)AG_ISA_IO_B(addr);
> #endif
> #ifdef CONFIG_ATARI_ROM_ISA
>     case ISA_TYPE_ENEC:
>         if (addr < 1024)
>             return (u8 __iomem *)ENEC_ISA_IO_B(addr);
>         break;
> #endif
>     }
>     return (u8 __iomem *)(addr);
> }
>
>
> The latter is probably the more flexible style because 'break' doesn't
> care about the order of case labels.

Yes, but it rules out reverting the default case to NULL.

On balance, I'll go with the fallback (and will annotate that other 
Atari drivers fall back to the clause below on purpose).

Cheers,

	Michael
