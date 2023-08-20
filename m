Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 613DFEE4996
	for <linux-ide@archiver.kernel.org>; Sun, 20 Aug 2023 19:32:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231688AbjHTTcX (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sun, 20 Aug 2023 15:32:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231547AbjHTTcW (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sun, 20 Aug 2023 15:32:22 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13488D2;
        Sun, 20 Aug 2023 12:27:30 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-68a3582c04fso304023b3a.1;
        Sun, 20 Aug 2023 12:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692559649; x=1693164449;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GDx3M/AUex6SFUzProObi2gWnZJUbeoEW1c09YhhQU8=;
        b=HvbNpGD+wkrNw1GSfUrDj4PoActWy9FKoKR1FYppwgsHUJmMn9sop9cngX1gXxGyxe
         cgPDFZZjjvc+i5Z+dyTG7I2qPhpgT8w4wVAwCNPAHC+nwLGD+PpEUk7DGYjoqTVr+OWN
         mfygck9caEgNT87sEx0j98IxnT9p3GqXY/+6exIjt3wrobYxMvsFdDg6fmesPUdE12by
         TydFxJJYBJBQrM6szDLqlRrWm2Af23o8jpfeWsEbXv+RJiHgNUifAMJ/9G2q158Opc9w
         ox5ozfD6c26G8k95IgAhu1GGeryYxifsiA4YT+Njoxqih/4tp7Ol7FL3jxsUx0SNAXCI
         /wyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692559649; x=1693164449;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GDx3M/AUex6SFUzProObi2gWnZJUbeoEW1c09YhhQU8=;
        b=g/DmH5aBV0fZ+i6rLgXbRmoQ/PFGfOKa1Q2nl1Iju85xKJKoGasIH/euLFSCYMBlaB
         X5tJePIv9155s/IEliR9fB2aPXlcucReY7Ec9bTiT5o1RgENdMC3vfsgjz8glYsqCmsi
         NrnXkoKZc4nxnNISn2x08MO0ZMW82aPI9jIxeo5Xd9Kra30HveX57gfV26N1dDm1zIIL
         5VXS9HxZCszqnZBhtDaHZ23BZgogaRGE2/8nfgmV3zkojAohf9IkJ5aiWUVJjQbVGfZA
         f2E2Ls3OXzcom3xn6DBMlk8ST9k17DaR82xwa5vXSR68BR/0KsuyBfbNlGLRGRgYL7Cc
         UmEw==
X-Gm-Message-State: AOJu0Yw0/Y4fVQKp8EEoSwk6m2tXs9rDjpuEHi82dJafzNdjjWJ1cd42
        Rc5XHhF6IpMUqZgM7JqAOPo=
X-Google-Smtp-Source: AGHT+IHK8OLwFt3l2TV9jfi4cPhfXy4UakC0u5ut6nJaB83rzJrge9yXeQEg3lH3R0pPptof9V0wdA==
X-Received: by 2002:a05:6a00:21d5:b0:68a:45a1:c0e1 with SMTP id t21-20020a056a0021d500b0068a45a1c0e1mr1071445pfj.0.1692559649443;
        Sun, 20 Aug 2023 12:27:29 -0700 (PDT)
Received: from ?IPV6:2001:df0:0:200c:fc82:cbbc:8740:8921? ([2001:df0:0:200c:fc82:cbbc:8740:8921])
        by smtp.gmail.com with ESMTPSA id z7-20020aa791c7000000b00684b64da08bsm4766063pfa.132.2023.08.20.12.27.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Aug 2023 12:27:29 -0700 (PDT)
Message-ID: <5e5217a4-837c-fac8-246c-15f8a2d46bfe@gmail.com>
Date:   Mon, 21 Aug 2023 07:27:23 +1200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 2/3] m68k/q40: add data_swab option for pata_falcon to
 byte-swap disk data
Content-Language: en-US
To:     Sergey Shtylyov <s.shtylyov@omp.ru>, linux-ide@vger.kernel.org,
        linux-m68k@vger.kernel.org
Cc:     will@sowerbutts.com, rz@linux-m68k.org, geert@linux-m68k.org,
        Finn Thain <fthain@linux-m68k.org>
References: <20230817221232.22035-1-schmitzmic@gmail.com>
 <20230817221232.22035-3-schmitzmic@gmail.com>
 <3af82526-1b8f-87bd-b936-9171e4d821df@omp.ru>
From:   Michael Schmitz <schmitzmic@gmail.com>
In-Reply-To: <3af82526-1b8f-87bd-b936-9171e4d821df@omp.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Hi Sergey,

thanks for reviewing - this has mostly been addressed in v2 or v3 (which 
I forgot to send to you, sorry). Damien asked for the patch title to be 
changed (now 'ata: pata_falcon: add data_swab option to byte-swap disk 
data) so you might have missed it on the list.

On 21/08/23 06:07, Sergey Shtylyov wrote:
> On 8/18/23 1:12 AM, Michael Schmitz wrote:
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
>>   drivers/ata/pata_falcon.c | 26 +++++++++++++++++++++++++-
>>   1 file changed, 25 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/ata/pata_falcon.c b/drivers/ata/pata_falcon.c
>> index 346259e3bbc8..90488f565d6f 100644
>> --- a/drivers/ata/pata_falcon.c
>> +++ b/drivers/ata/pata_falcon.c
>> @@ -33,6 +33,16 @@
>>   #define DRV_NAME "pata_falcon"
>>   #define DRV_VERSION "0.1.0"
>>   
>> +static int pata_falcon_swap_mask;
>> +
>> +module_param_named(data_swab, pata_falcon_swap_mask, int, 0444);
>> +MODULE_PARM_DESC(data_swab, "Data byte swap enable/disable bitmap (0x1==drive1, 0x2==drive2, 0x4==drive3, 0x8==drive4, default==0)");
>     Hm, Greg KH keeps saying us that the module parameters belong to '90s. :-)
What else can I use that would allow setting a driver parameter at boot 
time? This driver will be built-in pretty much all the time.
>
> [...]
>> @@ -44,13 +54,15 @@ static unsigned int pata_falcon_data_xfer(struct ata_queued_cmd *qc,
>>   	struct ata_device *dev = qc->dev;
>>   	struct ata_port *ap = dev->link->ap;
>>   	void __iomem *data_addr = ap->ioaddr.data_addr;
>> +	struct pata_falcon_priv *priv = ap->private_data;
>>   	unsigned int words = buflen >> 1;
>>   	struct scsi_cmnd *cmd = qc->scsicmd;
>> +	int dev_id = dev->devno;
>     You hardly need this variable...
Fixed in v3.
>
>>   	bool swap = 1;
>>   
>>   	if (dev->class == ATA_DEV_ATA && cmd &&
>>   	    !blk_rq_is_passthrough(scsi_cmd_to_rq(cmd)))
>> -		swap = 0;
>> +		swap = priv->swap_data && (priv->swap_mask & BIT(dev_id));
>     This looks convoluted -- only the 2nd subexpression should be enough...
Pointless attempt at optimizing this for the default case. Gone now.
>
> [...]
>> @@ -165,6 +178,13 @@ static int __init pata_falcon_init_one(struct platform_device *pdev)
>>   	ap->pio_mask = ATA_PIO4;
>>   	ap->flags |= ATA_FLAG_SLAVE_POSS | ATA_FLAG_NO_IORDY;
>>   
>> +	priv = devm_kzalloc(&pdev->dev,
>> +		sizeof(struct pata_falcon_priv), GFP_KERNEL);
>     sizeof(*priv) is preferred IIRC...
>
>> +	if (!priv)
>> +		return -ENOMEM;
>> +
>> +	ap->private_data = priv;
>     Also you hardly need a heap allocation -- encoding your couple flags
> could use the ap->private_data itself...

That's what Finn suggested as well - changed in v2.

Cheers,

     Michael

>
> [...]
>
> MBR, Sergey
