Return-Path: <SRS0=oJiQ=UY=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FFA5C4646C
	for <linux-ide@archiver.kernel.org>; Tue, 25 Jun 2019 03:47:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA8F320656
	for <linux-ide@archiver.kernel.org>; Tue, 25 Jun 2019 03:47:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ktPNxWkk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726880AbfFYDrT (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 24 Jun 2019 23:47:19 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:34009 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726362AbfFYDrS (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 24 Jun 2019 23:47:18 -0400
Received: by mail-pg1-f195.google.com with SMTP id p10so8227089pgn.1;
        Mon, 24 Jun 2019 20:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=NiZVhGwRz5VRLPNlmmZ3kIFmHvBhGLuhfjGn1jwNnEc=;
        b=ktPNxWkky2Y9uVc0ukmDDbWNxwDgnBU0rjO8I+VIYDErcEqToddcdSIKBsSnITyOHx
         qNFEMuJaN1l1E62IsKqaqh3CNdt3kHRaWb+6DVUkYP39jBqG3pd8PNEtwmOMOiWQPaYi
         dm8wqQq12RHcOHlInwM/LNjhEW8OTr/TvVTJA5vZOzPj2nXY5R0rsqmfP32CuhEtAOaI
         Vpk1XgnAGKkTglhofAD7h+PV3qQmeSGI4XfyDaQXJom4riCje/2Ffwyoa1UgvVIS4wfT
         QNND3JbXDVcLgRtqWbyrLfSJ+XnXDi5v/nAFsUZ59vdhT32OgmTfzA0j3RDSoedtHgtl
         7h+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=NiZVhGwRz5VRLPNlmmZ3kIFmHvBhGLuhfjGn1jwNnEc=;
        b=hJ6mZyQarUuiOzlZhE3SvQz8bwIu1ml9DrUg3JuR2Sq6o6MsQRaGv/qTDvoIFMwcxA
         N6LxxiX3qxaBj1O49FxofYbwxuDx33d/+ilrFNI+0idaqiZWAkxVZZal8L15TORbbxSC
         /6hE6un8keh/QBP/LgUXJrvbt53ftSXO88AUqAj13DffEoMl2qb8YS46te8fM4+KFMCW
         QCB2BgtReQNWSN2T/3nTw6ilg23HSN0sFJx4jFL1RjoVKR9yM2m3hbjuEUvaDZ9JX8yF
         SxqFiq2iL4LqqoBdMamx2Pt5YdTv8CcP37yPn9xLw9OTCRxcBHb2C1AdJaAgeBy5aSpf
         xdcA==
X-Gm-Message-State: APjAAAVbxAJ7t5PpsJCRydw52HLGx7pnYOuBiSaNofcsfKWzNrPMC95e
        pImLmAcYaeUI0cdz2JE1dOLSsRHp
X-Google-Smtp-Source: APXvYqzq8im6XVGNJHnhX2ZwvGKwwyX5mB3hmSIuQuD1CuYfc417sKEjS8ZP6hBPe9xprP/45T64TQ==
X-Received: by 2002:a63:9d43:: with SMTP id i64mr33937254pgd.404.1561434438147;
        Mon, 24 Jun 2019 20:47:18 -0700 (PDT)
Received: from [192.168.1.101] (122-58-182-39-adsl.sparkbb.co.nz. [122.58.182.39])
        by smtp.gmail.com with ESMTPSA id u10sm9974371pfh.54.2019.06.24.20.47.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Jun 2019 20:47:17 -0700 (PDT)
Subject: Re: [PATCH RFC 1/2] m68k/atari: add platform device for Falcon IDE
 port
To:     Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        linux-m68k@vger.kernel.org, linux-ide@vger.kernel.org
References: <CAMuHMdUcUqWWGNngNV3EpEq5wSsf5qTVeZvTB9gX1e26Jrq1xA@mail.gmail.com>
 <1561063642-13900-2-git-send-email-schmitzmic@gmail.com>
 <f820e822-deae-87a3-cb05-0ca2ba4608f4@cogentembedded.com>
Cc:     geert@linux-m68k.org, b.zolnierkie@samsung.com
From:   Michael Schmitz <schmitzmic@gmail.com>
Message-ID: <c54aee86-7762-6d65-5430-c6a4fc59607a@gmail.com>
Date:   Tue, 25 Jun 2019 15:47:12 +1200
User-Agent: Mozilla/5.0 (X11; Linux ppc; rv:45.0) Gecko/20100101
 Icedove/45.4.0
MIME-Version: 1.0
In-Reply-To: <f820e822-deae-87a3-cb05-0ca2ba4608f4@cogentembedded.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Sergei,

Am 23.06.2019 um 21:06 schrieb Sergei Shtylyov:
> Hello!
>
> On 20.06.2019 23:47, Michael Schmitz wrote:
>
>> Autoloading of Falcon IDE driver modules requires converting
>> these drivers to platform drivers.
>>
>> Add platform device for Falcon IDE interface in Atari platform
>> setup code in preparation for this.
>>
>> Add Falcon IDE base address in Atari hardware address header.
>>
>> Signed-off-by: Michael Schmitz <schmitzmic@gmail.com>
>> ---
>>   arch/m68k/atari/config.c        |   20 ++++++++++++++++++++
>>   arch/m68k/include/asm/atarihw.h |    6 ++++++
>>   2 files changed, 26 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/m68k/atari/config.c b/arch/m68k/atari/config.c
>> index ca8469e..2d7133a 100644
>> --- a/arch/m68k/atari/config.c
>> +++ b/arch/m68k/atari/config.c
>> @@ -896,6 +896,21 @@ static void isp1160_delay(struct device *dev, int
>> delay)
>>   };
>>   #endif
>>   +#if IS_ENABLED(CONFIG_PATA_FALCON)
>> +static const struct resource atari_falconide_rsrc[] __initconst = {
>> +    {
>> +        .flags = IORESOURCE_MEM,
>> +        .start = FALCON_IDE_BASE,
>> +        .end   = FALCON_IDE_BASE+0x40,
>
>    You probably forgot to subtract 1 here...

Well spotted. That's inconsequential however, as there's no overlap with 
other IO adresses used in that region, and everything has been mapped 
into kernel space by early arch startup.

Will fix in the next iteration.

Cheers,

	Michael

>
>> +    },
>> +    {
>> +        .flags = IORESOURCE_IRQ,
>> +        .start = IRQ_MFP_FSCSI,
>> +        .end   = IRQ_MFP_FSCSI,
>> +    },
>> +};
>> +#endif
>> +
>>   int __init atari_platform_init(void)
>>   {
>>       int rv = 0;
> [...]
>
> MBR, Sergei
