Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95E51C71136
	for <linux-ide@archiver.kernel.org>; Fri, 18 Aug 2023 03:09:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357430AbjHRDJV (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 17 Aug 2023 23:09:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343839AbjHRDIn (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 17 Aug 2023 23:08:43 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47F863A8B;
        Thu, 17 Aug 2023 20:08:39 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1bf3a2f44ffso1381445ad.1;
        Thu, 17 Aug 2023 20:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692328119; x=1692932919;
        h=content-transfer-encoding:in-reply-to:mime-version:user-agent:date
         :message-id:from:cc:references:to:subject:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1x/LxOjE9ZdZqh9bZjLl2/cPAjvqFFkZgzei3We2v1E=;
        b=UQyptG+qqECKhAOzwWIq0mWBa4biD/OEFDskAuDiQwgp0vper/IUwmLykobMLfuLDa
         bz/CJIAIWfmbqk88BsZOidwBvkOQaxMiy6WgZtSLSpTvJiOHoIfy6UyqZKFLrNKm96c9
         UANQFIQU/Dg5XHLiKwzyYiWOzC8nhk/XAialDm5HyV7bLlR1+MOa6nf9c3mVWO+binOW
         OoJyjRqhwG8p9aHwtZW6O7DqbeF6eAW0KlTqsHPpuCL1Gw5omwJeAruPscMh+rnTHKhe
         Mru/k+FyluPfWKIm0hD90rU7uPAkUo7UGCa3bkiUsnS55H4fFFw3qGuDQxrPih7RXHLh
         28Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692328119; x=1692932919;
        h=content-transfer-encoding:in-reply-to:mime-version:user-agent:date
         :message-id:from:cc:references:to:subject:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1x/LxOjE9ZdZqh9bZjLl2/cPAjvqFFkZgzei3We2v1E=;
        b=FGG8yySuS0hTXMxVgj43AHmeCyKv/YD7nTicvHwecTo5HHXOsU6V8x6UuO0I2F7Qrw
         ASnuxsOvRzfmX/3h/vHieV/AWsxmXRReNauaw7YlcZ1N2aZGHQznHE7BBDv75tVDthul
         v0FtpmyU9Y2SMNXEkayamNvUITPKo+oXJpdVJ3W71C1Q+SUl5eZkrl1t6BaB0Zr4sh2q
         7ABjnyZNndulbZ0VDbY+xyItBRIBUQUmkRJGhX6E6E1JqsUymnxqSfA6vVy10YjrCWyr
         GBdACnfmFmtWPqzBrU+2aRPfDU6KsAScADX/K7dWbfX5QNLbXxj/wsC/JE0IxCs0i7Zi
         DZ3Q==
X-Gm-Message-State: AOJu0YwqHm/fso0NCD37eVALXLaOY43CphODpajdgs0tWYD1E0QMJblX
        KIYPiYvp7Z6ASUq8OZTUtq3B2EvgmJU=
X-Google-Smtp-Source: AGHT+IGeXHb9fKhBbZDcsKXjd6q9mIvq2gvc+3p8o8LhWrqJ+ENr8LudlBT170kieJU+AJp6r7GVJg==
X-Received: by 2002:a17:902:eb49:b0:1bc:671d:6d31 with SMTP id i9-20020a170902eb4900b001bc671d6d31mr1287536pli.3.1692328118686;
        Thu, 17 Aug 2023 20:08:38 -0700 (PDT)
Received: from [10.1.1.24] (122-62-141-252-fibre.sparkbb.co.nz. [122.62.141.252])
        by smtp.gmail.com with ESMTPSA id d7-20020a170902cec700b001bc45408d26sm504356plg.36.2023.08.17.20.08.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Aug 2023 20:08:38 -0700 (PDT)
Subject: Re: [PATCH 2/3] m68k/q40: add data_swab option for pata_falcon to
 byte-swap disk data
To:     Damien Le Moal <dlemoal@kernel.org>, s.shtylyov@omp.ru,
        linux-ide@vger.kernel.org, linux-m68k@vger.kernel.org
References: <20230817221232.22035-1-schmitzmic@gmail.com>
 <20230817221232.22035-3-schmitzmic@gmail.com>
 <a09f4d25-55c7-b93c-94cb-d0f74d3bb84d@kernel.org>
Cc:     will@sowerbutts.com, rz@linux-m68k.org, geert@linux-m68k.org,
        Finn Thain <fthain@linux-m68k.org>
From:   Michael Schmitz <schmitzmic@gmail.com>
Message-ID: <390a202a-c448-3945-ced0-c1c2b4657e27@gmail.com>
Date:   Fri, 18 Aug 2023 15:08:31 +1200
User-Agent: Mozilla/5.0 (X11; Linux ppc; rv:45.0) Gecko/20100101
 Icedove/45.4.0
MIME-Version: 1.0
In-Reply-To: <a09f4d25-55c7-b93c-94cb-d0f74d3bb84d@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Hi Damien,

thanks for the review ...

Am 18.08.2023 um 12:51 schrieb Damien Le Moal:
> On 2023/08/18 7:12, Michael Schmitz wrote:
>> Some users of pata_falcon on Q40 have IDE disks in default
>> IDE little endian byte order, whereas legacy disks use
>> host-native big-endian byte order as on the Atari Falcon.
>>
>> Add module parameter 'data_swab' to allow connecting drives
>> with non-native data byte order. Drives selected by the
>> data_swap bit mask will have their user data byte-swapped to
>> host byte order, i.e. 'pata_falcon.data_swab=2' will byte-swap
>> all user data on drive B, leaving data on drive A in native
>> byte order. On Q40, drives on a second IDE interface may be
>> added to the bit mask as bits 2 and 3.
>>
>> Default setting is no byte swapping, i.e. compatibility with
>> the native Falcon or Q40 operating system disk format.
>>
>> Cc: William R Sowerbutts <will@sowerbutts.com>
>> Cc: Finn Thain <fthain@linux-m68k.org>
>> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
>> Signed-off-by: Michael Schmitz <schmitzmic@gmail.com>
>>
>> ---
>>
>> Changes since RFC v4:
>>
>> Geert Uytterhoeven:
>> - don't shift static module parameter for drive 3/4 bitmask
>> - simplify bit mask calculation to always use pdev->id
>>
>> Finn Thain:
>> - correct bit numbers for drive 3/4
>>
>> Changes since RFC v3:
>>
>> - split off this byte swap handling into separate patch
>>
>> - add hint regarding third and fourth drive on Q40
>>
>> Finn Thain:
>> - rename module parameter to 'data_swab' to better reflect its use
>>
>> William Sowerbutts:
>> - correct IDE drive number used in data swap conditional
>> ---
>>  drivers/ata/pata_falcon.c | 26 +++++++++++++++++++++++++-
>>  1 file changed, 25 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/ata/pata_falcon.c b/drivers/ata/pata_falcon.c
>> index 346259e3bbc8..90488f565d6f 100644
>> --- a/drivers/ata/pata_falcon.c
>> +++ b/drivers/ata/pata_falcon.c
>> @@ -33,6 +33,16 @@
>>  #define DRV_NAME "pata_falcon"
>>  #define DRV_VERSION "0.1.0"
>>
>> +static int pata_falcon_swap_mask;
>> +
>> +module_param_named(data_swab, pata_falcon_swap_mask, int, 0444);
>> +MODULE_PARM_DESC(data_swab, "Data byte swap enable/disable bitmap (0x1==drive1, 0x2==drive2, 0x4==drive3, 0x8==drive4, default==0)");
>> +
>> +struct pata_falcon_priv {
>> +	unsigned int swap_mask;
>> +	bool swap_data;
>> +};
>> +
>>  static const struct scsi_host_template pata_falcon_sht = {
>>  	ATA_PIO_SHT(DRV_NAME),
>>  };
>> @@ -44,13 +54,15 @@ static unsigned int pata_falcon_data_xfer(struct ata_queued_cmd *qc,
>>  	struct ata_device *dev = qc->dev;
>>  	struct ata_port *ap = dev->link->ap;
>>  	void __iomem *data_addr = ap->ioaddr.data_addr;
>> +	struct pata_falcon_priv *priv = ap->private_data;
>>  	unsigned int words = buflen >> 1;
>>  	struct scsi_cmnd *cmd = qc->scsicmd;
>> +	int dev_id = dev->devno;
>>  	bool swap = 1;
>>
>>  	if (dev->class == ATA_DEV_ATA && cmd &&
>>  	    !blk_rq_is_passthrough(scsi_cmd_to_rq(cmd)))
>> -		swap = 0;
>> +		swap = priv->swap_data && (priv->swap_mask & BIT(dev_id));
>>
>>  	/* Transfer multiple of 2 bytes */
>>  	if (rw == READ) {
>> @@ -123,6 +135,7 @@ static int __init pata_falcon_init_one(struct platform_device *pdev)
>>  	struct resource *base_res, *ctl_res, *irq_res;
>>  	struct ata_host *host;
>>  	struct ata_port *ap;
>> +	struct pata_falcon_priv *priv;
>>  	void __iomem *base, *ctl_base;
>>  	int irq = 0, io_offset = 1, reg_scale = 4;
>>
>> @@ -165,6 +178,13 @@ static int __init pata_falcon_init_one(struct platform_device *pdev)
>>  	ap->pio_mask = ATA_PIO4;
>>  	ap->flags |= ATA_FLAG_SLAVE_POSS | ATA_FLAG_NO_IORDY;
>>
>> +	priv = devm_kzalloc(&pdev->dev,
>> +		sizeof(struct pata_falcon_priv), GFP_KERNEL);
>> +	if (!priv)
>> +		return -ENOMEM;
>> +
>> +	ap->private_data = priv;
>> +
>>  	/* N.B. this assumes data_addr will be used for word-sized I/O only */
>>  	ap->ioaddr.data_addr = (void __iomem *)base_mem_res->start;
>>
>> @@ -199,6 +219,10 @@ static int __init pata_falcon_init_one(struct platform_device *pdev)
>>  	ap->ioaddr.altstatus_addr	= ctl_base + io_offset;
>>  	ap->ioaddr.ctl_addr		= ctl_base + io_offset;
>>
>> +	priv->swap_mask = pata_falcon_swap_mask >> (2 * pdev->id);
>
> I do not understand the shift here. It seems that it will lead to
> priv->swap_mask always being 0...

On Q40, it is possible to have two ISA IDE adapters, and two platform 
devices are defined (in arch/m68k/q40/config.c) One will have 
pdev->id==0, the other will have pdev->id==1.

In the pdev->id==0 case, there's no shift of the bit mask passed in as 
module parameter, so the data transfer function will examine bits 0 and 
1. That case we've verified in testing.
In the other case, we shift down by two bits, so the data transfer 
function will now examine bits 2 and 3 from the module parameter.

>
>> +	if (priv->swap_mask)
>> +		priv->swap_data = 1;
>
> I do not understand why priv->swap_data is needed, given that it is set to 1 if
> priv->swap_mask != 0, the above:
>
> 	swap = priv->swap_data && (priv->swap_mask & BIT(dev_id));
>
> should be equivalent to the simpler:
>
> 	swap = priv->swap_mask & BIT(dev_id);
>
> No ? Am I missing something ?

I had hoped to avoid the pointer dereference and bit shift in the 
default (and by far most common) case where none of the bits are set.

Compared to the simpler version, I actually just save the bit shift, so 
it's probably a pointless optimization.

Finn had suggested to simplify this even further, and use ap->private as 
bit mask directly (saving the kzalloc()). If you're OK with that, I'll 
change the code accordingly.

Cheers,

	Michael


>> +
>>  	irq_res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
>>  	if (irq_res && irq_res->start > 0) {
>>  		irq = irq_res->start;
>
