Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA77BC48BDF
	for <linux-ide@archiver.kernel.org>; Fri, 11 Jun 2021 02:16:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9CD0613AD
	for <linux-ide@archiver.kernel.org>; Fri, 11 Jun 2021 02:16:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231379AbhFKCSo (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 10 Jun 2021 22:18:44 -0400
Received: from mail-pl1-f173.google.com ([209.85.214.173]:35549 "EHLO
        mail-pl1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230299AbhFKCSn (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 10 Jun 2021 22:18:43 -0400
Received: by mail-pl1-f173.google.com with SMTP id x19so2049142pln.2;
        Thu, 10 Jun 2021 19:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=K3YAgV4+yAbgeRczuZZtGmoBremfD0kDjOK763J9KSs=;
        b=iEH42GJ7WcwE4S13i14Faq3XN6Ix4o3YpnQF1lewHNjNK6oujzh5xppoQP+PoOmuiw
         BLunR81aEYXuXTS710aPLI24tqtJg2N8bZEffP6/3foL8fOB1/whFjYo2kaF7JQxq7iX
         xv3v0NjZf6vs8lF6iBlC057G2JLBtj8X+jPWbLkkAzH1mBiYpgvPxXIlz10qGQ/aDkik
         1zmExusmC0DYHwld2X7TYY1R8Y0nRLIHeJxEBBeBxAYw9wA7oy1l21TbPWKPDjpuBOTE
         NcCVcMciudnKPwOQxaiwqr0kc+n7tSg3zQDIPgaiyxRaDrx62OX3dSaHyOqk7JAHRJOf
         nlVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=K3YAgV4+yAbgeRczuZZtGmoBremfD0kDjOK763J9KSs=;
        b=EM41+fc5Y/c+zC8e96J/Xgt7GdUJLJvQSSVjeUR6n3yt/dfot05odyDbe8MGTYJkAQ
         PCVFDWfvbGYAZX5tMJd9SGK7nJHcf+aTOPDtjCKDwSG0dHh72erjqAB50IcsnurkH1bj
         bD4rIlKRiUZItEZubqTMrHZZOYVVMeLsTyrf2s83b1MBzq+B0ewSrEgvxFS/VRkr0xZn
         M8zMDIvP22I0YBsyvV73n1zX/UnqftVneKf3cLp86NEQnsgyzFAE6SM7tpgAjH3e4zGb
         OqtfK6mw6RTlKfJLfw4VuKmhSwVXgWLwffxP/CvL3XSSdoWy4NLY6CP07QMVh96LLhfO
         dmWA==
X-Gm-Message-State: AOAM530p0/7ZEtNUqWRVOhZNexrNhUK7Mz1BOyrGxsk7od7xCIpnDPVs
        4qIUXVkNju5SOrxQJMrWcfW/JS4DeR0=
X-Google-Smtp-Source: ABdhPJxgIXRD2fJhlTStByt66TDphOp5FRmvrzukgTjV6wBRLH5hB1ZGPvPRTxFa8ZboK8ozjoFk3A==
X-Received: by 2002:a17:90a:d585:: with SMTP id v5mr1855396pju.7.1623377730822;
        Thu, 10 Jun 2021 19:15:30 -0700 (PDT)
Received: from ?IPv6:2001:df0:0:200c:35cd:a336:2686:ba33? ([2001:df0:0:200c:35cd:a336:2686:ba33])
        by smtp.gmail.com with ESMTPSA id e2sm3457262pfc.135.2021.06.10.19.15.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Jun 2021 19:15:30 -0700 (PDT)
Subject: Re: [PATCH v1 1/2] m68k: io_mm.h - add APNE 100 MBit support
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Finn Thain <fthain@linux-m68k.org>
Cc:     Andreas Schwab <schwab@linux-m68k.org>,
        Linux/m68k <linux-m68k@vger.kernel.org>,
        linux-ide@vger.kernel.org, ALeX Kazik <alex@kazik.de>
References: <1622958877-2026-1-git-send-email-schmitzmic@gmail.com>
 <1623224214-4836-1-git-send-email-schmitzmic@gmail.com>
 <1623224214-4836-2-git-send-email-schmitzmic@gmail.com>
 <87zgvzzcp6.fsf@igel.home> <e3643beb-7d61-e39f-83ca-f44a927b69db@gmail.com>
 <c8306197-1342-6924-9d46-ba61f1ee7112@linux-m68k.org>
 <CAMuHMdVGoUhs3N3bdOQ2OxQa+69LcK0YOG2HASbFNhD4Qpc2+Q@mail.gmail.com>
From:   Michael Schmitz <schmitzmic@gmail.com>
Message-ID: <8493043b-818f-db60-2f9f-03fbcc917427@gmail.com>
Date:   Fri, 11 Jun 2021 14:15:25 +1200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAMuHMdVGoUhs3N3bdOQ2OxQa+69LcK0YOG2HASbFNhD4Qpc2+Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Hi Geert,

thanks for the explanation - and thanks Finn and Andreas for clarifying. 
I've removed the annotation in v2.

Cheers,

     Michael

On 10/06/21 7:32 pm, Geert Uytterhoeven wrote:
> Hi Finn,
>
> On Thu, Jun 10, 2021 at 3:09 AM Finn Thain <fthain@linux-m68k.org> wrote:
>> On Thu, 10 Jun 2021, Michael Schmitz wrote:
>>> On 9/06/21 8:04 pm, Andreas Schwab wrote:
>>>> On Jun 09 2021, Michael Schmitz wrote:
>>>>
>>>>> @@ -136,6 +141,9 @@ static inline u8 __iomem *isa_itb(unsigned long addr)
>>>>>        case ISA_TYPE_Q40: return (u8 __iomem *)Q40_ISA_IO_B(addr);
>>>>>    #endif
>>>>>    #ifdef CONFIG_AMIGA_PCMCIA
>>>>> +#ifdef CONFIG_APNE100MBIT
>>>>> +    case ISA_TYPE_AG16: fallthrough;
>>>>> +#endif
>>>>>        case ISA_TYPE_AG: return (u8 __iomem *)AG_ISA_IO_B(addr);
>>>> Is the fallthrough annotation really needed?
>>> Just to shut up compiler warnings, and even that I haven't seen myself.
>>>
>>> I have seen a number of patches adding either comments or this annotation in
>>> the core NCR5380 driver (which Finn maintains, who suggested this annotation
>>> to an earlier version of the Q40/Atari io_mm.h patch), so adding annotations
>>> appears to be encouraged now.
>>>
>>> I personally think these annotations are over the top generally, but I've
>>> learned to program when computed goto statements were still en vogue.
>>>
>>> In this particular case, there can be no doubt that the fallthrough is
>>> intentional, so on balance, I'll remove those annotations as well (unless Finn
>>> strongly objects?).
>>>
>> I don't object to removing it. On the contrary, in a previous message I
>> also questioned adding this particular 'fallthrough' (though I did
>> recommended adding a different one).
>>
>> In general, there's no way to predict which static checkers are going to
>> complain about any given line of code. They don't all agree about
>> correctness and they are a moving target, just like fashion or reviewers'
>> preferred code styles.
> AFAIK, they only complain when the switch() operates on an enum,
> and not all enum values are handled.
>
> When operating on an int, there's not enough address space on
> 32-bit machines to handle all cases ;-)
>
> Gr{oetje,eeting}s,
>
>                          Geert
>
