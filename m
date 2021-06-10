Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E1FDC48BCD
	for <linux-ide@archiver.kernel.org>; Thu, 10 Jun 2021 08:53:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6FC3961376
	for <linux-ide@archiver.kernel.org>; Thu, 10 Jun 2021 08:53:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbhFJIzZ (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 10 Jun 2021 04:55:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbhFJIzZ (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 10 Jun 2021 04:55:25 -0400
Received: from mail-out.m-online.net (mail-out.m-online.net [IPv6:2001:a60:0:28:0:1:25:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 850B4C061574;
        Thu, 10 Jun 2021 01:53:28 -0700 (PDT)
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 4G0yS56NBMz1s2mZ;
        Thu, 10 Jun 2021 10:53:25 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 4G0yS55bC5z1qqkw;
        Thu, 10 Jun 2021 10:53:25 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id ZqR2VLG88lXp; Thu, 10 Jun 2021 10:53:24 +0200 (CEST)
X-Auth-Info: /b0G50zR02lKsGVQpTQz5Pl3Rhj4StAVVTVxx3Be6kG8HWq8UQ7LbEHRddTv/V7K
Received: from igel.home (ppp-46-244-161-203.dynamic.mnet-online.de [46.244.161.203])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Thu, 10 Jun 2021 10:53:24 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
        id 552932C3196; Thu, 10 Jun 2021 10:53:24 +0200 (CEST)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     Michael Schmitz <schmitzmic@gmail.com>
Cc:     linux-m68k@vger.kernel.org, geert@linux-m68k.org,
        linux-ide@vger.kernel.org, fthain@linux-m68k.org, alex@kazik.de
Subject: Re: [PATCH v1 1/2] m68k: io_mm.h - add APNE 100 MBit support
References: <1622958877-2026-1-git-send-email-schmitzmic@gmail.com>
        <1623224214-4836-1-git-send-email-schmitzmic@gmail.com>
        <1623224214-4836-2-git-send-email-schmitzmic@gmail.com>
        <87zgvzzcp6.fsf@igel.home>
        <e3643beb-7d61-e39f-83ca-f44a927b69db@gmail.com>
X-Yow:  Hello.  I know the divorce rate among unmarried Catholic
 Alaskan females!!
Date:   Thu, 10 Jun 2021 10:53:24 +0200
In-Reply-To: <e3643beb-7d61-e39f-83ca-f44a927b69db@gmail.com> (Michael
        Schmitz's message of "Thu, 10 Jun 2021 09:54:13 +1200")
Message-ID: <87eedaje2j.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On Jun 10 2021, Michael Schmitz wrote:

> Hi Andreas,
>
> On 9/06/21 8:04 pm, Andreas Schwab wrote:
>> On Jun 09 2021, Michael Schmitz wrote:
>>
>>> @@ -136,6 +141,9 @@ static inline u8 __iomem *isa_itb(unsigned long addr)
>>>       case ISA_TYPE_Q40: return (u8 __iomem *)Q40_ISA_IO_B(addr);
>>>   #endif
>>>   #ifdef CONFIG_AMIGA_PCMCIA
>>> +#ifdef CONFIG_APNE100MBIT
>>> +    case ISA_TYPE_AG16: fallthrough;
>>> +#endif
>>>       case ISA_TYPE_AG: return (u8 __iomem *)AG_ISA_IO_B(addr);
>> Is the fallthrough annotation really needed?
>
> Just to shut up compiler warnings, and even that I haven't seen myself.

If there is no warning, there is nothing to shut up.

> In this particular case, there can be no doubt that the fallthrough is
> intentional, so on balance, I'll remove those annotations as well 
> (unless Finn strongly objects?).

There is no fallthrough, because there is no code.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
