Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FDE0EE498E
	for <linux-ide@archiver.kernel.org>; Fri, 18 Aug 2023 20:45:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380035AbjHRUpE (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 18 Aug 2023 16:45:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380052AbjHRUo5 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 18 Aug 2023 16:44:57 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7833E128;
        Fri, 18 Aug 2023 13:44:56 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-689f4fb1c29so947638b3a.0;
        Fri, 18 Aug 2023 13:44:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692391496; x=1692996296;
        h=content-transfer-encoding:in-reply-to:mime-version:user-agent:date
         :message-id:from:cc:references:to:subject:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ntLu2upKpToSGCHTiaMha+Y3DIqOU0uPDYwZobOUr6s=;
        b=cgkrZnNtGTgWpDMmma8GsKzgEDlYV0PbRjtydSbb3Y7yiclE8FcC8hGyoJSIJkTjLb
         gq/8LhHZPX97q1Iaae1Rs77Z077aho6vK+elTDPYH3q2JbJv3BL4+vMopvnWxAkQvcd1
         Dxshb6T1RT2tRd2ZYKm2Zg8mAMMKgW10q7FnlO+MAhLsc/nKULxD3pHF4M8hg8Gs+Rey
         zh3M+LPUnoyZDuw03LoglcqDJtRcyYVrgk+tnQNmJOZT/VF+k03d0hOc2W5VcCdD2KKA
         owFrs2ZdLl1qN+MijHaEkv9lKMNrpKQq6c2jfZbIXQKE9srDneO89IkS/EbtP5bhwJ+e
         f53Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692391496; x=1692996296;
        h=content-transfer-encoding:in-reply-to:mime-version:user-agent:date
         :message-id:from:cc:references:to:subject:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ntLu2upKpToSGCHTiaMha+Y3DIqOU0uPDYwZobOUr6s=;
        b=OqXCPCvVrG5P17qZ9dS74m2awvOKPqGVP/LH2ieoxw9wk2Ohig7Q/69Uuk9rFOnu9O
         D9qu12VgJ/oPw1pK9sDxazm9avMnHcNCOFamNLfFgu+m3506yv2SI6HHGcRVrRR7VJyE
         qaC3w8mL5a1wrKzI74aA5jv0dslJnWHRuJ4vduY4Fsewj7sypChTAoBgsoYlgr3MoMrz
         m6Ru3pp8Yrzy8iYNfwH42bbmgrtcsbybJff4DTn0ahCX24ihJOh3vCgiu/x6NayxwcgE
         eR/6pxaf0Dwe00tgK6+VzBJVpyjvt8XeCPuX3tTL4RwvelfXOLwWLeCB5uJBDWNQQpZj
         jg6g==
X-Gm-Message-State: AOJu0Yz1Do1Wa4T4+HTKs5V8yJsauS2x+Sct8vKR1IeeuA+HT9TJzwxp
        KJEUhFNByi4VNTmNJYBYms6xBh3N4KU=
X-Google-Smtp-Source: AGHT+IGyfB7M+KFGbreiO3sNNGtUGKogA3OOwnulAdObHsFSI8H7dgvCUiE1NeP8zMF9al0n5KNliA==
X-Received: by 2002:a05:6a00:180f:b0:688:5323:5692 with SMTP id y15-20020a056a00180f00b0068853235692mr488924pfa.5.1692391495787;
        Fri, 18 Aug 2023 13:44:55 -0700 (PDT)
Received: from [10.1.1.24] (122-62-141-252-fibre.sparkbb.co.nz. [122.62.141.252])
        by smtp.gmail.com with ESMTPSA id q16-20020a62ae10000000b00682b2fbd20fsm1933139pff.31.2023.08.18.13.44.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Aug 2023 13:44:55 -0700 (PDT)
Subject: Re: [PATCH v2 2/3] ata: pata_falcon: add data_swab option to
 byte-swap disk data
To:     Finn Thain <fthain@linux-m68k.org>
References: <20230818071405.28581-1-schmitzmic@gmail.com>
 <20230818071405.28581-3-schmitzmic@gmail.com>
 <16f01be8-de2e-4fb2-50c3-95f030e740ac@linux-m68k.org>
Cc:     dlemoal@kernel.org, linux-ide@vger.kernel.org,
        linux-m68k@vger.kernel.org, will@sowerbutts.com, rz@linux-m68k.org,
        geert@linux-m68k.org
From:   Michael Schmitz <schmitzmic@gmail.com>
Message-ID: <cf5b12be-7201-d361-2f42-4ca0308127f9@gmail.com>
Date:   Sat, 19 Aug 2023 08:44:47 +1200
User-Agent: Mozilla/5.0 (X11; Linux ppc; rv:45.0) Gecko/20100101
 Icedove/45.4.0
MIME-Version: 1.0
In-Reply-To: <16f01be8-de2e-4fb2-50c3-95f030e740ac@linux-m68k.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Hi Finn,

Am 18.08.2023 um 19:43 schrieb Finn Thain:
>
> On Fri, 18 Aug 2023, Michael Schmitz wrote:
>
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
>> Changes since v1:
>>
>> Damien Le Moal:
>> - change patch title
>> - drop swap_data flag
>>
>> Finn Thain:
>> - drop allocation of ap->private struct, use field as bitmask
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
>>  drivers/ata/pata_falcon.c | 10 +++++++++-
>>  1 file changed, 9 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/ata/pata_falcon.c b/drivers/ata/pata_falcon.c
>> index 346259e3bbc8..27443cb757de 100644
>> --- a/drivers/ata/pata_falcon.c
>> +++ b/drivers/ata/pata_falcon.c
>> @@ -33,6 +33,11 @@
>>  #define DRV_NAME "pata_falcon"
>>  #define DRV_VERSION "0.1.0"
>>
>> +static int pata_falcon_swap_mask;
>> +
>> +module_param_named(data_swab, pata_falcon_swap_mask, int, 0444);
>> +MODULE_PARM_DESC(data_swab, "Data byte swap enable/disable bitmap (0x1==drive1, 0x2==drive2, 0x4==drive3, 0x8==drive4, default==0)");
>> +
>>  static const struct scsi_host_template pata_falcon_sht = {
>>  	ATA_PIO_SHT(DRV_NAME),
>>  };
>> @@ -46,11 +51,12 @@ static unsigned int pata_falcon_data_xfer(struct ata_queued_cmd *qc,
>>  	void __iomem *data_addr = ap->ioaddr.data_addr;
>>  	unsigned int words = buflen >> 1;
>>  	struct scsi_cmnd *cmd = qc->scsicmd;
>> +	int dev_id = dev->devno;
>
> Is that variable really needed?

Not really, no.

>
>>  	bool swap = 1;
>>
>>  	if (dev->class == ATA_DEV_ATA && cmd &&
>>  	    !blk_rq_is_passthrough(scsi_cmd_to_rq(cmd)))
>> -		swap = 0;
>> +		swap = (uintptr_t)ap->private_data & BIT(dev_id);
>>
>>  	/* Transfer multiple of 2 bytes */
>>  	if (rw == READ) {
>> @@ -199,6 +205,8 @@ static int __init pata_falcon_init_one(struct platform_device *pdev)
>>  	ap->ioaddr.altstatus_addr	= ctl_base + io_offset;
>>  	ap->ioaddr.ctl_addr		= ctl_base + io_offset;
>>
>> +	ap->private_data = (void *)(uintptr_t)(pata_falcon_swap_mask >> (2 * pdev->id));
>> +
>
> My compiler doesn't need that extra type cast in there...

Geert's suggestion for 64 bit safety...

Cheers,

	Michael

>
>>  	irq_res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
>>  	if (irq_res && irq_res->start > 0) {
>>  		irq = irq_res->start;
>>
