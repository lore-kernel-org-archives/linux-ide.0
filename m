Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6935C83F10
	for <linux-ide@archiver.kernel.org>; Sat, 26 Aug 2023 01:56:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbjHZBzm (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 25 Aug 2023 21:55:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231717AbjHZBze (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 25 Aug 2023 21:55:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE30F2106;
        Fri, 25 Aug 2023 18:55:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7ED5160B3D;
        Sat, 26 Aug 2023 01:55:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2606C433C8;
        Sat, 26 Aug 2023 01:55:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693014930;
        bh=xNkfFsEWnnKS4Tf3YPvXVBsoglWtvEBIxtTm2YeWgnk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=uso8LMo9pYRJVGFEzA+2w+S6DWsuxdMTpUIGcCIx9OCiuQ0lIKUyy2KVLEZDgq8mW
         PF3YFOeSQhRI81YUd3XKMKaXjpMVCnxL8KgoPuoBfF05kgB17inIEfE7tlFvCfn2hI
         XGIuhruK/JQET+xtTflL1hbs9z5FwtOovUCjA87EA/pF2PGYf90IK6dQmGNJ+TdMgB
         SkJDfk2lS1SmyNMrsNRdm+3SM8uT3MhBT/fOwLPcgnpV2vYJgTJf+QSHcoAt+b+YpM
         NLN1JC1pzOqPLN2OV7oU5A7eH1ATC0e6oep2dzha1ZbpZMCdRu5O0qV/hc7FcK5EUf
         AReemKHXb8hJQ==
Message-ID: <cc10a446-bcda-65af-9f25-6718753a1c32@kernel.org>
Date:   Sat, 26 Aug 2023 10:55:28 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v5 2/2] ata: pata_falcon: add data_swab option to
 byte-swap disk data
Content-Language: en-US
To:     Michael Schmitz <schmitzmic@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     s.shtylyov@omp.ru, linux-ide@vger.kernel.org,
        linux-m68k@vger.kernel.org, will@sowerbutts.com, rz@linux-m68k.org,
        Finn Thain <fthain@linux-m68k.org>
References: <20230825011335.25808-1-schmitzmic@gmail.com>
 <20230825011335.25808-3-schmitzmic@gmail.com>
 <CAMuHMdUhw-mvGXRRimfp1SAMaRzOfQuO=k81LaZbXuNPV0igQQ@mail.gmail.com>
 <f02aeddc-eb6e-9de3-5c92-959271b1b6c5@gmail.com>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <f02aeddc-eb6e-9de3-5c92-959271b1b6c5@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 8/26/23 09:44, Michael Schmitz wrote:
> Hi Geert,
> 
> Am 25.08.23 um 19:46 schrieb Geert Uytterhoeven:
>> Hi Michael,
>>
>> On Fri, Aug 25, 2023 at 3:13 AM Michael Schmitz <schmitzmic@gmail.com> wrote:
>>> Some users of pata_falcon on Q40 have IDE disks in default
>>> IDE little endian byte order, whereas legacy disks use
>>> host-native big-endian byte order as on the Atari Falcon.
>>>
>>> Add module parameter 'data_swab' to allow connecting drives
>>> with non-native data byte order. Drives selected by the
>>> data_swap bit mask will have their user data byte-swapped to
>>> host byte order, i.e. 'pata_falcon.data_swab=2' will byte-swap
>>> all user data on drive B, leaving data on drive A in native
>>> byte order. On Q40, drives on a second IDE interface may be
>>> added to the bit mask as bits 2 and 3.
>>>
>>> Default setting is no byte swapping, i.e. compatibility with
>>> the native Falcon or Q40 operating system disk format.
>>>
>>> Cc: William R Sowerbutts <will@sowerbutts.com>
>>> Cc: Finn Thain <fthain@linux-m68k.org>
>>> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
>>> Tested-by: William R Sowerbutts <will@sowerbutts.com>
>>> Signed-off-by: Michael Schmitz <schmitzmic@gmail.com>
>>> Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
>>> Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
>>>
>>> ---
>>>
>>> Changes since v4:
>>>
>>> Damien Le Moal:
>>> - spell out bitmask shift calculation
>> Thanks for the update!
>>
>> Sorry to bother you again...
>>
>>> --- a/drivers/ata/pata_falcon.c
>>> +++ b/drivers/ata/pata_falcon.c
>>> @@ -124,7 +129,7 @@ static int __init pata_falcon_init_one(struct platform_device *pdev)
>>>         struct ata_host *host;
>>>         struct ata_port *ap;
>>>         void __iomem *base, *ctl_base;
>>> -       int irq = 0, io_offset = 1, reg_shift = 2; /* Falcon defaults */
>>> +       int irq = 0, io_offset = 1, reg_shift = 2, mask_shift; /* Falcon defaults */
>> The comment does not apply to the mask_shift variable, unless you
>> pre-initialize it to 0...
> 
> It does not apply to mask_shift even then - '0' is the default for the
> first Q40 ISA adapter also, not just for Falcon.
> 
> I'll move mask_shift to its own line so the comment can be correct.
> 
>>
>>>         dev_info(&pdev->dev, "Atari Falcon and Q40/Q60 PATA controller\n");
>>>
>>> @@ -194,6 +199,12 @@ static int __init pata_falcon_init_one(struct platform_device *pdev)
>>>         ata_port_desc(ap, "cmd %px ctl %px data %px",
>>>                       base, ctl_base, ap->ioaddr.data_addr);
>>>
>>> +       if (pdev->id > 0)
>>> +               mask_shift = 2;
>>> +       else
>>> +               mask_shift = 0;
>> ... and drop the else.
> 
> Damien did seem quite partial to that one, so I'll leave it.

I am OK with mask_shift initialized to 0 when declared.
So whichever you prefer is fine.
What I do not like is the use of "?" instead of the easier to read plain "if" :)

> 
> Cheers,
> 
>     Michael
> 
>>
>>> +       ap->private_data = (void *)(uintptr_t)(pata_falcon_swap_mask >> mask_shift);
>>> +
>>>         irq_res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
>>>         if (irq_res && irq_res->start > 0) {
>>>                 irq = irq_res->start;
>> Gr{oetje,eeting}s,
>>
>>                         Geert
>>
> 

-- 
Damien Le Moal
Western Digital Research

