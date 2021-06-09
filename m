Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 233A7C48BCF
	for <linux-ide@archiver.kernel.org>; Wed,  9 Jun 2021 21:54:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0672D613E1
	for <linux-ide@archiver.kernel.org>; Wed,  9 Jun 2021 21:54:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229678AbhFIV43 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 9 Jun 2021 17:56:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbhFIV42 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 9 Jun 2021 17:56:28 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8FECC061574;
        Wed,  9 Jun 2021 14:54:19 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id m7so6754235pfa.10;
        Wed, 09 Jun 2021 14:54:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=iHSKR5VkblAr+hSVKVwtX2Yt+KGm2Po+HaIdtBk0n7k=;
        b=UkCuJMHGG9QgmU8jI+R0zKRuDfSwiZsL7SLaWfiw8n5kZ9VML6v1dEihDlqXIY1L8p
         Z2cw3Wqxyu36kI1k3zIJ0CxMm9a3cHvZ9G/ptvFKlVBQri0ArlKgJ0FpherMcQ0w9GgY
         18bmuhYcq217n/dlGJoej3l0D+ilNPVcBhce8tvQ6BWk1hWr7mBWyq28Lk7nRRkM1j8Q
         zEtYsL/t03CM5BakbvSLvBbuufDf3p6IEpQ7cuzlGNheF/2+IhY5Gffu0h+O77jUT4C9
         XU+3tmD4MMr98Wj0peXCccbpN6jXtEatDFExsysA9H+jDn0oFSG3RKf7eg50vIdxObXJ
         2Q2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=iHSKR5VkblAr+hSVKVwtX2Yt+KGm2Po+HaIdtBk0n7k=;
        b=unInvSz9rgKvLVi2RyNT+Dejx4X066vxyHZIrdB1bUrXVCe6MunpLwJkP3OhzJAyph
         VzE1F5z4ojqiruBfTsN/2IUcAs8T+LJ68p+XRLM9HX2b2Bjo+Ty38v758BUBLZelTmkc
         Cz1qB3obPFBcRi87VDOu5ICZjWD3iDQFg22MTGxAg4NMYbKS/hYQVP5dXgfuANpsbS8E
         mYoLlSfEHrYKbMJ5rAJwby72A5nEIULF3ITVIl3Eg9Kc6pprBoRGEJo6rLmdDYB5Oo/C
         K07gjLMBsP0xBb1Haih3Ljc481sx2WwsUyor6gztnDe2BQ76VrLS5C0v8gKi90sKWiNf
         3UZg==
X-Gm-Message-State: AOAM531+lfpON/QMv/wDiV2R2SIPy4IPjlrTnbEEbYanV3OeeLzi29rX
        Omiznm7g9uLjVIrqXBqM21P2Tb4IicE5fg==
X-Google-Smtp-Source: ABdhPJyUTsA0shCXS5f7JtH6sKs/LbjXkObC3lFLqYLxy2U9KaSLMqwzoe4of6jXOzQi8zcsEZnOuA==
X-Received: by 2002:a63:3fc6:: with SMTP id m189mr1710195pga.239.1623275659409;
        Wed, 09 Jun 2021 14:54:19 -0700 (PDT)
Received: from ?IPv6:2001:df0:0:200c:459f:1243:2a64:9384? ([2001:df0:0:200c:459f:1243:2a64:9384])
        by smtp.gmail.com with ESMTPSA id i74sm640134pgc.85.2021.06.09.14.54.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Jun 2021 14:54:18 -0700 (PDT)
Subject: Re: [PATCH v1 1/2] m68k: io_mm.h - add APNE 100 MBit support
To:     Andreas Schwab <schwab@linux-m68k.org>
Cc:     linux-m68k@vger.kernel.org, geert@linux-m68k.org,
        linux-ide@vger.kernel.org, fthain@linux-m68k.org, alex@kazik.de
References: <1622958877-2026-1-git-send-email-schmitzmic@gmail.com>
 <1623224214-4836-1-git-send-email-schmitzmic@gmail.com>
 <1623224214-4836-2-git-send-email-schmitzmic@gmail.com>
 <87zgvzzcp6.fsf@igel.home>
From:   Michael Schmitz <schmitzmic@gmail.com>
Message-ID: <e3643beb-7d61-e39f-83ca-f44a927b69db@gmail.com>
Date:   Thu, 10 Jun 2021 09:54:13 +1200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <87zgvzzcp6.fsf@igel.home>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Hi Andreas,

On 9/06/21 8:04 pm, Andreas Schwab wrote:
> On Jun 09 2021, Michael Schmitz wrote:
>
>> @@ -136,6 +141,9 @@ static inline u8 __iomem *isa_itb(unsigned long addr)
>>       case ISA_TYPE_Q40: return (u8 __iomem *)Q40_ISA_IO_B(addr);
>>   #endif
>>   #ifdef CONFIG_AMIGA_PCMCIA
>> +#ifdef CONFIG_APNE100MBIT
>> +    case ISA_TYPE_AG16: fallthrough;
>> +#endif
>>       case ISA_TYPE_AG: return (u8 __iomem *)AG_ISA_IO_B(addr);
> Is the fallthrough annotation really needed?

Just to shut up compiler warnings, and even that I haven't seen myself.

I have seen a number of patches adding either comments or this 
annotation in the core NCR5380 driver (which Finn maintains, who 
suggested this annotation to an earlier version of the Q40/Atari io_mm.h 
patch), so adding annotations appears to be encouraged now.

I personally think these annotations are over the top generally, but 
I've learned to program when computed goto statements were still en vogue.

In this particular case, there can be no doubt that the fallthrough is 
intentional, so on balance, I'll remove those annotations as well 
(unless Finn strongly objects?).

Cheers,

     Michael


Cheers,

     Michael


>
> Andreas.
>
