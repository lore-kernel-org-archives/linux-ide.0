Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B22CCC4708F
	for <linux-ide@archiver.kernel.org>; Wed,  2 Jun 2021 08:21:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F542613C1
	for <linux-ide@archiver.kernel.org>; Wed,  2 Jun 2021 08:21:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232515AbhFBIW5 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 2 Jun 2021 04:22:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230159AbhFBIW5 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 2 Jun 2021 04:22:57 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05E00C061574;
        Wed,  2 Jun 2021 01:21:14 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id 29so1595233pgu.11;
        Wed, 02 Jun 2021 01:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=lEiTywalRonXQc45peaiVDdm+S5RZsw/xP/8Ua5mphw=;
        b=oTITAu8TnvyFXNdVApgo3FZriQnAU1NesNpwR5pO15pFWTTMWlOmJkKgbZ35mwVnyK
         I9P/X3j5RiHAEkla52W3PZ6cV3Xx23r2Jypks5jn7hYmSTJMdnv1EY/Sfd0PeAUFNZDL
         cWP3zZyyFKqcc4a4mS3nsmxE9pXP3Wxj7qf86LaC0BCgUi1CjWqxrPj79X1q6N8pLFdr
         7jUw3y4BDPjKcwD0Jv5fVXsahteMu07+FlYy9BlkeCnqAmfidto8MN4v2TpT3BuXfEhw
         sLdli2EhAUgVJi8mfAb3Gn5ebQCle/7fjiC+rSRQoa/2qQLN7vm4jD87vl59i+n+5zAb
         0ovg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=lEiTywalRonXQc45peaiVDdm+S5RZsw/xP/8Ua5mphw=;
        b=QbfOqlzdwIP5m9cNz8Ux8tOx4y8HHshY5uIvuf9vTJrqsHNsRwvc5gArwJ4XwrHdV7
         taL5JAgM7MVP/USRRMSG6JzuELn+JT2UmAb8VRj8op7kLKqloku0bxtPYBOQHDG6+u7z
         Mi6TC9akbUN0Ep9gV7KATdc5vfoNLF6VS08ckt1uhlCz1q/YyDvVNNYbMXJRR3U5SbJA
         ryZY+fwPXk0wWxcYKn4d6wFHvM6g7VDZqBTCPtumlUN6XM3pV2Ad8n3G0esqGANzbQDM
         2BH1PLlI1ydxoHwJnP1M4h9jB88lN7EKVg6cnR0Koh7f/nyYiKZrK9QzSj2ZQ6cPRvMM
         MwvQ==
X-Gm-Message-State: AOAM53344Om8lOYFP6Nn63u1CSqO7mQ4FOuPUCC2o+UNXNpmzuRIMYe2
        RPrxc7ZneyToPdKdFrm/i0TwdCo6prc=
X-Google-Smtp-Source: ABdhPJwdptvGyfWlsqlgsB0WA+Y/9BkAxCTWGkign/hoI6RW3ZRSw+dnhQc06eI4BNXQt2v2Id+QeA==
X-Received: by 2002:a63:5456:: with SMTP id e22mr32461390pgm.15.1622622073542;
        Wed, 02 Jun 2021 01:21:13 -0700 (PDT)
Received: from [10.1.1.25] (222-152-189-137-fibre.sparkbb.co.nz. [222.152.189.137])
        by smtp.gmail.com with ESMTPSA id gw21sm3485349pjb.41.2021.06.02.01.21.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 02 Jun 2021 01:21:13 -0700 (PDT)
Subject: Re: [PATCH RFC 2/2] m68k: setup_mm.c: set isa_sex for Atari if
 ATARI_ROM_ISA not used
To:     Geert Uytterhoeven <geert@linux-m68k.org>
References: <CAMuHMdUskb3oicq8Kbf6MY_4mn4-Y1pJ-om4fny7k48gndscgg@mail.gmail.com>
 <1622611267-15825-1-git-send-email-schmitzmic@gmail.com>
 <1622611267-15825-3-git-send-email-schmitzmic@gmail.com>
 <CAMuHMdWhdSVCktaVZY+XHeyfeP8uw-RAcOWe--HsBn9Qf5_NOQ@mail.gmail.com>
Cc:     Linux/m68k <linux-m68k@vger.kernel.org>, linux-ide@vger.kernel.org,
        fthain@linux-m68k.org
From:   Michael Schmitz <schmitzmic@gmail.com>
Message-ID: <ea80060f-983b-8adb-93f9-e2b84ea5f4b5@gmail.com>
Date:   Wed, 2 Jun 2021 20:21:08 +1200
User-Agent: Mozilla/5.0 (X11; Linux ppc; rv:45.0) Gecko/20100101
 Icedove/45.4.0
MIME-Version: 1.0
In-Reply-To: <CAMuHMdWhdSVCktaVZY+XHeyfeP8uw-RAcOWe--HsBn9Qf5_NOQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Hi Geert,

Am 02.06.2021 um 19:09 schrieb Geert Uytterhoeven:
> Hi Michael,
>
> On Wed, Jun 2, 2021 at 7:21 AM Michael Schmitz <schmitzmic@gmail.com> wrote:
>> For multiplatform kernels where CONFIG_ATARI_ROM_ISA is not set,
>> at least isa_sex must be set correctly to allow for correct I/O
>> primitive selection in shared drivers.
>>
>> Signed-off-by: Michael Schmitz <schmitzmic@gmail.com>
>
> Thanks for your patch!
>
>
>> --- a/arch/m68k/kernel/setup_mm.c
>> +++ b/arch/m68k/kernel/setup_mm.c
>> @@ -386,6 +386,10 @@ void __init setup_arch(char **cmdline_p)
>>                 isa_type = ISA_TYPE_ENEC;
>>                 isa_sex = 0;
>>         }
>> +#else
>> +       if (MACH_IS_ATARI) {
>> +               isa_sex = 0;
>
> I find it strange that you set isa_sex, but not isa_type?

Yes, as I said this is only to ensure isa_sex has the correct value (0) 
so isa_readw() resolves to in_le16() for the Atari IDE driver after the 
change at the end of the first patch. Might have been better to rather say

int isa_sex=0;

at the start of setup_mm.c ... or rely on that variable being 
initialized as zero anyway.

> However, this is inside the CONFIG_ISA && MULTI_ISA block, so
> what kind of ISA does this correspond to?

No ISA at all in that case, but since we have to route all readw() calls 
through isa_readw() for the sake of generality if we want to support Q40 
ISA and Atari MMIO in the same kernel image, we need to make sure 
isa_readw() does the right thing on Atari if CONFIG_ISA is set.

I know io_mm.h says it's about various ISA bridges, but as I found out, 
drivers using only MMIO are also affected by these definitions.

'Maze' does not begin to describe it, 'mess' might be getting closer, 
but I can't see how we would avoid use of definitions in io_mm.h by 
non-ISA drivers.

Cheers,

	Michael

>
>> +       }
>>  #endif
>>  #endif
>
> Gr{oetje,eeting}s,
>
>                         Geert
>
