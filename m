Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87990EE49A6
	for <linux-ide@archiver.kernel.org>; Sun, 20 Aug 2023 18:11:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231149AbjHTSLr (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sun, 20 Aug 2023 14:11:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231603AbjHTSLm (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sun, 20 Aug 2023 14:11:42 -0400
Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C0061A3;
        Sun, 20 Aug 2023 11:07:44 -0700 (PDT)
Received: from [192.168.1.103] (178.176.72.174) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.986.14; Sun, 20 Aug
 2023 21:07:37 +0300
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
Subject: Re: [PATCH 2/3] m68k/q40: add data_swab option for pata_falcon to
 byte-swap disk data
To:     Michael Schmitz <schmitzmic@gmail.com>,
        <linux-ide@vger.kernel.org>, <linux-m68k@vger.kernel.org>
CC:     <will@sowerbutts.com>, <rz@linux-m68k.org>, <geert@linux-m68k.org>,
        Finn Thain <fthain@linux-m68k.org>
References: <20230817221232.22035-1-schmitzmic@gmail.com>
 <20230817221232.22035-3-schmitzmic@gmail.com>
Organization: Open Mobile Platform
Message-ID: <3af82526-1b8f-87bd-b936-9171e4d821df@omp.ru>
Date:   Sun, 20 Aug 2023 21:07:36 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20230817221232.22035-3-schmitzmic@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [178.176.72.174]
X-ClientProxiedBy: msexch01.omp.ru (10.188.4.12) To msexch01.omp.ru
 (10.188.4.12)
X-KSE-ServerInfo: msexch01.omp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 5.9.59, Database issued on: 08/20/2023 17:50:47
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 59
X-KSE-AntiSpam-Info: Lua profiles 179340 [Aug 20 2023]
X-KSE-AntiSpam-Info: Version: 5.9.59.0
X-KSE-AntiSpam-Info: Envelope from: s.shtylyov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 526 526 7a6a9b19f6b9b3921b5701490f189af0e0cd5310
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_phishing_log_reg_50_60}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: {relay has no DNS name}
X-KSE-AntiSpam-Info: {SMTP from is not routable}
X-KSE-AntiSpam-Info: 178.176.72.174:7.1.2;127.0.0.199:7.1.2;omp.ru:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1
X-KSE-AntiSpam-Info: FromAlignment: s
X-KSE-AntiSpam-Info: {rdns complete}
X-KSE-AntiSpam-Info: {fromrtbl complete}
X-KSE-AntiSpam-Info: ApMailHostAddress: 178.176.72.174
X-KSE-AntiSpam-Info: Rate: 59
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=none header.from=omp.ru;spf=none
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 08/20/2023 17:55:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 8/20/2023 4:53:00 PM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 8/18/23 1:12 AM, Michael Schmitz wrote:

> Some users of pata_falcon on Q40 have IDE disks in default
> IDE little endian byte order, whereas legacy disks use
> host-native big-endian byte order as on the Atari Falcon.
> 
> Add module parameter 'data_swab' to allow connecting drives
> with non-native data byte order. Drives selected by the
> data_swap bit mask will have their user data byte-swapped to
> host byte order, i.e. 'pata_falcon.data_swab=2' will byte-swap
> all user data on drive B, leaving data on drive A in native
> byte order. On Q40, drives on a second IDE interface may be
> added to the bit mask as bits 2 and 3.
> 
> Default setting is no byte swapping, i.e. compatibility with
> the native Falcon or Q40 operating system disk format.
> 
> Cc: William R Sowerbutts <will@sowerbutts.com>
> Cc: Finn Thain <fthain@linux-m68k.org>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Signed-off-by: Michael Schmitz <schmitzmic@gmail.com>
> 
> ---
> 
> Changes since RFC v4:
> 
> Geert Uytterhoeven:
> - don't shift static module parameter for drive 3/4 bitmask
> - simplify bit mask calculation to always use pdev->id
> 
> Finn Thain:
> - correct bit numbers for drive 3/4
> 
> Changes since RFC v3:
> 
> - split off this byte swap handling into separate patch
> 
> - add hint regarding third and fourth drive on Q40
> 
> Finn Thain:
> - rename module parameter to 'data_swab' to better reflect its use
> 
> William Sowerbutts:
> - correct IDE drive number used in data swap conditional
> ---
>  drivers/ata/pata_falcon.c | 26 +++++++++++++++++++++++++-
>  1 file changed, 25 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/ata/pata_falcon.c b/drivers/ata/pata_falcon.c
> index 346259e3bbc8..90488f565d6f 100644
> --- a/drivers/ata/pata_falcon.c
> +++ b/drivers/ata/pata_falcon.c
> @@ -33,6 +33,16 @@
>  #define DRV_NAME "pata_falcon"
>  #define DRV_VERSION "0.1.0"
>  
> +static int pata_falcon_swap_mask;
> +
> +module_param_named(data_swab, pata_falcon_swap_mask, int, 0444);
> +MODULE_PARM_DESC(data_swab, "Data byte swap enable/disable bitmap (0x1==drive1, 0x2==drive2, 0x4==drive3, 0x8==drive4, default==0)");

   Hm, Greg KH keeps saying us that the module parameters belong to '90s. :-)

[...]
> @@ -44,13 +54,15 @@ static unsigned int pata_falcon_data_xfer(struct ata_queued_cmd *qc,
>  	struct ata_device *dev = qc->dev;
>  	struct ata_port *ap = dev->link->ap;
>  	void __iomem *data_addr = ap->ioaddr.data_addr;
> +	struct pata_falcon_priv *priv = ap->private_data;
>  	unsigned int words = buflen >> 1;
>  	struct scsi_cmnd *cmd = qc->scsicmd;
> +	int dev_id = dev->devno;

   You hardly need this variable...

>  	bool swap = 1;
>  
>  	if (dev->class == ATA_DEV_ATA && cmd &&
>  	    !blk_rq_is_passthrough(scsi_cmd_to_rq(cmd)))
> -		swap = 0;
> +		swap = priv->swap_data && (priv->swap_mask & BIT(dev_id));

   This looks convoluted -- only the 2nd subexpression should be enough...

[...]
> @@ -165,6 +178,13 @@ static int __init pata_falcon_init_one(struct platform_device *pdev)
>  	ap->pio_mask = ATA_PIO4;
>  	ap->flags |= ATA_FLAG_SLAVE_POSS | ATA_FLAG_NO_IORDY;
>  
> +	priv = devm_kzalloc(&pdev->dev,
> +		sizeof(struct pata_falcon_priv), GFP_KERNEL);

   sizeof(*priv) is preferred IIRC...

> +	if (!priv)
> +		return -ENOMEM;
> +
> +	ap->private_data = priv;

   Also you hardly need a heap allocation -- encoding your couple flags
could use the ap->private_data itself...

[...]

MBR, Sergey
