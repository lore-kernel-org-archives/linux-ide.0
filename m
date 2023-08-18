Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5C96EE498E
	for <linux-ide@archiver.kernel.org>; Fri, 18 Aug 2023 20:43:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380000AbjHRUmy (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 18 Aug 2023 16:42:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380068AbjHRUmg (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 18 Aug 2023 16:42:36 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A4843C3C;
        Fri, 18 Aug 2023 13:42:35 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1bdbbede5d4so10941095ad.2;
        Fri, 18 Aug 2023 13:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692391355; x=1692996155;
        h=content-transfer-encoding:in-reply-to:mime-version:user-agent:date
         :message-id:from:cc:references:to:subject:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1GmKEA0U2rBuR4wa1AdgfS/vHxzjb8Ofvrom4kvMAXQ=;
        b=azERLQuut1fYBWaLU6p7/KfGtW8SH4timXCckbyWWjPqzh/XmAtMqwyTeYLrO068nP
         0yLHDechEVE8SSpHqk4uYpS6blb5UQOin3ESPltkS+YtITv3/7yGArRb2x4SKUtHFVzs
         KnZbjUmHJ32i8H6intv0s6mVj822WiFMmVO/0VKSsRE1vEQZU8OhTLmKHp47y1SzPjPh
         fkAoQhP6rFuRrdT3QvQBn1FSVGS7oU3VFIc4vs9/wTMaFP7TlsC7LovbSI/AhxZ27iu8
         fLycvcyPkQq0bOWkQNTcWAq19BzgmyC23NGADEiXqqTEJT87oZoeJWH+MkicAgnvWMZ8
         RMuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692391355; x=1692996155;
        h=content-transfer-encoding:in-reply-to:mime-version:user-agent:date
         :message-id:from:cc:references:to:subject:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1GmKEA0U2rBuR4wa1AdgfS/vHxzjb8Ofvrom4kvMAXQ=;
        b=UI53G46oxszFoIn/O7QSXgEKMoLIwd5EEzUe0bt1hxtq+xt//vLoBu71dq8gX5TelS
         4DTRntOySeQfeD54qlhNq5JVPHuW36W4ibvWw0hsXtPIFXFhSlNvgI9jhjshemgV4F/J
         thtjLkeVNRzgBecGs7KAYXiNjqY3hb3QMHgnywmZqpcHf+P36Tx++B1hhY0kLYIe2b2t
         r69PZ+CAqEGltxBy5wZyF/glGpQbg5/P5PBSw2MYULYuXCQEAz743tbiH4eoiAb7Hcdk
         T7OP+UfnymDellQd9Gq1tzF8JYPqaJtKb7wlT3EtJv19GU8SsjIYIgRX/gO0NOh2d4lw
         Snuw==
X-Gm-Message-State: AOJu0YwlMa3BnrhX3AtBAR+KudSccHpUINdZ4nkfDUhHnfK/OvEqyKMp
        fOvzP5Apx2EJHgIx8rtqXxU=
X-Google-Smtp-Source: AGHT+IGOlXiFCUppgBgitWcEzkqyGK4O1QcQYaMNLLUQ/7w1Hs0b22p9WjeLJr9ZH0nFTo3cvDT3fg==
X-Received: by 2002:a17:903:4283:b0:1bc:5e85:9871 with SMTP id ju3-20020a170903428300b001bc5e859871mr305805plb.54.1692391354800;
        Fri, 18 Aug 2023 13:42:34 -0700 (PDT)
Received: from [10.1.1.24] (122-62-141-252-fibre.sparkbb.co.nz. [122.62.141.252])
        by smtp.gmail.com with ESMTPSA id i1-20020a17090332c100b001bf2dcfe352sm2164756plr.234.2023.08.18.13.42.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Aug 2023 13:42:34 -0700 (PDT)
Subject: Re: [PATCH v2 1/3] ata: pata_falcon: fix IO base selection for Q40
To:     Finn Thain <fthain@linux-m68k.org>
References: <20230818071405.28581-1-schmitzmic@gmail.com>
 <20230818071405.28581-2-schmitzmic@gmail.com>
 <5cd777ad-17c4-ce63-c10a-7c379b356fb1@linux-m68k.org>
Cc:     dlemoal@kernel.org, linux-ide@vger.kernel.org,
        linux-m68k@vger.kernel.org, will@sowerbutts.com, rz@linux-m68k.org,
        geert@linux-m68k.org
From:   Michael Schmitz <schmitzmic@gmail.com>
Message-ID: <72eaa406-0ad6-9217-49df-3365ae56a1e2@gmail.com>
Date:   Sat, 19 Aug 2023 08:42:26 +1200
User-Agent: Mozilla/5.0 (X11; Linux ppc; rv:45.0) Gecko/20100101
 Icedove/45.4.0
MIME-Version: 1.0
In-Reply-To: <5cd777ad-17c4-ce63-c10a-7c379b356fb1@linux-m68k.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Hi Finn,

Am 18.08.2023 um 19:52 schrieb Finn Thain:
>
> On Fri, 18 Aug 2023, Michael Schmitz wrote:
>
>> With commit 44b1fbc0f5f3 ("m68k/q40: Replace q40ide driver
>> with pata_falcon and falconide"), the Q40 IDE driver was
>> replaced by pata_falcon.c.
>>
>> Both IO and memory resources were defined for the Q40 IDE
>> platform device, but definition of the IDE register addresses
>> was modeled after the Falcon case, both in use of the memory
>> resources and in including register scale and byte vs. word
>> offset in the address.
>>
>> This was correct for the Falcon case, which does not apply
>> any address translation to the register addresses. In the
>> Q40 case, all of device base address, byte access offset
>> and register scaling is included in the platform specific
>> ISA access translation (in asm/mm_io.h).
>>
>> As a consequence, such address translation gets applied
>> twice, and register addresses are mangled.
>>
>> Use the device base address from the platform IO resource,
>> and use standard register offsets from that base in order
>> to calculate register addresses (the IO address translation
>> will then apply the correct ISA window base and scaling).
>>
>> Encode PIO_OFFSET into IO port addresses for all registers
>> except the data transfer register. Encode the MMIO offset
>> there (pata_falcon_data_xfer() directly uses raw IO with
>> no address translation).
>>
>> Reported-by: William R Sowerbutts <will@sowerbutts.com>
>> Closes: https://lore.kernel.org/r/CAMuHMdUU62jjunJh9cqSqHT87B0H0A4udOOPs=WN7WZKpcagVA@mail.gmail.com
>> Link: https://lore.kernel.org/r/CAMuHMdUU62jjunJh9cqSqHT87B0H0A4udOOPs=WN7WZKpcagVA@mail.gmail.com
>> Fixes: 44b1fbc0f5f3 ("m68k/q40: Replace q40ide driver with pata_falcon and falconide")
>> Cc: Finn Thain <fthain@linux-m68k.org>
>> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
>
> Cc: stable@vger.kernel.org
>
> From Documentation/process/submitting-patches.rst --
> "Note: Attaching a Fixes: tag does not subvert the stable kernel rules
> process nor the requirement to Cc: stable@vger.kernel.org on all stable
> patch candidates... "

OK, I'll add the Cc: back then.

Thanks,

	Michael

>
>> Signed-off-by: Michael Schmitz <schmitzmic@gmail.com>
>>
>> ---
>>
>> Changes from v1:
>>
>> Damien Le Moal:
>> - change patch title
>> - drop stable backport tag
>>
>> Changes from RFC v3:
>>
>> - split off byte swap option into separate patch
>>
>> Geert Uytterhoeven:
>> - review comments
>>
>> Changes from RFC v2:
>> - add driver parameter 'data_swap' as bit mask for drives to swap
>>
>> Changes from RFC v1:
>>
>> Finn Thain:
>> - take care to supply IO address suitable for ioread8/iowrite8
>> - use MMIO address for data transfer
>> ---
>>  drivers/ata/pata_falcon.c | 55 ++++++++++++++++++++++++---------------
>>  1 file changed, 34 insertions(+), 21 deletions(-)
>>
>> diff --git a/drivers/ata/pata_falcon.c b/drivers/ata/pata_falcon.c
>> index 996516e64f13..346259e3bbc8 100644
>> --- a/drivers/ata/pata_falcon.c
>> +++ b/drivers/ata/pata_falcon.c
>> @@ -123,8 +123,8 @@ static int __init pata_falcon_init_one(struct platform_device *pdev)
>>  	struct resource *base_res, *ctl_res, *irq_res;
>>  	struct ata_host *host;
>>  	struct ata_port *ap;
>> -	void __iomem *base;
>> -	int irq = 0;
>> +	void __iomem *base, *ctl_base;
>> +	int irq = 0, io_offset = 1, reg_scale = 4;
>>
>>  	dev_info(&pdev->dev, "Atari Falcon and Q40/Q60 PATA controller\n");
>>
>> @@ -165,26 +165,39 @@ static int __init pata_falcon_init_one(struct platform_device *pdev)
>>  	ap->pio_mask = ATA_PIO4;
>>  	ap->flags |= ATA_FLAG_SLAVE_POSS | ATA_FLAG_NO_IORDY;
>>
>> -	base = (void __iomem *)base_mem_res->start;
>>  	/* N.B. this assumes data_addr will be used for word-sized I/O only */
>> -	ap->ioaddr.data_addr		= base + 0 + 0 * 4;
>> -	ap->ioaddr.error_addr		= base + 1 + 1 * 4;
>> -	ap->ioaddr.feature_addr		= base + 1 + 1 * 4;
>> -	ap->ioaddr.nsect_addr		= base + 1 + 2 * 4;
>> -	ap->ioaddr.lbal_addr		= base + 1 + 3 * 4;
>> -	ap->ioaddr.lbam_addr		= base + 1 + 4 * 4;
>> -	ap->ioaddr.lbah_addr		= base + 1 + 5 * 4;
>> -	ap->ioaddr.device_addr		= base + 1 + 6 * 4;
>> -	ap->ioaddr.status_addr		= base + 1 + 7 * 4;
>> -	ap->ioaddr.command_addr		= base + 1 + 7 * 4;
>> -
>> -	base = (void __iomem *)ctl_mem_res->start;
>> -	ap->ioaddr.altstatus_addr	= base + 1;
>> -	ap->ioaddr.ctl_addr		= base + 1;
>> -
>> -	ata_port_desc(ap, "cmd 0x%lx ctl 0x%lx",
>> -		      (unsigned long)base_mem_res->start,
>> -		      (unsigned long)ctl_mem_res->start);
>> +	ap->ioaddr.data_addr = (void __iomem *)base_mem_res->start;
>> +
>> +	if (base_res) {		/* only Q40 has IO resources */
>> +		io_offset = 0x10000;
>> +		reg_scale = 1;
>> +		base = (void __iomem *)base_res->start;
>> +		ctl_base = (void __iomem *)ctl_res->start;
>> +
>> +		ata_port_desc(ap, "cmd %pa ctl %pa",
>> +			      &base_res->start,
>> +			      &ctl_res->start);
>> +	} else {
>> +		base = (void __iomem *)base_mem_res->start;
>> +		ctl_base = (void __iomem *)ctl_mem_res->start;
>> +
>> +		ata_port_desc(ap, "cmd %pa ctl %pa",
>> +			      &base_mem_res->start,
>> +			      &ctl_mem_res->start);
>> +	}
>> +
>> +	ap->ioaddr.error_addr	= base + io_offset + 1 * reg_scale;
>> +	ap->ioaddr.feature_addr	= base + io_offset + 1 * reg_scale;
>> +	ap->ioaddr.nsect_addr	= base + io_offset + 2 * reg_scale;
>> +	ap->ioaddr.lbal_addr	= base + io_offset + 3 * reg_scale;
>> +	ap->ioaddr.lbam_addr	= base + io_offset + 4 * reg_scale;
>> +	ap->ioaddr.lbah_addr	= base + io_offset + 5 * reg_scale;
>> +	ap->ioaddr.device_addr	= base + io_offset + 6 * reg_scale;
>> +	ap->ioaddr.status_addr	= base + io_offset + 7 * reg_scale;
>> +	ap->ioaddr.command_addr	= base + io_offset + 7 * reg_scale;
>> +
>> +	ap->ioaddr.altstatus_addr	= ctl_base + io_offset;
>> +	ap->ioaddr.ctl_addr		= ctl_base + io_offset;
>>
>>  	irq_res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
>>  	if (irq_res && irq_res->start > 0) {
>>
