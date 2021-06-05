Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EDBEC4743D
	for <linux-ide@archiver.kernel.org>; Sat,  5 Jun 2021 03:49:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6ECAC610C9
	for <linux-ide@archiver.kernel.org>; Sat,  5 Jun 2021 03:49:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230172AbhFEDvW (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 4 Jun 2021 23:51:22 -0400
Received: from mail-pj1-f44.google.com ([209.85.216.44]:33558 "EHLO
        mail-pj1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbhFEDvV (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 4 Jun 2021 23:51:21 -0400
Received: by mail-pj1-f44.google.com with SMTP id k22-20020a17090aef16b0290163512accedso6115334pjz.0;
        Fri, 04 Jun 2021 20:49:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=GBdJY+ZehDLZFETQ3K3hHiV6oSZJHWmyyROA3/Y69Io=;
        b=C9LHRGMc5MlfeEBcf0LFFwRK34daaczU/hFOwmdAqghtjZiqC8gOqa+2wj9rfq60oh
         1GSeAz9GY+Nwn4QyAaLTMKAAD2ydKQOw+uoX/mg29i5kVexJ8jkHQiWOYykdKjYbElIM
         /tN8373h2TQWDpPl1XZwUutgDBpebonWoE7mYkPMOiStLQceZMrigFn/AldLaP5s7SQD
         QgfWTIUiggZCshASolWRuXaZSJgUnrqodac7sVB2bAxD3BVeFOfZ26SI3+aKzV8mplfv
         iN4ghRqUha5Xm0oVH/4CvdDibKjvGcAix+/b6y4y8TYALi1LQSfniVJDKVIEN3Y/G+bZ
         4rww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=GBdJY+ZehDLZFETQ3K3hHiV6oSZJHWmyyROA3/Y69Io=;
        b=pH5jkLtxVWRLWmaFLAjRHveu15x7LyQ3qPaCbZ04oofyoekHT0TI4Li8KLzAl38J2k
         JRUT40d3Xsy8IJXBLO+pVRPfG6XID4od0UBes45OJzXnTefCjqqRbfI5b0LxRwNKtMrX
         rbqhl448xaiBTP/pl+XtTlxZWKiJB/KuttoTGp+9jFQoo/ip5t7cyEfjirJnHrKnBv85
         OH8USJaxUbEQIrgNaTXWnp4pCfCsVrokQiRmXXo/MKNsTEyk8fXH6EWILK9ocRlq9q/K
         brToEVXfz9vG0sB1YIQ2uaRWRSrePSPR6wPW+ligR7bnYGsGrcFHVg/e/8K02RCq8TTS
         mPfA==
X-Gm-Message-State: AOAM533YcB1VVRGP+lg3ObriEx79j8/KHdMzm0kjpov+hhWCEFv7Yfhv
        1ONtPU31Wh7lL/KlLe4CjYEKkFXB+DI=
X-Google-Smtp-Source: ABdhPJw1DE69EOqfI0Fy96DTYNx4IbwTf/ze4Y81UBH+Zgf0pwmPXSqdlbgX7/IExKC5/jPFo8Q+VQ==
X-Received: by 2002:a17:90a:414a:: with SMTP id m10mr19483942pjg.149.1622864900188;
        Fri, 04 Jun 2021 20:48:20 -0700 (PDT)
Received: from [10.1.1.25] (222-152-189-137-fibre.sparkbb.co.nz. [222.152.189.137])
        by smtp.gmail.com with ESMTPSA id ca6sm6010313pjb.21.2021.06.04.20.48.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 Jun 2021 20:48:19 -0700 (PDT)
Subject: Re: [PATCH RFC 1/2] m68k: io_mm.h: conditionalize ISA address
 translation on Atari
To:     Finn Thain <fthain@linux-m68k.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
References: <CAMuHMdUskb3oicq8Kbf6MY_4mn4-Y1pJ-om4fny7k48gndscgg@mail.gmail.com>
 <1622611267-15825-1-git-send-email-schmitzmic@gmail.com>
 <1622611267-15825-2-git-send-email-schmitzmic@gmail.com>
 <25ab336d-e0e0-41a8-d468-ecbf8d83d2b@linux-m68k.org>
 <143313da-d294-f89b-d285-235230514c5a@gmail.com>
 <CAMuHMdU5ebmsErLdy6EykCHNULsBVFCpVsz0H3gpTLUmH1tt7g@mail.gmail.com>
 <28042fd1-4a54-af21-347f-165b8e4e63b4@gmail.com>
 <3ee560b9-2f87-5cf8-cc6-e1c34eea7cef@linux-m68k.org>
Cc:     Linux/m68k <linux-m68k@vger.kernel.org>, linux-ide@vger.kernel.org
From:   Michael Schmitz <schmitzmic@gmail.com>
Message-ID: <7a4c72e9-a901-c6b3-9713-423954734308@gmail.com>
Date:   Sat, 5 Jun 2021 15:48:14 +1200
User-Agent: Mozilla/5.0 (X11; Linux ppc; rv:45.0) Gecko/20100101
 Icedove/45.4.0
MIME-Version: 1.0
In-Reply-To: <3ee560b9-2f87-5cf8-cc6-e1c34eea7cef@linux-m68k.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Hi Finn,

Am 05.06.2021 um 11:31 schrieb Finn Thain:
>>>> If we have Kconfig symbols for 'single platform only', and
>>>> 'multi-platform ISA use', that might be shorter to write and easier
>>>> to understand. Geert?
>>>
>>> It would be nice to have that automatically, like with the current
>>> MULTI_ISA define (and all the MACH_* in
>>> arch/m68k/include/asm/setup.h). Perhaps we should extend kconfig
>>> syntax to define a group of related symbols, and to automatically
>>> generate CONFIG_FOO_MULTI or CONFIG_FOO_SINGLE (and even
>>> CONFIG_BAR_ONLY?) symbols?
>>
>> I take it this is not supported by our current Kconfig syntax?
>>
>
> That may be because CPP hacking is seen as a competitive sport in some
> circles.

Good one.

>
>>> group ISA
>>>      item ATARI_ROM_ISA
>>>      item AMIGA_PCMCIA
>>>      item Q40
>>>
>>> => CONFIG_ISA_MULTI or CONFIG_ISA_SINGLE (+ e.g. ATARI_ROM_ISA_ONLY
>>>    if appropriate).
>>>
>
> Since the items may be bools or tristates, it not clear what type the
> group has.

All three are of type bool.

>
> Anyway, I see that we can already write this:
>
> #define IS_MULTI(a,b) __or(IS_ENABLED(a), IS_ENABLED(b))
>
> So maybe we just need an exclusive-OR macro to go with the other operators
> defined in include/linux/kconfig.h? Then we could write this:
>
> #define IS_SINGLE(a,b) __xor(IS_ENABLED(a), IS_ENABLED(b))
>
> But these only work for a 2-way group. Extending them to N-way groups is
> beyond my CPP abilities. It probably requires N-way __or() and __xor()...

I'll pass on this one for now ...

Cheers,

	Michael


