Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AB7AC47094
	for <linux-ide@archiver.kernel.org>; Tue,  8 Jun 2021 03:11:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E3F55600D1
	for <linux-ide@archiver.kernel.org>; Tue,  8 Jun 2021 03:11:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230311AbhFHDNj (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 7 Jun 2021 23:13:39 -0400
Received: from mail-pg1-f176.google.com ([209.85.215.176]:40912 "EHLO
        mail-pg1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230237AbhFHDNj (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 7 Jun 2021 23:13:39 -0400
Received: by mail-pg1-f176.google.com with SMTP id j12so15397505pgh.7;
        Mon, 07 Jun 2021 20:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=u1R7aBY6kgJGlxwF823dLZ7v+i5yLHW2d2Nw3Kdyci8=;
        b=WNjmNlRSw2lc7h0d8pYY5fhaOHjwOwpVi82glyyxD6mJOU263dilRqmz1mT/B7v8NO
         cSbc7KFgt0CUhNRbXvgWtHhIpZjIYqUOl9zfRt0ObSmW0IMUqRS11YWrb75N0T43kKHl
         LZYGtDhS1L8h1Ebo59X6KggKu4UcQDXij1nNBStkMiFNjpQcmvQoh9LSLhGR3mekvIXm
         22xCdAvtv+KLxbYpwLb1stPHM4cRhnko4eGYnY0gc5zjP2g9k3djY5jJt3w+cZlW+H0I
         cyEGYYTHxMuUU5ztSzA8KQ6fbt/ck42uRRAvdpcUXOZFtSHY3xt9RpO1XGDQVITdtqvR
         gl+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=u1R7aBY6kgJGlxwF823dLZ7v+i5yLHW2d2Nw3Kdyci8=;
        b=X9aFDnHJXCItgMPCoFrxvH7thD+mflUR9iyg1VU75C9s+ZUtCeuv0WaRdFptkzui4Q
         0WjrYMZ4+iLNhq5iXQFu2XsPz/5axF51/AwNxpomqd2W61FO6WTrk4BWUIu533u+vC6H
         lWM6oICqLsOAUANYbcEQnxDvxL7GQVLGLLdpvxjpOyFazAVh8hUIVLq7hfsvyxhRkBQd
         oqEtCVD/usXFbXYxgjzJCGr58ZG9MEfZjSU612w0CJADtInmZQwopj52kyXIbxewTP21
         6HBj7H4GujrDRwle3VxA9jcvOqxkfbN4YTLiIEoBYwIK94SHgCQ6Tz++Wq8FboUtAs2B
         rhCw==
X-Gm-Message-State: AOAM530trbGoF33E91mtijXIpQpP9yEjxmkGqsEnEXj6rLzBbmG321/m
        +QwhuU2hrJA6zswnqae5rPd8kGahjh0=
X-Google-Smtp-Source: ABdhPJynb2xD8lZ5CkkliIRTMEsrXn8KXYhXKZ2tPqA0BBarRBNAfXyT7dL1+CN6KBLyhkHfdia/FQ==
X-Received: by 2002:a62:8c55:0:b029:2ea:2165:503d with SMTP id m82-20020a628c550000b02902ea2165503dmr19832010pfd.68.1623121846739;
        Mon, 07 Jun 2021 20:10:46 -0700 (PDT)
Received: from [10.1.1.25] (222-152-189-137-fibre.sparkbb.co.nz. [222.152.189.137])
        by smtp.gmail.com with ESMTPSA id b23sm13108719pjo.26.2021.06.07.20.10.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Jun 2021 20:10:46 -0700 (PDT)
Subject: Re: [PATCH RFC 2/2] net/8390: apne.c - add 100 Mbit support to apne.c
 driver
To:     ALeX Kazik <alex@kazik.de>
References: <20210605060447.GA18461@allandria.com>
 <1622958877-2026-1-git-send-email-schmitzmic@gmail.com>
 <1622958877-2026-3-git-send-email-schmitzmic@gmail.com>
 <CAMuHMdXEs874y3nBjVNt8TQP-AMLTRMFgh+1wMt2xyJP3W_+Dg@mail.gmail.com>
 <d6268e39-295d-f9a4-862c-738803168f03@gmail.com>
 <CAFFuhJp5iu-2o4wYf3XSsCF3VV_T-q8gp08bkPpGBs8Ra_OnKw@mail.gmail.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Linux/m68k <linux-m68k@vger.kernel.org>,
        linux-ide@vger.kernel.org, Finn Thain <fthain@linux-m68k.org>,
        Rolf Anders <rolf.anders@physik.uni-augsburg.de>
From:   Michael Schmitz <schmitzmic@gmail.com>
Message-ID: <99d64fba-4f35-b2d7-ba25-62a47925719e@gmail.com>
Date:   Tue, 8 Jun 2021 15:10:40 +1200
User-Agent: Mozilla/5.0 (X11; Linux ppc; rv:45.0) Gecko/20100101
 Icedove/45.4.0
MIME-Version: 1.0
In-Reply-To: <CAFFuhJp5iu-2o4wYf3XSsCF3VV_T-q8gp08bkPpGBs8Ra_OnKw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Hi Alex,


Am 07.06.2021 um 20:46 schrieb ALeX Kazik:
> Hi all,
>
>> It's been quite a while - can you still try and build/test this change, Alex?
>
> I'm happy to test it again (assuming my Amiga still works, not used
> for a while).
> But I'm waiting until you guys have perfected the patch.

Thanks, I'll keep you in the CC list.
>
>>>> +
>>>>         pr_info("Looking for PCMCIA ethernet card : ");
>>>>
>>>>         /* check if a card is inserted */
>>>> @@ -590,6 +597,16 @@ static int init_pcmcia(void)
>>>>  #endif
>>>>         u_long offset;
>>>>
>>>> +#ifdef CONFIG_APNE100MBIT
>>>> +       /* reset card (idea taken from CardReset by Artur Pogoda) */
>>>> +       {
>>>> +               u_char  tmp = gayle.intreq;
>>>> +
>>>> +               gayle.intreq = 0xff;    mdelay(1);
>>>> +               gayle.intreq = tmp;     mdelay(300);
>>>> +       }
>>>
>>> Is this safe for all cards?
>>
>> I _think_ so, but this really is a question for Alex and others involved
>> in developing the original patch. (The original patch had that
>> conditionalized as well so I might be wrong ...)
>
> My code is based on the patches here: http://www.g-mb.de/pcmcia_e.html
>
> I'm not deep into it, just adapted the patch. And that's why I can't
> tell if the other drivers will work with it always enabled, sorry.

According to that site, the reset is needed for all 100 Mbit cards, and 
in your patch from 2018, you mentioned that this is because the PCMCIA 
reset line isn't connected on these cards. Based on that reading, this 
_should_ be safe for those cards that have a reset line wired as well.

Who could we ask - I guess Rolf Anders was the author of a previous 
patch for the 100 Mbit APNE compatible cards? Not sure I've seen an 
e-mail address for Artur Pogoda?

Cheers,

	Michael




>
> Bye,
> Alex.
>
