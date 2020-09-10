Return-Path: <SRS0=Rbkm=CT=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C85F7C433E2
	for <linux-ide@archiver.kernel.org>; Thu, 10 Sep 2020 03:45:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7FDC620795
	for <linux-ide@archiver.kernel.org>; Thu, 10 Sep 2020 03:45:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RfgROd1O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727010AbgIJDpW (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 9 Sep 2020 23:45:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726714AbgIJDpI (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 9 Sep 2020 23:45:08 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8029C061756;
        Wed,  9 Sep 2020 20:45:07 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id c196so3987176pfc.0;
        Wed, 09 Sep 2020 20:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=Qln2qphFzlLEQb+SQbJE9E/bmIRsneAkRPIjgB/WVNA=;
        b=RfgROd1OSpMuN3g5IzZktvkh+BYMT4vk/w2Xo1Qhi7nHkfi+fk13JL/uRc3SibhEZx
         sefB3+FB3kyecPlunxr2ACOjiE9DoUBEyJMWSVPuA2m9bIzuE8tZC3RverMSKEC964GS
         /EyIvxG8JNrjKyh5JWoR+EUZofBINMfTwfmnaxmEy6MX4WVd0ESNBv8Ui2y3B8ovdwIe
         oD0I4fqrv1nkpyTnNQOY8sxPAEyqy9xuCaFBLRQoBAKXMfeaxb2EE93BjoR6N+UJhZ6d
         bSCeTa91uwSMxqBXl5bqbOjQiIcr24PrfpKWhVfJzWPkfCLNGsRKpYPjc8g3CkWZ7E/g
         BOow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=Qln2qphFzlLEQb+SQbJE9E/bmIRsneAkRPIjgB/WVNA=;
        b=D2XH4iH9RQNpeaR0FGaA/ZUdMI5F4thsLMtuiL2gUIXnsI5r+jL15EwhJx02V9hc0g
         bihG1CSli4NoRiOu7dwH49RyHJHuf1yjK5B+Pi6meruSyfI50oGpAMqFzOmMgPUnnt38
         ELmfXpivFOLG6ckS2JiZ9Yn2TRmpPSYNB0P6JRZoumZntQ0acJWJKn1X+R7kGvmx7zCc
         ArcaLwg0sgi5xt6tYQHwszDrBL+PIgdcozrB73yWOHqD93aWoC3kcH2blgYprt0JNG7n
         7DII2AsWE2S9rxgwQ/IzGo86yuINx0CorHZiWyq2JoLAmAW+wGo7PV3MB0RcUgNcIBr2
         dVow==
X-Gm-Message-State: AOAM532JQZguj4yJETUofpf+QU1hxFYU+rvujEfkggdMCGry3n+gtBRo
        5yT0RcOgG2a6yhJbRQFYiwQ+O2OwJXY=
X-Google-Smtp-Source: ABdhPJy3kxrwrumJxj2AKyowWo9NXZTcx7xj4LACHzt8l+q6BRoVXmcWVBpuG4PMjxGnWcASVjsAKg==
X-Received: by 2002:a62:5586:0:b029:13e:d13d:a12c with SMTP id j128-20020a6255860000b029013ed13da12cmr3419700pfb.20.1599709507192;
        Wed, 09 Sep 2020 20:45:07 -0700 (PDT)
Received: from [192.168.1.101] (122-58-181-132-adsl.sparkbb.co.nz. [122.58.181.132])
        by smtp.gmail.com with ESMTPSA id y13sm477789pgs.53.2020.09.09.20.45.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Sep 2020 20:45:06 -0700 (PDT)
Subject: Re: [PATCH] ide/macide: Convert Mac IDE driver to platform driver
To:     Finn Thain <fthain@telegraphics.com.au>,
        Geert Uytterhoeven <geert@linux-m68k.org>
References: <00ee44fe6ecdce1c783c3cc3b1b9a62b498dcdb2.1597736545.git.fthain@telegraphics.com.au>
 <CAMuHMdWAi6+75Mq0U8x7Ut6viHvF7XEZAcYnxq=jJmtJyAX8pw@mail.gmail.com>
 <alpine.LNX.2.23.453.2009100920001.8@nippy.intranet>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Joshua Thompson <funaho@jurai.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-ide@vger.kernel.org
From:   Michael Schmitz <schmitzmic@gmail.com>
Message-ID: <3f57aae2-266f-be8e-928f-e5849cffcf26@gmail.com>
Date:   Thu, 10 Sep 2020 15:44:59 +1200
User-Agent: Mozilla/5.0 (X11; Linux ppc; rv:45.0) Gecko/20100101
 Icedove/45.4.0
MIME-Version: 1.0
In-Reply-To: <alpine.LNX.2.23.453.2009100920001.8@nippy.intranet>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Hi Finn,

Am 10.09.2020 um 12:23 schrieb Finn Thain:
>>> +       return 0;
>>> +
>>> +release_mem:
>>> +       release_mem_region(mem->start, resource_size(mem));
>>
>> Not needed, as you used devm_*() for allocation.
>>
>
> OK, I'll remove this. I put it there after I looked at falconide.c and
> wondered whether the automatic release would take place after both init
> failure and exit (or just exit). I see now that pata_gayle.c does it
> differently.

pata_gayle.c has probably seen more testing (in the platform 
environment), so I'd go with what's done there.

Cheers,

	Michael

