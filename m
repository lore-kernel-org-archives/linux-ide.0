Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2805AC4743F
	for <linux-ide@archiver.kernel.org>; Mon,  7 Jun 2021 08:41:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0903660233
	for <linux-ide@archiver.kernel.org>; Mon,  7 Jun 2021 08:41:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230313AbhFGImx (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 7 Jun 2021 04:42:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230294AbhFGImw (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 7 Jun 2021 04:42:52 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7F6BC061766;
        Mon,  7 Jun 2021 01:40:50 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id u18so12533916pfk.11;
        Mon, 07 Jun 2021 01:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=kzFRbVGO2L5ePiyZKBuGEV1XT9yCRQ2MpZfjvLu8pVM=;
        b=ILbrIayscAWwdkR2q6tooIHVeZ5I6Al53SBKpV17oEDtlpcM2roBWCwFKQN2Uw/AGi
         hl57VKrAbxt0R6DCltBpkIzEVj1zMJUXmGO3PKl2cjWnpGpSYoXGClRZiktvK7awTS08
         3CkVPm6LsQcVA/+YbaKeD7Y3a1/yfwuJJ66AXZutwT+9pb5DhXHOthPnAiWwpzcZxgys
         UeHt27SADkeol/01ebtOpxc8rOzQJvBvHB2w+DyxurnV+mjEfeIQvezfywdIBuC6QoAf
         vI64KdkbW1EekQsg8j9Mu2Hf0i8GqEC8ZRJ2SXv8fwfZy/apEEohx8vPJUN54NPcU8TI
         4xtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=kzFRbVGO2L5ePiyZKBuGEV1XT9yCRQ2MpZfjvLu8pVM=;
        b=Vum5Pw8je5cIt/hL88A4fb3CPnD88B3cMtHFkyOvuS2Rq2X+nL2lAZsUqWJyesfmlO
         s6Bovr2icR13UpNY2mZ/f5VlgNYX9CAKr0jbTkmDQj6XwIlKMEYaMvuunITECyyVssX8
         TclXJRmVLjtgucP/RS8zDxrDrp+53P1qn50ZTsErmA/ADBSC1amEb02tHeIKdm7dZTlc
         DApRZMBMEmiip8iEC/abpGG1ap3U+UQ7HwhI2Dl7CUtlSg01cbfOObl4Xx06NfDuOmep
         ZOwgDybM7eb+iem50e/M5ndytNCpTOzeAROV81HfMv7OjjHGT12Eo8zHj8nb0Z3dFAor
         4HFg==
X-Gm-Message-State: AOAM530I4pE9Js2222TM2+SWOAbKahpJ4LseHzSpqQis6XcO2e50mkeW
        pDK5MA60Xng04BJHsKkFsvg=
X-Google-Smtp-Source: ABdhPJw81wdYf3Z/c5HlL9TFqShhuUp2XP+aULT1vSReinXyOP3+yRjLwnyUFRZvqQKQOamFPgD3Mw==
X-Received: by 2002:a63:464b:: with SMTP id v11mr6466745pgk.156.1623055250441;
        Mon, 07 Jun 2021 01:40:50 -0700 (PDT)
Received: from [10.1.1.25] (222-152-189-137-fibre.sparkbb.co.nz. [222.152.189.137])
        by smtp.gmail.com with ESMTPSA id e6sm12350586pjl.3.2021.06.07.01.40.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Jun 2021 01:40:50 -0700 (PDT)
Subject: Re: [PATCH RFC 2/2] net/8390: apne.c - add 100 Mbit support to apne.c
 driver
To:     Geert Uytterhoeven <geert@linux-m68k.org>
References: <20210605060447.GA18461@allandria.com>
 <1622958877-2026-1-git-send-email-schmitzmic@gmail.com>
 <1622958877-2026-3-git-send-email-schmitzmic@gmail.com>
 <CAMuHMdXEs874y3nBjVNt8TQP-AMLTRMFgh+1wMt2xyJP3W_+Dg@mail.gmail.com>
Cc:     Linux/m68k <linux-m68k@vger.kernel.org>, linux-ide@vger.kernel.org,
        Finn Thain <fthain@linux-m68k.org>, ALeX Kazik <alex@kazik.de>
From:   Michael Schmitz <schmitzmic@gmail.com>
Message-ID: <d6268e39-295d-f9a4-862c-738803168f03@gmail.com>
Date:   Mon, 7 Jun 2021 20:40:45 +1200
User-Agent: Mozilla/5.0 (X11; Linux ppc; rv:45.0) Gecko/20100101
 Icedove/45.4.0
MIME-Version: 1.0
In-Reply-To: <CAMuHMdXEs874y3nBjVNt8TQP-AMLTRMFgh+1wMt2xyJP3W_+Dg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Hi Geert,

Am 07.06.2021 um 20:08 schrieb Geert Uytterhoeven:
> Hi Michael,
>
> On Sun, Jun 6, 2021 at 7:54 AM Michael Schmitz <schmitzmic@gmail.com> wrote:
>> Add Kconfig option, module parameter and PCMCIA reset code
>> required to support 100 Mbit PCMCIA ethernet cards on Amiga.
>>
>> 10 Mbit and 100 Mbit mode are supported by the same module.
>> A module parameter switches Amiga ISA IO accessors to word
>> access by changing isa_type at runtime. Additional code to
>> reset the PCMCIA hardware is also added to the driver probe.
>>
>> Patch modified after patch "[PATCH RFC net-next] Amiga PCMCIA
>> 100 MBit card support" submitted to netdev 2018/09/16 by Alex
>> Kazik <alex@kazik.de>.
>>
>> Signed-off-by: Michael Schmitz <schmitzmic@gmail.com>
>
> Thanks for your patch!
>
>> --- a/drivers/net/ethernet/8390/Kconfig
>> +++ b/drivers/net/ethernet/8390/Kconfig
>> @@ -143,6 +143,19 @@ config APNE
>>           To compile this driver as a module, choose M here: the module
>>           will be called apne.
>>
>> +if APNE
>
> Please use "depends on APNE" instead of an if/endif block, as there's
> only a single symbol to cover.

True - I had copied that straight from Alex' patch ..

>
>> +config APNE100MBIT
>> +       bool "PCMCIA NE2000 100MBit support"
>> +       default n
>> +       ---help---
>> +         This changes the driver to support 10/100Mbit cards (e.g. Netgear
>> +         FA411, CNet Singlepoint). 10 MBit cards and 100 MBit cards are
>> +         supported by the same driver.
>> +
>> +         To activate 100 Mbit support at runtime, use the apne100 module
>> +         parameter.
>
> Trailing space.

And ---help--- did confuse kbuild, as I found out.

>> +endif
>> +
>>  config PCMCIA_PCNET
>>         tristate "NE2000 compatible PCMCIA support"
>>         depends on PCMCIA
>> diff --git a/drivers/net/ethernet/8390/apne.c b/drivers/net/ethernet/8390/apne.c
>> index fe6c834..9648e45 100644
>> --- a/drivers/net/ethernet/8390/apne.c
>> +++ b/drivers/net/ethernet/8390/apne.c
>> @@ -120,6 +120,10 @@ static u32 apne_msg_enable;
>>  module_param_named(msg_enable, apne_msg_enable, uint, 0444);
>>  MODULE_PARM_DESC(msg_enable, "Debug message level (see linux/netdevice.h for bitmap)");
>>
>> +static u32 apne_100_mbit;
>> +module_param_named(apne_100_mbit, uint, 0);
>> +MODULE_PARM_DESC(apne_100_mbit, "Enable 100 Mbit support");
>
> Shouldn't this depend on CONFIG_APNE100MBIT, too?
> Perhaps we shouldn't bother with the config symbol, and include this
> unconditionally?

At least the parameter should not hurt - this is entirely untested so 
I'd hate to break APNE by including the io_mm.h changes unconditionally.

>> +
>>  struct net_device * __init apne_probe(int unit)
>>  {
>>         struct net_device *dev;
>> @@ -139,6 +143,9 @@ struct net_device * __init apne_probe(int unit)
>>         if ( !(AMIGAHW_PRESENT(PCMCIA)) )
>>                 return ERR_PTR(-ENODEV);
>>
>> +        if (apne_100_mbit)
>> +                isa_type = ISA_TYPE_AG100;
>
> Likewise.

And that one breaks if 16 bit support isn't always enabled. I'll 
conditionalize it.

> Can we enable this automatically when needed, based on the chip
> detected?

I wondered about that - we'd have to poke the chip with 16 bit IO if 8 
bit IO fails, no idea what side effects that would have.

Maybe retrying the card reset in apne_probe1 again after changing 
isa_type would work, but someone would have to try that and report back.

> + spaces instead of TABs (scripts/checkpatch.pl is your friend).

Thanks, I'll fix that. Got sloppy with checkpatch, sorry.

>
>> +
>>         pr_info("Looking for PCMCIA ethernet card : ");
>>
>>         /* check if a card is inserted */
>> @@ -590,6 +597,16 @@ static int init_pcmcia(void)
>>  #endif
>>         u_long offset;
>>
>> +#ifdef CONFIG_APNE100MBIT
>> +       /* reset card (idea taken from CardReset by Artur Pogoda) */
>> +       {
>> +               u_char  tmp = gayle.intreq;
>> +
>> +               gayle.intreq = 0xff;    mdelay(1);
>> +               gayle.intreq = tmp;     mdelay(300);
>> +       }
>
> Is this safe for all cards?

I _think_ so, but this really is a question for Alex and others involved 
in developing the original patch. (The original patch had that 
conditionalized as well so I might be wrong ...)

I'll send v2 once I've fixed these all up...

Cheers,

	Michael


>> +#endif
>> +
>>         pcmcia_reset();
>>         pcmcia_program_voltage(PCMCIA_0V);
>>         pcmcia_access_speed(PCMCIA_SPEED_250NS);
>
> Gr{oetje,eeting}s,
>
>                         Geert
>
