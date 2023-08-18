Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7FA9C2FC0E
	for <linux-ide@archiver.kernel.org>; Fri, 18 Aug 2023 00:53:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236540AbjHRAwc (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 17 Aug 2023 20:52:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232726AbjHRAwB (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 17 Aug 2023 20:52:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B7A230F5;
        Thu, 17 Aug 2023 17:51:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8E8BB62C36;
        Fri, 18 Aug 2023 00:51:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED652C433C7;
        Fri, 18 Aug 2023 00:51:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692319917;
        bh=FF17sTLP39FZ2JBb6qsdm2VzZSvmUnrgqamm41Hv4iI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=UQJv9pvAWmqleSJAJ+3ZWqzwDLbZyydVWsPgtxVRt64K7Nq/vx5Mzh+g3A8fEzhSd
         /J5roo/RAzP8MbSY51REKV0itoP/7qg/wz2rjobXuoEiOZROsTXnTohss0iaeMV5N8
         BPCTo2VL1Iw7YVjqseoQTU0R/KYur5x5AB31roU5Vbv5TZI+YxzxtWU63EmJ3A9bst
         inkL0kLI7doCFPX0AMF4MgDQST6In1YQx0KdsLGLp3VGmk9Z1kAJNWLswkX/TWpcn9
         pwcE1tX3Th/QLO9ZpN0AOPSXAnBfjXzj7fj0wtB5DmzzVeDY69kUz0aUvTQ2MNfJcV
         RkSPm5M8kPoTg==
Message-ID: <a09f4d25-55c7-b93c-94cb-d0f74d3bb84d@kernel.org>
Date:   Fri, 18 Aug 2023 09:51:55 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH 2/3] m68k/q40: add data_swab option for pata_falcon to
 byte-swap disk data
Content-Language: en-US
To:     Michael Schmitz <schmitzmic@gmail.com>, s.shtylyov@omp.ru,
        linux-ide@vger.kernel.org, linux-m68k@vger.kernel.org
Cc:     will@sowerbutts.com, rz@linux-m68k.org, geert@linux-m68k.org,
        Finn Thain <fthain@linux-m68k.org>
References: <20230817221232.22035-1-schmitzmic@gmail.com>
 <20230817221232.22035-3-schmitzmic@gmail.com>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230817221232.22035-3-schmitzmic@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 2023/08/18 7:12, Michael Schmitz wrote:
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
> +
> +struct pata_falcon_priv {
> +	unsigned int swap_mask;
> +	bool swap_data;
> +};
> +
>  static const struct scsi_host_template pata_falcon_sht = {
>  	ATA_PIO_SHT(DRV_NAME),
>  };
> @@ -44,13 +54,15 @@ static unsigned int pata_falcon_data_xfer(struct ata_queued_cmd *qc,
>  	struct ata_device *dev = qc->dev;
>  	struct ata_port *ap = dev->link->ap;
>  	void __iomem *data_addr = ap->ioaddr.data_addr;
> +	struct pata_falcon_priv *priv = ap->private_data;
>  	unsigned int words = buflen >> 1;
>  	struct scsi_cmnd *cmd = qc->scsicmd;
> +	int dev_id = dev->devno;
>  	bool swap = 1;
>  
>  	if (dev->class == ATA_DEV_ATA && cmd &&
>  	    !blk_rq_is_passthrough(scsi_cmd_to_rq(cmd)))
> -		swap = 0;
> +		swap = priv->swap_data && (priv->swap_mask & BIT(dev_id));
>  
>  	/* Transfer multiple of 2 bytes */
>  	if (rw == READ) {
> @@ -123,6 +135,7 @@ static int __init pata_falcon_init_one(struct platform_device *pdev)
>  	struct resource *base_res, *ctl_res, *irq_res;
>  	struct ata_host *host;
>  	struct ata_port *ap;
> +	struct pata_falcon_priv *priv;
>  	void __iomem *base, *ctl_base;
>  	int irq = 0, io_offset = 1, reg_scale = 4;
>  
> @@ -165,6 +178,13 @@ static int __init pata_falcon_init_one(struct platform_device *pdev)
>  	ap->pio_mask = ATA_PIO4;
>  	ap->flags |= ATA_FLAG_SLAVE_POSS | ATA_FLAG_NO_IORDY;
>  
> +	priv = devm_kzalloc(&pdev->dev,
> +		sizeof(struct pata_falcon_priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	ap->private_data = priv;
> +
>  	/* N.B. this assumes data_addr will be used for word-sized I/O only */
>  	ap->ioaddr.data_addr = (void __iomem *)base_mem_res->start;
>  
> @@ -199,6 +219,10 @@ static int __init pata_falcon_init_one(struct platform_device *pdev)
>  	ap->ioaddr.altstatus_addr	= ctl_base + io_offset;
>  	ap->ioaddr.ctl_addr		= ctl_base + io_offset;
>  
> +	priv->swap_mask = pata_falcon_swap_mask >> (2 * pdev->id);

I do not understand the shift here. It seems that it will lead to
priv->swap_mask always being 0...

> +	if (priv->swap_mask)
> +		priv->swap_data = 1;

I do not understand why priv->swap_data is needed, given that it is set to 1 if
priv->swap_mask != 0, the above:

	swap = priv->swap_data && (priv->swap_mask & BIT(dev_id));

should be equivalent to the simpler:

	swap = priv->swap_mask & BIT(dev_id);

No ? Am I missing something ?

> +
>  	irq_res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
>  	if (irq_res && irq_res->start > 0) {
>  		irq = irq_res->start;

-- 
Damien Le Moal
Western Digital Research

